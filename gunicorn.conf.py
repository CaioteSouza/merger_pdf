# Configuração do Gunicorn para produção
# Arquivo: gunicorn.conf.py

import multiprocessing

# Configurações do servidor
bind = "0.0.0.0:8080"
workers = multiprocessing.cpu_count() * 2 + 1  # Fórmula recomendada
worker_class = "sync"
worker_connections = 1000
max_requests = 1000
max_requests_jitter = 100

# Configurações de timeout
timeout = 300  # 5 minutos para uploads grandes
keepalive = 5
graceful_timeout = 300

# Configurações de processo
preload_app = True
daemon = False
user = "pdfmerger"
group = "pdfmerger"

# Logs
accesslog = "/var/log/pdf-merger/access.log"
errorlog = "/var/log/pdf-merger/error.log"
loglevel = "info"
access_log_format = '%(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s" %(D)s'

# Configurações de segurança
limit_request_line = 4094
limit_request_fields = 100
limit_request_field_size = 8190

# Reinicialização automática
max_requests_jitter = 50
preload_app = True