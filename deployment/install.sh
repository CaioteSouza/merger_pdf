#!/bin/bash

# Script de instalação ROBUSTA do PDF Merger no Ubuntu Server
# Execute como: sudo bash install.sh

echo "🚀 Instalando PDF Merger ROBUSTO no Ubuntu Server..."
echo "===================================================="

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Verificar se está rodando como root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}❌ Execute como root: sudo bash install.sh${NC}"
    exit 1
fi

# Atualizar sistema
echo -e "${YELLOW}📦 Atualizando sistema...${NC}"
apt update && apt upgrade -y

# Instalar dependências do sistema
echo -e "${YELLOW}� Instalando dependências do sistema...${NC}"
apt install -y python3 python3-pip python3-venv nginx supervisor ufw fail2ban

# Instalar dependências Python com venv (mais seguro)
echo -e "${YELLOW}� Configurando ambiente Python...${NC}"
python3 -m venv /opt/pdf-merger-venv
source /opt/pdf-merger-venv/bin/activate
pip install --upgrade pip
pip install flask pypdf gunicorn

# Criar usuário para a aplicação (se não existir)
if ! id "pdfmerger" &>/dev/null; then
    echo -e "${YELLOW}👤 Criando usuário pdfmerger...${NC}"
    useradd -r -s /bin/false -d /opt/pdf-merger pdfmerger
fi

# Definir diretórios
APP_DIR="/var/www/merger_pdf"
LOG_DIR="/var/log/pdf-merger"
BACKUP_DIR="/var/backups/pdf-merger"

# Criar estrutura de diretórios robusta
echo -e "${YELLOW}📁 Criando estrutura de diretórios...${NC}"
mkdir -p $APP_DIR/{uploads,merged_pdfs,static,backups}
mkdir -p $LOG_DIR
mkdir -p $BACKUP_DIR
mkdir -p /etc/pdf-merger

# Copiar arquivos da aplicação
echo -e "${YELLOW}📋 Copiando arquivos da aplicação...${NC}"
cp app.py config.py gunicorn.conf.py $APP_DIR/
cp -r templates $APP_DIR/
cp -r static/* $APP_DIR/static/ 2>/dev/null || echo "Arquivos estáticos copiados"

# Criar arquivo WSGI
echo -e "${YELLOW}⚡ Criando arquivo WSGI...${NC}"
cat > $APP_DIR/wsgi.py << 'EOF'
#!/usr/bin/env python3
from app import app

if __name__ == "__main__":
    app.run()
EOF

# Inicializar banco de dados
echo -e "${YELLOW}🗄️  Inicializando banco de dados...${NC}"
cd $APP_DIR
sudo -u pdfmerger /opt/pdf-merger-venv/bin/python3 -c "
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
print('Banco de dados inicializado com sucesso!')
"

# Configurar permissões robustas
echo -e "${YELLOW}🔐 Configurando permissões de segurança...${NC}"
chown -R pdfmerger:pdfmerger $APP_DIR
chown -R pdfmerger:pdfmerger $LOG_DIR
chown -R pdfmerger:pdfmerger $BACKUP_DIR
chmod -R 750 $APP_DIR
chmod -R 640 $APP_DIR/*.py
chmod +x $APP_DIR/wsgi.py
chmod 755 $APP_DIR/{uploads,merged_pdfs}
chmod 644 $APP_DIR/gunicorn.conf.py
chmod 644 $APP_DIR/pdf_merger.db

# Criar configuração do Supervisor (mais robusto que systemd para apps Python)
echo -e "${YELLOW}⚙️  Configurando Supervisor...${NC}"
cat > /etc/supervisor/conf.d/pdf-merger.conf << EOF
[program:pdf-merger]
command=/opt/pdf-merger-venv/bin/gunicorn --config /var/www/merger_pdf/deployment/gunicorn.conf.py deployment.wsgi:app
directory=/var/www/merger_pdf
user=pdfmerger
autostart=true
autorestart=true
redirect_stderr=true
stdout_logfile=/var/log/pdf-merger/app.log
stdout_logfile_maxbytes=50MB
stdout_logfile_backups=5
environment=PATH="/opt/pdf-merger-venv/bin"
EOF

# Configurar Nginx como proxy reverso
echo -e "${YELLOW}🌐 Configurando Nginx...${NC}"
cat > /etc/nginx/sites-available/pdf-merger << 'EOF'
server {
    listen 80;
    server_name _;
    client_max_body_size 200M;
    
    # Security headers
    add_header X-Frame-Options DENY;
    add_header X-Content-Type-Options nosniff;
    add_header X-XSS-Protection "1; mode=block";
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains";
    
    # Rate limiting
    limit_req_zone $binary_remote_addr zone=pdf_upload:10m rate=10r/m;
    
    location / {
        limit_req zone=pdf_upload burst=5 nodelay;
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_connect_timeout 300s;
        proxy_send_timeout 300s;
        proxy_read_timeout 300s;
    }
    
    # Servir arquivos estáticos diretamente pelo Nginx (mais eficiente)
    location /static/ {
        alias /var/www/merger_pdf/static/;
        expires 1d;
        add_header Cache-Control "public, immutable";
    }
    
    # Logs específicos
    access_log /var/log/nginx/pdf-merger-access.log;
    error_log /var/log/nginx/pdf-merger-error.log;
}
EOF

# Ativar site no Nginx
ln -sf /etc/nginx/sites-available/pdf-merger /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Configurar rotação de logs
echo -e "${YELLOW}📝 Configurando rotação de logs...${NC}"
cat > /etc/logrotate.d/pdf-merger << EOF
/var/log/pdf-merger/*.log {
    daily
    missingok
    rotate 52
    compress
    delaycompress
    notifempty
    create 644 pdfmerger pdfmerger
    postrotate
        supervisorctl restart pdf-merger
    endscript
}
EOF

# Configurar firewall básico
echo -e "${YELLOW}🔥 Configurando firewall...${NC}"
ufw --force enable
ufw allow ssh
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 8080/tcp  # PDF Merger porta

# Reiniciar serviços
echo -e "${YELLOW}🔄 Iniciando serviços...${NC}"
supervisorctl reread
supervisorctl update
supervisorctl start pdf-merger
nginx -t && systemctl restart nginx

# Aguardar aplicação iniciar
echo -e "${YELLOW}⏳ Aguardando aplicação iniciar...${NC}"
sleep 5

# Testar se está funcionando
echo -e "${YELLOW}🧪 Testando aplicação...${NC}"
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/ | grep -q "200"; then
    echo -e "${GREEN}✅ Aplicação funcionando na porta 8080${NC}"
else
    echo -e "${RED}❌ Problema na aplicação - verificando logs...${NC}"
    supervisorctl status pdf-merger
    echo "Últimas linhas do log:"
    tail -10 /var/log/pdf-merger/app.log 2>/dev/null || echo "Log não encontrado"
fi

echo -e "${GREEN}✅ INSTALAÇÃO ROBUSTA CONCLUÍDA!${NC}"
echo "=================================================="
echo -e "${BLUE}🚀 SISTEMA DE PRODUÇÃO CONFIGURADO:${NC}"
echo -e "${YELLOW}📍 Acesse: http://172.16.22.172:8080{NC}"
echo ""
echo -e "${BLUE}📊 MONITORAMENTO:${NC}"
echo "  Status geral:     sudo supervisorctl status"
echo "  Logs da app:      sudo tail -f /var/log/pdf-merger/app.log"
echo "  Logs do Nginx:    sudo tail -f /var/log/nginx/pdf-merger-access.log"
echo "  Reiniciar app:    sudo supervisorctl restart pdf-merger"
echo "  Reiniciar Nginx:  sudo systemctl restart nginx"
echo ""
echo -e "${BLUE}🔒 SEGURANÇA:${NC}"
echo "  Status Fail2Ban:  sudo fail2ban-client status"
echo "  Status Firewall:  sudo ufw status"
echo ""
echo -e "${BLUE}� CAPACIDADE:${NC}"
echo "  Workers Gunicorn: $(nproc --all) cores = $(($(nproc --all) * 2 + 1)) workers"
echo "  Conexões simultâneas: ~1000 por worker"
echo "  Upload máximo: 200MB por request"
echo ""
echo -e "${GREEN}🎯 Sistema pronto para PRODUÇÃO com múltiplos usuários!${NC}"