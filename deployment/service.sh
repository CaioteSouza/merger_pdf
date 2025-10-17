#!/bin/bash

# PDF Merger - Script para rodar em segundo plano
# Usa nohup para manter a aplicação rodando mesmo após logout

APP_NAME="PDF Merger"
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PID_FILE="$APP_DIR/app.pid"
LOG_FILE="$APP_DIR/app.log"

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

case "$1" in
    start)
        if [ -f "$PID_FILE" ]; then
            PID=$(cat "$PID_FILE")
            if ps -p $PID > /dev/null 2>&1; then
                echo -e "${YELLOW}⚠️  $APP_NAME já está rodando (PID: $PID)${NC}"
                exit 1
            else
                rm -f "$PID_FILE"
            fi
        fi
        
        echo -e "${GREEN}🚀 Iniciando $APP_NAME em segundo plano...${NC}"
        cd "$APP_DIR"
        nohup python3 app.py > "$LOG_FILE" 2>&1 &
        echo $! > "$PID_FILE"
        
        sleep 2
        if ps -p $(cat "$PID_FILE") > /dev/null 2>&1; then
            echo -e "${GREEN}✅ $APP_NAME iniciado com sucesso!${NC}"
            echo -e "${YELLOW}📍 Acesse: http://localhost:8080${NC}"
            echo -e "${YELLOW}📝 Logs: $LOG_FILE${NC}"
            echo -e "${YELLOW}🆔 PID: $(cat "$PID_FILE")${NC}"
        else
            echo -e "${RED}❌ Falha ao iniciar $APP_NAME${NC}"
            rm -f "$PID_FILE"
        fi
        ;;
        
    stop)
        if [ -f "$PID_FILE" ]; then
            PID=$(cat "$PID_FILE")
            if ps -p $PID > /dev/null 2>&1; then
                echo -e "${YELLOW}🛑 Parando $APP_NAME (PID: $PID)...${NC}"
                kill $PID
                rm -f "$PID_FILE"
                echo -e "${GREEN}✅ $APP_NAME parado com sucesso!${NC}"
            else
                echo -e "${RED}❌ $APP_NAME não está rodando${NC}"
                rm -f "$PID_FILE"
            fi
        else
            echo -e "${RED}❌ $APP_NAME não está rodando${NC}"
        fi
        ;;
        
    restart)
        $0 stop
        sleep 2
        $0 start
        ;;
        
    status)
        if [ -f "$PID_FILE" ]; then
            PID=$(cat "$PID_FILE")
            if ps -p $PID > /dev/null 2>&1; then
                echo -e "${GREEN}✅ $APP_NAME está rodando (PID: $PID)${NC}"
                echo -e "${YELLOW}📍 Acesse: http://localhost:8080${NC}"
                echo -e "${YELLOW}📝 Logs: $LOG_FILE${NC}"
            else
                echo -e "${RED}❌ $APP_NAME não está rodando${NC}"
                rm -f "$PID_FILE"
            fi
        else
            echo -e "${RED}❌ $APP_NAME não está rodando${NC}"
        fi
        ;;
        
    logs)
        if [ -f "$LOG_FILE" ]; then
            echo -e "${YELLOW}📝 Últimas 50 linhas do log:${NC}"
            tail -50 "$LOG_FILE"
        else
            echo -e "${RED}❌ Arquivo de log não encontrado${NC}"
        fi
        ;;
        
    *)
        echo "Uso: $0 {start|stop|restart|status|logs}"
        echo ""
        echo "Comandos disponíveis:"
        echo "  start   - Inicia a aplicação em segundo plano"
        echo "  stop    - Para a aplicação"
        echo "  restart - Reinicia a aplicação"
        echo "  status  - Mostra o status da aplicação"
        echo "  logs    - Mostra os logs da aplicação"
        exit 1
        ;;
esac