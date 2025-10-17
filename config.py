# Configurações da Aplicação PDF Merger

# Configurações do servidor
HOST = '0.0.0.0'  # Permite acesso de qualquer IP na rede local
PORT = 8080       # Porta para produção (mude para uma porta disponível na VM)
DEBUG = False     # Modo de debug DESATIVADO para produção

# Configurações de upload
MAX_FILE_SIZE = 50 * 1024 * 1024   # 50MB por arquivo (aumentado para produção)
ALLOWED_EXTENSIONS = ['pdf']       # Apenas arquivos PDF
UPLOAD_TIMEOUT = 300               # Timeout de 5 minutos para uploads grandes

# Configurações de diretórios
UPLOAD_FOLDER = 'uploads'          # Diretório temporário para upload
MERGED_FOLDER = 'merged_pdfs'      # Diretório para PDFs unidos
STATIC_FOLDER = 'static'           # Arquivos estáticos (CSS, JS, imagens)

# Configurações do banco de dados
DATABASE_NAME = 'pdf_merger.db'    # Nome do arquivo do banco SQLite

# Configurações de segurança
SECRET_KEY = 'MUDE_ESTA_CHAVE_PARA_UMA_ALEATORIA_EM_PRODUCAO_2025'  # ⚠️ MUDE ESTA CHAVE!
SESSION_COOKIE_SECURE = True      # Cookies seguros (apenas HTTPS)
SESSION_COOKIE_HTTPONLY = True    # Previne acesso via JavaScript
SESSION_COOKIE_SAMESITE = 'Lax'   # Proteção contra CSRF

# Configurações de interface
APP_TITLE = 'PDF Merger'          # Título da aplicação
APP_DESCRIPTION = 'Ferramenta para unir múltiplos arquivos PDF'
LOGO_PATH = 'static/logo.png'     # Caminho do logo

# Configurações de produção
ENVIRONMENT = 'production'         # Ambiente de execução
LOG_LEVEL = 'INFO'                # Nível de log para produção
MAX_CONTENT_LENGTH = 200 * 1024 * 1024  # 200MB limite total de request
PERMANENT_SESSION_LIFETIME = 3600  # Sessão expira em 1 hora

# Configurações de limpeza automática
AUTO_CLEANUP_ENABLED = True       # Ativa limpeza automática de arquivos antigos
CLEANUP_INTERVAL_HOURS = 24       # Limpa arquivos a cada 24 horas
TEMP_FILE_MAX_AGE_HOURS = 48      # Remove arquivos temporários após 48h