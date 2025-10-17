import os
import sqlite3
import math
from datetime import datetime
from flask import Flask, request, render_template, redirect, url_for, flash, send_file, jsonify
from werkzeug.utils import secure_filename
from pypdf import PdfWriter, PdfReader
import io

app = Flask(__name__)
app.config['SECRET_KEY'] = 'sua_chave_secreta_aqui'

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
app.config['UPLOAD_FOLDER'] = 'uploads'
app.config['MERGED_FOLDER'] = 'merged_pdfs'
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # 16MB max file size

# Criar diretórios se não existirem
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)
os.makedirs(app.config['MERGED_FOLDER'], exist_ok=True)

# Configuração do banco de dados
DATABASE = 'pdf_merger.db'

def init_db():
    """Inicializa o banco de dados"""
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

def get_db_connection():
    """Obtém conexão com o banco de dados"""
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

def allowed_file(filename):
    """Verifica se o arquivo é um PDF"""
    return '.' in filename and filename.rsplit('.', 1)[1].lower() == 'pdf'

def get_pdf_page_count(file_path):
    """Retorna o número de páginas de um PDF"""
    try:
        reader = PdfReader(file_path)
        return len(reader.pages)
    except:
        return 0

def merge_pdfs(pdf_files, output_filename):
    """Junta múltiplos PDFs em um único arquivo"""
    writer = PdfWriter()
    total_pages = 0
    original_files = []
    
    for pdf_file in pdf_files:
        try:
            reader = PdfReader(pdf_file)
            original_files.append(os.path.basename(pdf_file))
            
            # Adiciona todas as páginas do PDF
            for page in reader.pages:
                writer.add_page(page)
                total_pages += 1
                
        except Exception as e:
            print(f"Erro ao processar {pdf_file}: {str(e)}")
            continue
    
    # Salva o PDF mesclado
    output_path = os.path.join(app.config['MERGED_FOLDER'], output_filename)
    with open(output_path, 'wb') as output_file:
        writer.write(output_file)
    
    return output_path, total_pages, original_files

@app.route('/')
def index():
    """Página principal"""
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload_files():
    """Processa o upload e junção dos PDFs"""
    if 'files[]' not in request.files:
        flash('Nenhum arquivo selecionado!')
        return redirect(request.url)
    
    files = request.files.getlist('files[]')
    
    if len(files) < 2:
        flash('Selecione pelo menos 2 arquivos PDF!')
        return redirect(url_for('index'))
    
    # Valida se todos os arquivos são PDFs
    pdf_paths = []
    for file in files:
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(file_path)
            pdf_paths.append(file_path)
        else:
            flash(f'Arquivo {file.filename} não é um PDF válido!')
            return redirect(url_for('index'))
    
    # Nome do arquivo de saída
    output_filename = f"merged_{datetime.now().strftime('%Y%m%d_%H%M%S')}.pdf"
    
    try:
        # Junta os PDFs
        output_path, total_pages, original_files = merge_pdfs(pdf_paths, output_filename)
        
        # Obtém o tamanho do arquivo
        file_size = os.path.getsize(output_path)
        
        # Salva no banco de dados
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute('''
            INSERT INTO merged_pdfs (filename, original_files, file_path, total_pages, file_size)
            VALUES (?, ?, ?, ?, ?)
        ''', (output_filename, ', '.join(original_files), output_path, total_pages, file_size))
        conn.commit()
        conn.close()
        
        # Remove arquivos temporários
        for pdf_path in pdf_paths:
            os.remove(pdf_path)
        
        flash(f'PDFs unidos com sucesso! Total de páginas: {total_pages}')
        return redirect(url_for('history'))
        
    except Exception as e:
        flash(f'Erro ao unir PDFs: {str(e)}')
        return redirect(url_for('index'))

@app.route('/history')
def history():
    """Exibe o histórico de PDFs unidos"""
    conn = get_db_connection()
    merged_pdfs = conn.execute('''
        SELECT * FROM merged_pdfs ORDER BY created_at DESC
    ''').fetchall()
    conn.close()
    
    return render_template('history.html', merged_pdfs=merged_pdfs)

@app.route('/download/<int:pdf_id>')
def download_pdf(pdf_id):
    """Download de um PDF unido"""
    conn = get_db_connection()
    pdf = conn.execute('SELECT * FROM merged_pdfs WHERE id = ?', (pdf_id,)).fetchone()
    conn.close()
    
    if pdf and os.path.exists(pdf['file_path']):
        return send_file(pdf['file_path'], as_attachment=True, download_name=pdf['filename'])
    else:
        flash('Arquivo não encontrado!')
        return redirect(url_for('history'))

@app.route('/delete/<int:pdf_id>', methods=['POST'])
def delete_pdf(pdf_id):
    """Exclui um PDF unido"""
    conn = get_db_connection()
    pdf = conn.execute('SELECT * FROM merged_pdfs WHERE id = ?', (pdf_id,)).fetchone()
    
    if pdf:
        # Remove o arquivo físico
        if os.path.exists(pdf['file_path']):
            os.remove(pdf['file_path'])
        
        # Remove do banco de dados
        conn.execute('DELETE FROM merged_pdfs WHERE id = ?', (pdf_id,))
        conn.commit()
        flash('PDF excluído com sucesso!')
    else:
        flash('PDF não encontrado!')
    
    conn.close()
    return redirect(url_for('history'))

@app.route('/api/stats')
def api_stats():
    """API para estatísticas"""
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

if __name__ == '__main__':
    init_db()
    app.run(debug=True, host='0.0.0.0', port=5000)