#!/bin/bash

# Script de REINSTALAÇÃO COMPLETA do PDF Merger
# Execute como: sudo bash complete-reinstall.sh

echo "🔥 REINSTALAÇÃO COMPLETA DO PDF MERGER 🔥"
echo "========================================"

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${RED}⚠️  ATENÇÃO: Este script vai APAGAR TUDO e reinstalar!${NC}"
echo -e "${YELLOW}🔄 Continuando em 5 segundos... (Ctrl+C para cancelar)${NC}"
sleep 5

# 1. LIMPEZA COMPLETA
echo -e "\n${YELLOW}🧹 1. LIMPEZA COMPLETA...${NC}"

# Parar todos os serviços
echo "Parando serviços..."
sudo supervisorctl stop pdf-merger 2>/dev/null || true
sudo systemctl stop nginx 2>/dev/null || true

# Remover usuário e grupo
echo "Removendo usuário pdfmerger..."
sudo userdel -r pdfmerger 2>/dev/null || true

# Remover ambiente virtual
echo "Removendo ambiente virtual..."
sudo rm -rf /opt/pdf-merger-venv

# Remover logs
echo "Removendo logs..."
sudo rm -rf /var/log/pdf-merger

# Remover configurações do supervisor
echo "Removendo configurações do supervisor..."
sudo rm -f /etc/supervisor/conf.d/pdf-merger.conf

# Remover configurações do nginx
echo "Removendo configurações do nginx..."
sudo rm -f /etc/nginx/sites-enabled/pdf-merger
sudo rm -f /etc/nginx/sites-available/pdf-merger

# Recarregar supervisor
sudo supervisorctl reread 2>/dev/null || true
sudo supervisorctl update 2>/dev/null || true

# 2. BACKUP DO BANCO (SE EXISTIR)
echo -e "\n${YELLOW}💾 2. BACKUP DO BANCO DE DADOS...${NC}"
if [ -f "/var/www/merger_pdf/pdf_merger.db" ]; then
    sudo cp /var/www/merger_pdf/pdf_merger.db /tmp/pdf_merger_backup_$(date +%Y%m%d_%H%M%S).db
    echo -e "${GREEN}✅ Backup salvo em /tmp/${NC}"
fi

# 3. REMOVER PROJETO ATUAL
echo -e "\n${YELLOW}🗑️  3. REMOVENDO PROJETO ATUAL...${NC}"
cd /var/www/
sudo rm -rf merger_pdf/

# 4. CLONAR PROJETO ATUALIZADO
echo -e "\n${YELLOW}📦 4. CLONANDO PROJETO ATUALIZADO...${NC}"
sudo git clone https://github.com/CaioteSouza/merger_pdf.git
cd merger_pdf

# 5. EXECUTAR INSTALAÇÃO LIMPA
echo -e "\n${YELLOW}🚀 5. INSTALAÇÃO LIMPA...${NC}"
sudo bash deployment/install.sh

# 6. RESTAURAR BANCO (OPCIONAL)
echo -e "\n${YELLOW}💿 6. RESTAURAR BANCO DE DADOS?${NC}"
BACKUP_FILE=$(ls -t /tmp/pdf_merger_backup_*.db 2>/dev/null | head -1)
if [ -n "$BACKUP_FILE" ]; then
    echo -e "${BLUE}Backup encontrado: $BACKUP_FILE${NC}"
    read -p "Restaurar dados antigos? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo cp "$BACKUP_FILE" /var/www/merger_pdf/pdf_merger.db
        sudo chown pdfmerger:pdfmerger /var/www/merger_pdf/pdf_merger.db
        echo -e "${GREEN}✅ Dados restaurados!${NC}"
    fi
fi

# 7. TESTE FINAL
echo -e "\n${YELLOW}🧪 7. TESTE FINAL...${NC}"
echo "Aguardando aplicação inicializar..."
sleep 10

echo -e "\n${BLUE}📊 STATUS DOS SERVIÇOS:${NC}"
sudo supervisorctl status pdf-merger
sudo systemctl status nginx --no-pager -l

echo -e "\n${BLUE}🌐 TESTE DE CONECTIVIDADE:${NC}"
if curl -s -I http://localhost:8080 | head -1 | grep -q "200 OK"; then
    echo -e "${GREEN}✅ Aplicação respondendo na porta 8080!${NC}"
    echo -e "${GREEN}🎉 ACESSE: http://$(hostname -I | awk '{print $1}'):8080${NC}"
else
    echo -e "${RED}❌ Problema na aplicação${NC}"
fi

if curl -s -I http://localhost | head -1 | grep -q "200 OK"; then
    echo -e "${GREEN}✅ Nginx respondendo na porta 80!${NC}"
    echo -e "${GREEN}🎉 ACESSE: http://$(hostname -I | awk '{print $1}')${NC}"
else
    echo -e "${YELLOW}⚠️  Nginx não está respondendo (pode estar conflitando com Apache)${NC}"
fi

echo -e "\n${GREEN}🎉 REINSTALAÇÃO COMPLETA FINALIZADA!${NC}"
echo -e "${BLUE}📝 Para ver logs em tempo real: sudo tail -f /var/log/pdf-merger/app.log${NC}"
echo -e "${BLUE}🔧 Para monitoramento: cd /var/www/merger_pdf && sudo bash deployment/monitor.sh${NC}"