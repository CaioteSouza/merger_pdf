# Configurações da Aplicação PDF Merger

# Configurações do servidor
HOST = '0.0.0.0'  # Permite acesso de qualquer IP na rede local
PORT = 5000       # Porta padrão da aplicação
DEBUG = True      # Modo de debug ativado para desenvolvimento

# Configurações de upload
MAX_FILE_SIZE = 16 * 1024 * 1024  # 16MB por arquivo
ALLOWED_EXTENSIONS = ['pdf']       # Apenas arquivos PDF

# Configurações de diretórios
UPLOAD_FOLDER = 'uploads'          # Diretório temporário para upload
MERGED_FOLDER = 'merged_pdfs'      # Diretório para PDFs unidos
STATIC_FOLDER = 'static'           # Arquivos estáticos (CSS, JS, imagens)

# Configurações do banco de dados
DATABASE_NAME = 'pdf_merger.db'    # Nome do arquivo do banco SQLite

# Configurações de segurança
SECRET_KEY = 'pdf_merger_secret_key_2024'  # Chave para sessões Flask

# Configurações de interface
APP_TITLE = 'PDF Merger'          # Título da aplicação
APP_DESCRIPTION = 'Ferramenta para unir múltiplos arquivos PDF'
LOGO_PATH = 'static/logo.png'     # Caminho do logo