#!/bin/bash

# PDF Merger - Script de Inicialização para Linux
# Equivalente ao start.bat do Windows

echo "🚀 Iniciando PDF Merger..."
echo "======================================="

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # Sem cor

# Verificar se Python3 está instalado
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ Python3 não encontrado. Instale com: sudo apt install python3${NC}"
    exit 1
fi

# Verificar se pip está instalado
if ! command -v pip3 &> /dev/null; then
    echo -e "${YELLOW}⚠️  pip3 não encontrado. Instalando...${NC}"
    sudo apt install python3-pip -y
fi

# Instalar dependências se necessário
echo -e "${YELLOW}📦 Verificando dependências...${NC}"
pip3 install flask pypdf --user

# Verificar se os diretórios existem
if [ ! -d "uploads" ]; then
    mkdir uploads
    echo -e "${GREEN}✅ Diretório 'uploads' criado${NC}"
fi

if [ ! -d "merged_pdfs" ]; then
    mkdir merged_pdfs
    echo -e "${GREEN}✅ Diretório 'merged_pdfs' criado${NC}"
fi

# Iniciar a aplicação
echo -e "${GREEN}🌟 Iniciando PDF Merger...${NC}"
echo -e "${YELLOW}📍 Acesse: http://localhost:8080${NC}"
echo -e "${YELLOW}🛑 Para parar: Ctrl+C${NC}"
echo "======================================="

python3 app.py