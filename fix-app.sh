#!/bin/bash

# Script para corrigir o app.py e garantir que funcione com as configurações

echo "🔧 Corrigindo app.py para produção..."

APP_DIR="/opt/pdf-merger"
cd $APP_DIR

# Backup do arquivo original
cp app.py app.py.backup

# Criar versão corrigida do app.py
cat > app.py << 'EOF'
import os
import sqlite3
import math
from datetime import datetime
from flask import Flask, request, render_template, redirect, url_for, flash, send_file, jsonify
from werkzeug.utils import secure_filename
from pypdf import PdfWriter, PdfReader
import io

# Importar configurações
try:
    import config
except ImportError:
    # Fallback se config.py não existir
    class Config:
        SECRET_KEY = 'fallback_secret_key_change_me'
        UPLOAD_FOLDER = 'uploads'
        MERGED_FOLDER = 'merged_pdfs'
        MAX_CONTENT_LENGTH = 200 * 1024 * 1024
        MAX_FILE_SIZE = 50 * 1024 * 1024
        ALLOWED_EXTENSIONS = ['pdf']
        DATABASE_NAME = 'pdf_merger.db'
        HOST = '0.0.0.0'
        PORT = 8080
        DEBUG = False
        PERMANENT_SESSION_LIFETIME = 3600
        SESSION_COOKIE_SECURE = False
        SESSION_COOKIE_HTTPONLY = True
        SESSION_COOKIE_SAMESITE = 'Lax'
    config = Config()

app = Flask(__name__)

# Configurações do Flask usando config.py
app.config['SECRET_KEY'] = config.SECRET_KEY
app.config['UPLOAD_FOLDER'] = config.UPLOAD_FOLDER
app.config['MERGED_FOLDER'] = config.MERGED_FOLDER
app.config['MAX_CONTENT_LENGTH'] = config.MAX_CONTENT_LENGTH
app.config['PERMANENT_SESSION_LIFETIME'] = config.PERMANENT_SESSION_LIFETIME

# Configurações de segurança
app.config['SESSION_COOKIE_SECURE'] = config.SESSION_COOKIE_SECURE
app.config['SESSION_COOKIE_HTTPONLY'] = config.SESSION_COOKIE_HTTPONLY
app.config['SESSION_COOKIE_SAMESITE'] = config.SESSION_COOKIE_SAMESITE

def format_file_size(size_bytes):
    """Formata o tamanho do arquivo em formato legível"""
    if size_bytes == 0:
        return "0 B"
    size_names = ["B", "KB", "MB", "GB"]
    i = int(math.floor(math.log(size_bytes, 1024)))
    p = math.pow(1024, i)
    s = round(size_bytes / p, 2)
    return f"{s} {size_names[i]}"

# Registrar função para uso nos templates
app.jinja_env.globals.update(format_file_size=format_file_size)

# Criar diretórios se não existirem
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)
os.makedirs(app.config['MERGED_FOLDER'], exist_ok=True)

# Configuração do banco de dados
DATABASE = config.DATABASE_NAME

def init_db():
    """Inicializa o banco de dados"""
    try:
        conn = sqlite3.connect(DATABASE)
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
        print("Banco de dados inicializado com sucesso")
        return True
    except Exception as e:
        print(f"Erro ao inicializar banco: {e}")
        return False

def get_db_connection():
    """Cria conexão com o banco de dados"""
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

def allowed_file(filename):
    """Verifica se o arquivo tem extensão permitida"""
    if '.' not in filename:
        return False
    extension = filename.rsplit('.', 1)[1].lower()
    return extension in config.ALLOWED_EXTENSIONS

def get_pdf_page_count(file_path):
    """Retorna o número de páginas de um PDF"""
    try:
        reader = PdfReader(file_path)
        return len(reader.pages)
    except Exception as e:
        print(f"Erro ao contar páginas: {e}")
        return 0

def merge_pdfs(pdf_paths, output_path):
    """Une múltiplos PDFs em um único arquivo"""
    try:
        writer = PdfWriter()
        total_pages = 0
        
        for pdf_path in pdf_paths:
            reader = PdfReader(pdf_path)
            for page in reader.pages:
                writer.add_page(page)
                total_pages += 1
        
        with open(output_path, 'wb') as output_file:
            writer.write(output_file)
        
        return total_pages
    except Exception as e:
        print(f"Erro ao unir PDFs: {e}")
        raise e

@app.route('/')
def index():
    """Página inicial"""
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload_files():
    """Processa o upload e união dos PDFs"""
    try:
        files = request.files.getlist('files[]')
        
        if len(files) < 2:
            flash('Selecione pelo menos 2 arquivos PDF!')
            return redirect(url_for('index'))
        
        # Valida se todos os arquivos são PDFs e não excedem o tamanho máximo
        pdf_paths = []
        original_files = []
        
        for file in files:
            if file and allowed_file(file.filename):
                # Verificar tamanho do arquivo
                file.seek(0, 2)  # Vai para o final do arquivo
                file_size = file.tell()
                file.seek(0)  # Volta para o início
                
                if file_size > config.MAX_FILE_SIZE:
                    flash(f'Arquivo {file.filename} excede o tamanho máximo permitido ({format_file_size(config.MAX_FILE_SIZE)})!')
                    return redirect(url_for('index'))
                
                filename = secure_filename(file.filename)
                file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
                file.save(file_path)
                pdf_paths.append(file_path)
                original_files.append(filename)
            else:
                flash(f'Arquivo {file.filename} não é um PDF válido!')
                return redirect(url_for('index'))
        
        # Nome do arquivo de saída
        output_filename = f"merged_{datetime.now().strftime('%Y%m%d_%H%M%S')}.pdf"
        output_path = os.path.join(app.config['MERGED_FOLDER'], output_filename)
        
        # Unir os PDFs
        total_pages = merge_pdfs(pdf_paths, output_path)
        
        # Calcular tamanho do arquivo final
        file_size = os.path.getsize(output_path)
        
        # Salvar informações no banco de dados
        conn = get_db_connection()
        conn.execute(
            'INSERT INTO merged_pdfs (filename, original_files, file_path, total_pages, file_size) VALUES (?, ?, ?, ?, ?)',
            (output_filename, ', '.join(original_files), output_path, total_pages, file_size)
        )
        conn.commit()
        conn.close()
        
        # Limpar arquivos temporários
        for pdf_path in pdf_paths:
            try:
                os.remove(pdf_path)
            except:
                pass
        
        flash(f'PDFs unidos com sucesso! {total_pages} páginas no total.', 'success')
        return send_file(output_path, as_attachment=True, download_name=output_filename)
        
    except Exception as e:
        flash(f'Erro ao processar arquivos: {str(e)}', 'error')
        print(f"Erro no upload: {e}")
        return redirect(url_for('index'))

@app.route('/history')
def history():
    """Página de histórico"""
    try:
        conn = get_db_connection()
        merged_pdfs = conn.execute(
            'SELECT * FROM merged_pdfs ORDER BY created_at DESC'
        ).fetchall()
        conn.close()
        return render_template('history.html', merged_pdfs=merged_pdfs)
    except Exception as e:
        flash(f'Erro ao carregar histórico: {str(e)}', 'error')
        print(f"Erro no histórico: {e}")
        return redirect(url_for('index'))

@app.route('/download/<filename>')
def download_file(filename):
    """Download de arquivo específico"""
    try:
        file_path = os.path.join(app.config['MERGED_FOLDER'], filename)
        if os.path.exists(file_path):
            return send_file(file_path, as_attachment=True, download_name=filename)
        else:
            flash('Arquivo não encontrado!', 'error')
            return redirect(url_for('history'))
    except Exception as e:
        flash(f'Erro ao baixar arquivo: {str(e)}', 'error')
        return redirect(url_for('history'))

@app.route('/delete/<int:file_id>')
def delete_file(file_id):
    """Excluir arquivo do histórico"""
    try:
        conn = get_db_connection()
        file_record = conn.execute('SELECT * FROM merged_pdfs WHERE id = ?', (file_id,)).fetchone()
        
        if file_record:
            # Remover arquivo físico
            try:
                os.remove(file_record['file_path'])
            except:
                pass
            
            # Remover do banco
            conn.execute('DELETE FROM merged_pdfs WHERE id = ?', (file_id,))
            conn.commit()
            flash('Arquivo excluído com sucesso!', 'success')
        else:
            flash('Arquivo não encontrado!', 'error')
        
        conn.close()
        return redirect(url_for('history'))
    except Exception as e:
        flash(f'Erro ao excluir arquivo: {str(e)}', 'error')
        return redirect(url_for('history'))

@app.route('/api/stats')
def api_stats():
    """API para estatísticas"""
    try:
        conn = get_db_connection()
        stats = conn.execute('''
            SELECT 
                COUNT(*) as total_merged,
                SUM(total_pages) as total_pages,
                SUM(file_size) as total_size
            FROM merged_pdfs
        ''').fetchone()
        conn.close()
        
        return jsonify({
            'total_merged': stats['total_merged'] or 0,
            'total_pages': stats['total_pages'] or 0,
            'total_size': stats['total_size'] or 0
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# Tratamento de erros
@app.errorhandler(413)
def too_large(e):
    flash('Arquivo muito grande! Tamanho máximo permitido: 200MB', 'error')
    return redirect(url_for('index'))

@app.errorhandler(500)
def internal_error(e):
    flash('Erro interno do servidor. Tente novamente.', 'error')
    return redirect(url_for('index'))

if __name__ == '__main__':
    init_db()
    app.run(debug=config.DEBUG, host=config.HOST, port=config.PORT)
EOF

echo "✅ app.py corrigido com tratamento de erros robusto!"

# Corrigir permissões
chown pdfmerger:pdfmerger app.py
chmod 640 app.py

echo "🔧 Reiniciando aplicação..."
supervisorctl restart pdf-merger

echo "✅ Correção concluída!"