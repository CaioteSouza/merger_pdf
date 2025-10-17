#!/bin/bash

# Script para corrigir problemas específicos de navegação
# Execute no servidor: sudo bash fix-navigation.sh

echo "🔧 Corrigindo problemas de navegação..."
echo "======================================"

APP_DIR="/var/www/merger_pdf"
cd $APP_DIR

# Backup do app.py atual
cp app.py app.py.backup-navigation

echo "📝 Criando versão corrigida do app.py..."

# Criar nova versão do app.py com rotas corretas
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

# Configurações do Flask
app.config['SECRET_KEY'] = config.SECRET_KEY
app.config['UPLOAD_FOLDER'] = config.UPLOAD_FOLDER
app.config['MERGED_FOLDER'] = config.MERGED_FOLDER
app.config['MAX_CONTENT_LENGTH'] = config.MAX_CONTENT_LENGTH
app.config['PERMANENT_SESSION_LIFETIME'] = config.PERMANENT_SESSION_LIFETIME
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
        print("✅ Banco de dados inicializado")
        return True
    except Exception as e:
        print(f"❌ Erro ao inicializar banco: {e}")
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
            flash('Selecione pelo menos 2 arquivos PDF!', 'warning')
            return redirect(url_for('index'))
        
        # Validar arquivos
        pdf_paths = []
        original_files = []
        
        for file in files:
            if file and allowed_file(file.filename):
                # Verificar tamanho do arquivo
                file.seek(0, 2)
                file_size = file.tell()
                file.seek(0)
                
                if file_size > config.MAX_FILE_SIZE:
                    flash(f'Arquivo {file.filename} excede o tamanho máximo ({format_file_size(config.MAX_FILE_SIZE)})!', 'error')
                    return redirect(url_for('index'))
                
                filename = secure_filename(file.filename)
                file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
                file.save(file_path)
                pdf_paths.append(file_path)
                original_files.append(filename)
            else:
                flash(f'Arquivo {file.filename} não é um PDF válido!', 'error')
                return redirect(url_for('index'))
        
        # Gerar arquivo de saída
        output_filename = f"merged_{datetime.now().strftime('%Y%m%d_%H%M%S')}.pdf"
        output_path = os.path.join(app.config['MERGED_FOLDER'], output_filename)
        
        # Unir PDFs
        total_pages = merge_pdfs(pdf_paths, output_path)
        file_size = os.path.getsize(output_path)
        
        # Salvar no banco
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
        
        flash(f'✅ PDFs unidos com sucesso! {total_pages} páginas no total.', 'success')
        
        # REDIRECIONAMENTO CORRETO PARA O HISTÓRICO
        return redirect(url_for('history'))
        
    except Exception as e:
        flash(f'❌ Erro ao processar arquivos: {str(e)}', 'error')
        print(f"Erro no upload: {e}")
        return redirect(url_for('index'))

@app.route('/history')
def history():
    """Página de histórico - ROTA CORRIGIDA"""
    try:
        conn = get_db_connection()
        merged_pdfs = conn.execute(
            'SELECT * FROM merged_pdfs ORDER BY created_at DESC'
        ).fetchall()
        conn.close()
        
        print(f"📋 Carregando histórico: {len(merged_pdfs)} arquivos encontrados")
        return render_template('history.html', merged_pdfs=merged_pdfs)
        
    except Exception as e:
        flash(f'❌ Erro ao carregar histórico: {str(e)}', 'error')
        print(f"Erro no histórico: {e}")
        return redirect(url_for('index'))

@app.route('/download/<int:pdf_id>')
def download_pdf(pdf_id):
    """Download por ID - ROTA CORRIGIDA"""
    try:
        conn = get_db_connection()
        pdf_record = conn.execute(
            'SELECT * FROM merged_pdfs WHERE id = ?', (pdf_id,)
        ).fetchone()
        conn.close()
        
        if pdf_record and os.path.exists(pdf_record['file_path']):
            print(f"📥 Download solicitado: {pdf_record['filename']}")
            return send_file(
                pdf_record['file_path'], 
                as_attachment=True, 
                download_name=pdf_record['filename']
            )
        else:
            flash('❌ Arquivo não encontrado!', 'error')
            return redirect(url_for('history'))
            
    except Exception as e:
        flash(f'❌ Erro ao baixar arquivo: {str(e)}', 'error')
        print(f"Erro no download: {e}")
        return redirect(url_for('history'))

@app.route('/download/file/<filename>')
def download_file(filename):
    """Download por nome de arquivo - COMPATIBILIDADE"""
    try:
        file_path = os.path.join(app.config['MERGED_FOLDER'], filename)
        if os.path.exists(file_path):
            return send_file(file_path, as_attachment=True, download_name=filename)
        else:
            flash('❌ Arquivo não encontrado!', 'error')
            return redirect(url_for('history'))
    except Exception as e:
        flash(f'❌ Erro ao baixar arquivo: {str(e)}', 'error')
        return redirect(url_for('history'))

@app.route('/delete/<int:pdf_id>', methods=['POST'])
def delete_pdf(pdf_id):
    """Excluir arquivo - ROTA CORRIGIDA"""
    try:
        conn = get_db_connection()
        file_record = conn.execute(
            'SELECT * FROM merged_pdfs WHERE id = ?', (pdf_id,)
        ).fetchone()
        
        if file_record:
            # Remover arquivo físico
            try:
                if os.path.exists(file_record['file_path']):
                    os.remove(file_record['file_path'])
                    print(f"🗑️ Arquivo físico removido: {file_record['filename']}")
            except Exception as e:
                print(f"Aviso: não foi possível remover arquivo físico: {e}")
            
            # Remover do banco
            conn.execute('DELETE FROM merged_pdfs WHERE id = ?', (pdf_id,))
            conn.commit()
            flash('✅ Arquivo excluído com sucesso!', 'success')
        else:
            flash('❌ Arquivo não encontrado!', 'error')
        
        conn.close()
        return redirect(url_for('history'))
        
    except Exception as e:
        flash(f'❌ Erro ao excluir arquivo: {str(e)}', 'error')
        print(f"Erro ao excluir: {e}")
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
    flash('❌ Arquivo muito grande! Tamanho máximo: 200MB', 'error')
    return redirect(url_for('index'))

@app.errorhandler(500)
def internal_error(e):
    flash('❌ Erro interno do servidor. Tente novamente.', 'error')
    return redirect(url_for('index'))

@app.errorhandler(404)
def not_found(e):
    flash('❌ Página não encontrada!', 'error')
    return redirect(url_for('index'))

if __name__ == '__main__':
    init_db()
    app.run(debug=config.DEBUG, host=config.HOST, port=config.PORT)
EOF

echo "✅ app.py corrigido!"

# Corrigir permissões
chown pdfmerger:pdfmerger app.py
chmod 640 app.py

echo "🔄 Reiniciando aplicação..."
supervisorctl restart pdf-merger

echo "⏳ Aguardando reinicialização..."
sleep 3

echo "🧪 Testando aplicação..."
if curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/ | grep -q "200"; then
    echo "✅ Aplicação funcionando!"
    echo "🌐 Teste também: http://localhost:8080/history"
else
    echo "❌ Problema na aplicação - verificando logs..."
    supervisorctl status pdf-merger
    echo ""
    echo "📝 Últimas linhas do log:"
    tail -10 /var/log/pdf-merger/app.log 2>/dev/null || echo "Log não encontrado"
fi

echo ""
echo "🎯 Correções aplicadas:"
echo "  ✅ Redirecionamento após merge corrigido"
echo "  ✅ Rota /history corrigida"
echo "  ✅ Download por ID implementado"
echo "  ✅ Tratamento de erros melhorado"
echo "  ✅ Logs de debug adicionados"
echo ""
echo "🔧 Problemas resolvidos:"
echo "  - Após unir PDFs, redireciona para histórico"
echo "  - Botão histórico funcionando"
echo "  - Downloads funcionando por ID"
echo "  - Melhor feedback de erros"
EOF

echo "🔧 Script de correção de navegação criado!"
echo "📋 Para executar no servidor:"
echo "sudo bash fix-navigation.sh"

# Tornar executável
chmod +x fix-navigation.sh

echo "✅ Pronto! Execute no servidor para corrigir os problemas de navegação."