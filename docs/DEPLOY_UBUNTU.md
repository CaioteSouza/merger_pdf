# 🚀 **PDF Merger - Guia de Deploy para Desenvolvedores**

> **⚠️ IMPORTANTE**: Esta ferramenta foi desenvolvida especificamente para **Ubuntu Server**. Os scripts de deploy e produção não funcionam em Windows ou macOS.

---

## 🐧 **Requisitos do Sistema**

### ✅ **Sistemas Suportados**
- **Ubuntu 18.04+** (Testado e recomendado)
- **Ubuntu Server 20.04 LTS** (Produção ideal)
- **Ubuntu Server 22.04 LTS** (Mais recente)

### ❌ **Sistemas NÃO Suportados para Produção**
- **Windows** - Apenas desenvolvimento local
- **macOS** - Apenas desenvolvimento local  
- **CentOS/RHEL** - Scripts incompatíveis
- **Debian** - Parcialmente compatível (não testado)

### 📋 **Dependências Ubuntu**
```bash
# Pacotes que serão instalados automaticamente:
- Python 3.8+
- pip3
- nginx
- supervisor  
- sqlite3
- ufw (firewall)
- curl, wget, git
```

---

## 🚀 **Deploy Automático (Recomendado)**

### 1️⃣ **Instalação em Uma Linha**
```bash
# Download e execução automática
curl -sSL https://raw.githubusercontent.com/CaioteSouza/merger_pdf/master/deployment/install.sh | sudo bash
```

### 2️⃣ **O que Acontece Automaticamente**
```
🔄 Atualizando sistema Ubuntu
📦 Instalando Python 3 + pip
🐍 Criando ambiente virtual isolado
📥 Clonando repositório do GitHub
⚙️  Instalando dependências Python
👤 Criando usuário dedicado 'pdfmerger'
🗄️  Configurando banco SQLite
🔧 Configurando Supervisor (17 workers)
🔥 Configurando firewall UFW (porta 8080)
📊 Configurando logs rotativos
✅ Inicializando aplicação
```

### 3️⃣ **Verificação de Sucesso**
```bash
# Status da aplicação
sudo supervisorctl status pdf-merger

# Deve mostrar: RUNNING

# Testar acesso
curl http://localhost:8080
# Deve retornar HTML da página principal

# Verificar logs
sudo tail -f /var/log/pdf-merger/app.log
```

---

## 🔧 **Deploy Manual (Avançado)**

### 1️⃣ **Preparação do Sistema**
```bash
# Atualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependências
sudo apt install -y python3 python3-pip python3-venv nginx supervisor sqlite3 ufw git curl

# Criar usuário dedicado
sudo useradd -m -s /bin/bash pdfmerger
```

### 2️⃣ **Setup da Aplicação**
```bash
# Mudar para usuário dedicado
sudo su - pdfmerger

# Clonar repositório
git clone https://github.com/CaioteSouza/merger_pdf.git
cd merger_pdf

# Criar ambiente virtual
python3 -m venv .venv
source .venv/bin/activate

# Instalar dependências
pip install -r requirements.txt

# Testar aplicação
python app.py
# Ctrl+C para parar
```

### 3️⃣ **Configuração do Supervisor**
```bash
# Voltar para root
exit

# Copiar configuração
sudo cp /home/pdfmerger/merger_pdf/deployment/supervisor.conf /etc/supervisor/conf.d/pdf-merger.conf

# Recarregar Supervisor
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl start pdf-merger
```

### 4️⃣ **Configuração do Firewall**
```bash
# Habilitar UFW
sudo ufw enable

# Liberar porta 8080
sudo ufw allow 8080

# Liberar SSH (importante!)
sudo ufw allow ssh

# Verificar status
sudo ufw status
```

---

## 🌐 **Configuração Nginx (Opcional)**

### 1️⃣ **Configurar Proxy Reverso**
```bash
# Criar configuração
sudo nano /etc/nginx/sites-available/pdf-merger

# Conteúdo do arquivo:
server {
    listen 80;
    server_name seu-servidor.com;  # Altere para seu domínio
    
    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # Upload de arquivos grandes
        client_max_body_size 200M;
    }
}
```

### 2️⃣ **Ativar Site**
```bash
# Habilitar site
sudo ln -s /etc/nginx/sites-available/pdf-merger /etc/nginx/sites-enabled/

# Testar configuração
sudo nginx -t

# Reiniciar Nginx
sudo systemctl restart nginx

# Liberar porta 80 no firewall
sudo ufw allow 80
```

---

## 📊 **Monitoramento e Manutenção**

### 🔍 **Comandos de Monitoramento**
```bash
# Status geral da aplicação
sudo bash /home/pdfmerger/merger_pdf/deployment/monitor.sh

# Logs em tempo real
sudo tail -f /var/log/pdf-merger/app.log

# Logs de erro
sudo tail -f /var/log/pdf-merger/error.log

# Status do Supervisor
sudo supervisorctl status

# Processos Gunicorn
ps aux | grep gunicorn

# Uso de CPU e memória
htop
```

### 🔄 **Comandos de Controle**
```bash
# Reiniciar aplicação
sudo supervisorctl restart pdf-merger

# Parar aplicação
sudo supervisorctl stop pdf-merger

# Iniciar aplicação
sudo supervisorctl start pdf-merger

# Recarregar configuração
sudo supervisorctl reread && sudo supervisorctl update
```

### 🛠️ **Scripts de Correção**
```bash
# Diagnóstico completo
sudo bash /home/pdfmerger/merger_pdf/scripts/fix-errors.sh

# Reinstalação completa
sudo bash /home/pdfmerger/merger_pdf/scripts/complete-reinstall.sh

# Correção específica da aplicação
sudo bash /home/pdfmerger/merger_pdf/scripts/fix-app.sh

# Correção de navegação
sudo bash /home/pdfmerger/merger_pdf/scripts/fix-navigation.sh
```

---

## ⚙️ **Configurações Avançadas**

### 🔧 **Ajustar Performance**
```bash
# Editar configuração Gunicorn
sudo nano /home/pdfmerger/merger_pdf/deployment/gunicorn.conf.py

# Principais configurações:
workers = 17              # Número de workers (ajustar conforme CPU)
worker_class = "sync"     # Tipo de worker
timeout = 300             # Timeout em segundos
max_requests = 1000       # Requests por worker antes de restart
max_requests_jitter = 100 # Jitter para evitar restarts simultâneos
```

### 📁 **Ajustar Limites de Upload**
```bash
# Editar configuração da aplicação
sudo nano /home/pdfmerger/merger_pdf/config.py

# Principais configurações:
MAX_CONTENT_LENGTH = 200 * 1024 * 1024  # 200MB total
MAX_FILE_SIZE = 50 * 1024 * 1024         # 50MB por arquivo
UPLOAD_FOLDER = '/home/pdfmerger/merger_pdf/uploads'
MERGED_FOLDER = '/home/pdfmerger/merger_pdf/merged_pdfs'
```

### 🗄️ **Backup do Banco de Dados**
```bash
# Backup manual
sudo cp /home/pdfmerger/merger_pdf/pdf_merger.db /backup/pdf_merger_$(date +%Y%m%d).db

# Script automático de backup (adicionar ao cron)
sudo crontab -e

# Adicionar linha para backup diário às 2h:
0 2 * * * cp /home/pdfmerger/merger_pdf/pdf_merger.db /backup/pdf_merger_$(date +\%Y\%m\%d).db
```

---

## 🆘 **Troubleshooting Comum**

### ❌ **Problema: Aplicação não inicia**
```bash
# Verificar logs
sudo tail -100 /var/log/pdf-merger/error.log

# Verificar se porta está ocupada
sudo netstat -tlnp | grep :8080

# Verificar permissões
sudo chown -R pdfmerger:pdfmerger /home/pdfmerger/merger_pdf
```

### ❌ **Problema: Upload falha**
```bash
# Verificar espaço em disco
df -h

# Verificar permissões de pastas
ls -la /home/pdfmerger/merger_pdf/uploads/
ls -la /home/pdfmerger/merger_pdf/merged_pdfs/

# Recriar pastas se necessário
sudo mkdir -p /home/pdfmerger/merger_pdf/{uploads,merged_pdfs}
sudo chown pdfmerger:pdfmerger /home/pdfmerger/merger_pdf/{uploads,merged_pdfs}
```

### ❌ **Problema: Performance lenta**
```bash
# Verificar recursos do sistema
htop
free -h
iostat

# Ajustar número de workers
sudo nano /home/pdfmerger/merger_pdf/deployment/gunicorn.conf.py
# workers = número_de_cpus * 2 + 1

# Reiniciar aplicação
sudo supervisorctl restart pdf-merger
```

### ❌ **Problema: Acesso externo bloqueado**
```bash
# Verificar firewall
sudo ufw status

# Liberar porta se necessário
sudo ufw allow 8080

# Verificar se aplicação escuta em todas as interfaces
sudo netstat -tlnp | grep :8080
# Deve mostrar 0.0.0.0:8080, não 127.0.0.1:8080
```

---

## 🔄 **Atualizações da Aplicação**

### 📥 **Atualizar Código**
```bash
# Entrar no diretório
cd /home/pdfmerger/merger_pdf

# Fazer backup do banco
cp pdf_merger.db pdf_merger_backup_$(date +%Y%m%d).db

# Atualizar código
git pull origin master

# Reinstalar dependências se necessário
source .venv/bin/activate
pip install -r requirements.txt

# Reiniciar aplicação
sudo supervisorctl restart pdf-merger
```

### 📊 **Verificar Logs Após Atualização**
```bash
# Monitorar logs por 1 minuto
sudo timeout 60 tail -f /var/log/pdf-merger/app.log

# Testar funcionalidade
curl -I http://localhost:8080
```

---

## 📞 **Suporte Técnico**

### 🔧 **Informações para Diagnóstico**
```bash
# Gerar relatório completo do sistema
sudo bash /home/pdfmerger/merger_pdf/deployment/monitor.sh > diagnostico.txt

# Incluir informações do sistema
echo "=== SISTEMA ===" >> diagnostico.txt
lsb_release -a >> diagnostico.txt
uname -a >> diagnostico.txt
python3 --version >> diagnostico.txt

# Incluir logs recentes
echo "=== LOGS ===" >> diagnostico.txt
sudo tail -50 /var/log/pdf-merger/app.log >> diagnostico.txt
```

### 📧 **Canais de Suporte**
- **GitHub Issues**: Para bugs e melhorias
- **Documentação**: Verificar `docs/` para guias detalhados
- **Scripts de Correção**: Usar ferramentas em `scripts/`

---

<div align="center">

**🐧 PDF Merger - Optimizado para Ubuntu Server**

[![Ubuntu](https://img.shields.io/badge/Ubuntu-Server-orange.svg)](https://ubuntu.com/server)
[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://python.org)
[![Deploy](https://img.shields.io/badge/Deploy-Automated-green.svg)](./install.sh)

*Deploy profissional em minutos, não em horas*

</div>