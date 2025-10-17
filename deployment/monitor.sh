#!/bin/bash

# Script de monitoramento do PDF Merger
# Monitor em tempo real do sistema

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

clear
echo -e "${BLUE}🖥️  MONITOR PDF MERGER - SISTEMA DE PRODUÇÃO${NC}"
echo "================================================="

while true; do
    clear
    echo -e "${BLUE}🖥️  MONITOR PDF MERGER - $(date)${NC}"
    echo "================================================="
    
    # Status dos serviços
    echo -e "${YELLOW}📊 STATUS DOS SERVIÇOS:${NC}"
    echo "┌─────────────────────────────────────────────────┐"
    
    # Supervisor
    if supervisorctl status pdf-merger | grep -q "RUNNING"; then
        echo -e "│ PDF Merger:  ${GREEN}✅ RODANDO${NC}                      │"
    else
        echo -e "│ PDF Merger:  ${RED}❌ PARADO${NC}                       │"
    fi
    
    # Nginx
    if systemctl is-active --quiet nginx; then
        echo -e "│ Nginx:       ${GREEN}✅ ATIVO${NC}                        │"
    else
        echo -e "│ Nginx:       ${RED}❌ INATIVO${NC}                       │"
    fi
    
    # Fail2Ban
    if systemctl is-active --quiet fail2ban; then
        echo -e "│ Fail2Ban:    ${GREEN}✅ PROTEGENDO${NC}                   │"
    else
        echo -e "│ Fail2Ban:    ${RED}❌ DESABILITADO${NC}                  │"
    fi
    
    echo "└─────────────────────────────────────────────────┘"
    echo ""
    
    # Uso de recursos
    echo -e "${YELLOW}💻 USO DE RECURSOS:${NC}"
    echo "┌─────────────────────────────────────────────────┐"
    
    # CPU
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    echo -e "│ CPU:         ${GREEN}${CPU_USAGE}%${NC}                          │"
    
    # Memória
    MEM_INFO=$(free | grep Mem)
    MEM_TOTAL=$(echo $MEM_INFO | awk '{print $2}')
    MEM_USED=$(echo $MEM_INFO | awk '{print $3}')
    MEM_PERCENT=$((MEM_USED * 100 / MEM_TOTAL))
    echo -e "│ Memória:     ${GREEN}${MEM_PERCENT}%${NC}                          │"
    
    # Disco
    DISK_USAGE=$(df /opt/pdf-merger | awk 'NR==2 {print $5}' | cut -d'%' -f1)
    echo -e "│ Disco:       ${GREEN}${DISK_USAGE}%${NC}                          │"
    
    echo "└─────────────────────────────────────────────────┘"
    echo ""
    
    # Processos PDF Merger
    echo -e "${YELLOW}⚡ PROCESSOS GUNICORN:${NC}"
    WORKER_COUNT=$(ps aux | grep -c "[g]unicorn.*pdf-merger")
    echo "Workers ativos: $WORKER_COUNT"
    
    # Conexões ativas
    echo -e "${YELLOW}🌐 CONEXÕES ATIVAS:${NC}"
    CONNECTIONS=$(ss -tuln | grep :80 | wc -l)
    echo "Conexões HTTP: $CONNECTIONS"
    
    # Últimos acessos
    echo ""
    echo -e "${YELLOW}📈 ÚLTIMOS ACESSOS (5 mais recentes):${NC}"
    tail -5 /var/log/nginx/pdf-merger-access.log 2>/dev/null | while read line; do
        echo "• $line" | cut -c1-70
    done
    
    # IPs banidos pelo Fail2Ban
    echo ""
    echo -e "${YELLOW}🛡️  IPs BANIDOS:${NC}"
    BANNED_COUNT=$(fail2ban-client status pdf-merger 2>/dev/null | grep "Currently banned" | awk '{print $4}' || echo "0")
    echo "IPs banidos: $BANNED_COUNT"
    
    echo ""
    echo "==============================================="
    echo "Pressione Ctrl+C para sair | Atualiza a cada 5s"
    
    sleep 5
done