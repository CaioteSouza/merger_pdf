#!/bin/bash

# Script de diagnóstico e correção do PDF Merger
# Execute no servidor: bash fix-errors.sh

echo "🔧 DIAGNÓSTICO E CORREÇÃO - PDF Merger"
echo "======================================"

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Função para verificar se comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo -e "${YELLOW}🔍 Verificando problemas...${NC}"

# 1. Verificar se aplicação está rodando
echo "1. Verificando status da aplicação..."
if supervisorctl status pdf-merger 2>/dev/null | grep -q "RUNNING"; then
    echo -e "   ${GREEN}✅ Aplicação rodando${NC}"
else
    echo -e "   ${RED}❌ Aplicação não está rodando${NC}"
    echo -e "   ${YELLOW}🔧 Tentando iniciar...${NC}"
    supervisorctl start pdf-merger
fi

# 2. Verificar logs de erro
echo ""
echo "2. Verificando logs de erro..."
if [ -f "/var/log/pdf-merger/app.log" ]; then
    echo -e "${YELLOW}📝 Últimos erros encontrados:${NC}"
    tail -20 /var/log/pdf-merger/app.log | grep -i "error\|exception\|traceback" || echo "   Nenhum erro recente encontrado"
else
    echo -e "   ${RED}❌ Arquivo de log não encontrado${NC}"
fi

# 3. Verificar banco de dados
echo ""
echo "3. Verificando banco de dados..."
if [ -f "/opt/pdf-merger/pdf_merger.db" ]; then
    echo -e "   ${GREEN}✅ Banco de dados existe${NC}"
    # Testar se consegue conectar
    if sqlite3 /opt/pdf-merger/pdf_merger.db ".tables" >/dev/null 2>&1; then
        echo -e "   ${GREEN}✅ Banco de dados acessível${NC}"
    else
        echo -e "   ${RED}❌ Erro ao acessar banco de dados${NC}"
        echo -e "   ${YELLOW}🔧 Recriando banco...${NC}"
        cd /opt/pdf-merger
        sudo -u pdfmerger python3 -c "
import sqlite3
conn = sqlite3.connect('pdf_merger.db')
cursor = conn.cursor()
cursor.execute('''
    CREATE TABLE IF NOT EXISTS merged_pdfs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        filename TEXT NOT NULL,
        original_files TEXT NOT NULL,
        file_path TEXT NOT NULL,
        total_pages INTEGER NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        file_size INTEGER NOT NULL
    )
''')
conn.commit()
conn.close()
print('Banco criado com sucesso!')
"
    fi
else
    echo -e "   ${RED}❌ Banco de dados não existe${NC}"
    echo -e "   ${YELLOW}🔧 Criando banco...${NC}"
    cd /opt/pdf-merger
    sudo -u pdfmerger python3 -c "
import sqlite3
conn = sqlite3.connect('pdf_merger.db')
cursor = conn.cursor()
cursor.execute('''
    CREATE TABLE IF NOT EXISTS merged_pdfs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        filename TEXT NOT NULL,
        original_files TEXT NOT NULL,
        file_path TEXT NOT NULL,
        total_pages INTEGER NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        file_size INTEGER NOT NULL
    )
''')
conn.commit()
conn.close()
print('Banco criado com sucesso!')
"
fi

# 4. Verificar permissões
echo ""
echo "4. Verificando permissões..."
dirs=("/opt/pdf-merger/uploads" "/opt/pdf-merger/merged_pdfs" "/var/log/pdf-merger")
for dir in "${dirs[@]}"; do
    if [ -d "$dir" ]; then
        owner=$(stat -c "%U" "$dir")
        if [ "$owner" = "pdfmerger" ]; then
            echo -e "   ${GREEN}✅ $dir - permissões OK${NC}"
        else
            echo -e "   ${RED}❌ $dir - permissões incorretas${NC}"
            echo -e "   ${YELLOW}🔧 Corrigindo...${NC}"
            chown -R pdfmerger:pdfmerger "$dir"
        fi
    else
        echo -e "   ${RED}❌ $dir não existe${NC}"
        echo -e "   ${YELLOW}🔧 Criando...${NC}"
        mkdir -p "$dir"
        chown -R pdfmerger:pdfmerger "$dir"
    fi
done

# 5. Verificar dependências Python
echo ""
echo "5. Verificando dependências Python..."
cd /opt/pdf-merger
if /opt/pdf-merger-venv/bin/python3 -c "import flask, pypdf" 2>/dev/null; then
    echo -e "   ${GREEN}✅ Dependências OK${NC}"
else
    echo -e "   ${RED}❌ Dependências faltando${NC}"
    echo -e "   ${YELLOW}🔧 Instalando...${NC}"
    /opt/pdf-merger-venv/bin/pip install flask pypdf
fi

# 6. Testar aplicação diretamente
echo ""
echo "6. Testando aplicação..."
cd /opt/pdf-merger
timeout 10 sudo -u pdfmerger /opt/pdf-merger-venv/bin/python3 -c "
import app
print('Aplicação importada com sucesso!')
try:
    app.init_db()
    print('Banco inicializado com sucesso!')
except Exception as e:
    print(f'Erro ao inicializar banco: {e}')
" 2>&1

# 7. Verificar configuração do Nginx
echo ""
echo "7. Verificando Nginx..."
if nginx -t 2>/dev/null; then
    echo -e "   ${GREEN}✅ Configuração do Nginx OK${NC}"
else
    echo -e "   ${RED}❌ Erro na configuração do Nginx${NC}"
    echo -e "   ${YELLOW}🔧 Corrigindo...${NC}"
    # Corrigir o proxy_pass para usar 127.0.0.1 em vez do IP específico
    sed -i 's/proxy_pass http:\/\/[0-9.]*:8080;/proxy_pass http:\/\/127.0.0.1:8080;/' /etc/nginx/sites-available/pdf-merger
    nginx -t && systemctl reload nginx
fi

# 8. Reiniciar tudo
echo ""
echo -e "${YELLOW}🔄 Reiniciando serviços...${NC}"
supervisorctl restart pdf-merger
sleep 3

# 9. Verificar se está funcionando
echo ""
echo "9. Teste final..."
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/ | grep -q "200"; then
    echo -e "   ${GREEN}✅ Aplicação respondendo na porta 8080${NC}"
else
    echo -e "   ${RED}❌ Aplicação não responde na porta 8080${NC}"
fi

if curl -s -o /dev/null -w "%{http_code}" http://localhost/ | grep -q "200"; then
    echo -e "   ${GREEN}✅ Nginx funcionando${NC}"
else
    echo -e "   ${RED}❌ Nginx não está funcionando${NC}"
fi

echo ""
echo -e "${BLUE}📊 STATUS ATUAL:${NC}"
supervisorctl status pdf-merger
echo ""
echo -e "${YELLOW}📝 Para ver logs em tempo real:${NC}"
echo "sudo tail -f /var/log/pdf-merger/app.log"
echo ""
echo -e "${GREEN}🔧 Diagnóstico concluído!${NC}"