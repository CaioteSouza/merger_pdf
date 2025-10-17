# PDF Merger - Ferramenta para Unir PDFs

Uma ferramenta local completa para unir múltiplos arquivos PDF em um único documento, com interface web intuitiva e banco de dados para histórico.

## Funcionalidades

- ✅ **União de múltiplos PDFs**: Suporte a 2 ou mais arquivos PDF
- ✅ **Interface web moderna**: Design responsivo com Bootstrap 5
- ✅ **Drag & Drop**: Arraste e solte arquivos diretamente na interface
- ✅ **Banco de dados**: SQLite para manter histórico dos PDFs unidos
- ✅ **Estatísticas**: Visualização de dados sobre os arquivos processados
- ✅ **Download e exclusão**: Gerenciamento completo dos arquivos
- ✅ **Logo personalizado**: Logotipo incluído na interface

## Bibliotecas Utilizadas

### Backend (Python)
- **Flask 3.0.0**: Framework web para a aplicação
- **pypdf 6.1.1**: Biblioteca moderna para manipulação de PDFs (sucessora do PyPDF2)
- **Werkzeug 3.0.1**: Utilitários para aplicações web

### Frontend
- **Bootstrap 5.3.0**: Framework CSS para interface responsiva
- **Font Awesome 6.0.0**: Ícones vetoriais
- **JavaScript Vanilla**: Funcionalidades interativas

### Banco de Dados
- **SQLite3**: Banco de dados embutido do Python

## Instalação e Uso

### Opção 1: Executar com arquivo .bat (Recomendado)
```bash
# Execute o arquivo start.bat
start.bat
```

### Opção 2: Instalação manual
```bash
# 1. Instalar dependências
pip install -r requirements.txt

# 2. Executar aplicação
python app.py
```

### Acesso
Após iniciar a aplicação, acesse: `http://localhost:5000`

## Estrutura do Projeto

```
Merge_pdf/
├── app.py                 # Aplicação principal Flask
├── requirements.txt       # Dependências Python
├── start.bat             # Script de inicialização
├── logo.png              # Logo original
├── static/               # Arquivos estáticos
│   └── logo.png          # Logo para web
├── templates/            # Templates HTML
│   ├── base.html         # Template base
│   ├── index.html        # Página principal
│   └── history.html      # Histórico de PDFs
├── uploads/              # PDFs temporários (criado automaticamente)
├── merged_pdfs/          # PDFs unidos (criado automaticamente)
└── pdf_merger.db         # Banco de dados SQLite (criado automaticamente)
```

## Funcionalidades Detalhadas

### 1. União de PDFs
- Selecione múltiplos arquivos PDF
- Arraste e solte ou use o botão de seleção
- Os PDFs são unidos na ordem selecionada
- Suporte a PDFs com qualquer número de páginas

### 2. Interface Web
- Design responsivo para desktop e mobile
- Indicadores visuais de progresso
- Mensagens de feedback para o usuário
- Área de drag & drop intuitiva

### 3. Banco de Dados
- Armazena informações dos PDFs unidos:
  - Nome do arquivo final
  - Arquivos originais utilizados
  - Número total de páginas
  - Tamanho do arquivo
  - Data de criação

### 4. Estatísticas
- Total de PDFs unidos
- Número total de páginas processadas
- Tamanho total dos arquivos
- Estatísticas por sessão

### 5. Gerenciamento
- Download dos PDFs unidos
- Exclusão de arquivos do histórico
- Visualização de detalhes dos arquivos

## API Endpoints

- `GET /` - Página principal
- `POST /upload` - Upload e união de PDFs
- `GET /history` - Histórico de PDFs unidos
- `GET /download/<id>` - Download de PDF específico
- `POST /delete/<id>` - Exclusão de PDF
- `GET /api/stats` - Estatísticas em JSON

## Segurança

- Validação de tipos de arquivo (apenas PDFs)
- Nomes de arquivo seguros com `secure_filename`
- Limite de tamanho de arquivo (16MB)
- Arquivos temporários são removidos após processamento

## Requisitos do Sistema

- Python 3.7 ou superior
- Windows (testado) / Linux / macOS
- Navegador web moderno
- Pelo menos 100MB de espaço livre

## Sobre as Bibliotecas

### pypdf vs PyPDF2
O projeto utiliza a biblioteca **pypdf** (versão 6.1.1), que é a evolução moderna do PyPDF2. Principais vantagens:

- ✅ Desenvolvimento ativo e suporte contínuo
- ✅ Melhor performance e menos bugs
- ✅ API mais limpa e intuitiva
- ✅ Suporte a recursos modernos de PDF
- ✅ Melhor tratamento de erros

### Flask
Framework web leve e flexível, ideal para:
- Desenvolvimento rápido de aplicações web
- APIs REST simples
- Aplicações locais e protótipos

## Licença

Este projeto é de uso livre para fins educacionais e pessoais.

## Suporte

Para dúvidas ou problemas:
1. Verifique se todas as dependências estão instaladas
2. Certifique-se de ter Python 3.7+ instalado
3. Execute `pip install -r requirements.txt` novamente se necessário