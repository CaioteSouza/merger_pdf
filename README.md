# 📄 PDF Merger - Ferramenta para Unir PDFs

Uma ferramenta local completa para unir múltiplos arquivos PDF em um único documento, com interface web intuitiva, banco de dados para histórico e design moderno personalizado.

## ✨ Funcionalidades

- ✅ **União de múltiplos PDFs**: Suporte a 2 ou mais arquivos PDF
- ✅ **Interface web moderna**: Design responsivo com cores personalizadas
- ✅ **Drag & Drop**: Arraste e solte arquivos diretamente na interface
- ✅ **Banco de dados**: SQLite para manter histórico dos PDFs unidos
- ✅ **Estatísticas em tempo real**: Visualização de dados sobre os arquivos processados
- ✅ **Download e exclusão**: Gerenciamento completo dos arquivos
- ✅ **Logo personalizado**: Logotipo centralizado na interface
- ✅ **CSS organizado**: Estilos estruturados em arquivo separado
- ✅ **Design intuitivo**: Cores e layout otimizados para usabilidade

## 🛠️ Tecnologias Utilizadas

### Backend (Python)
- **Flask 3.0.0**: Framework web para a aplicação
- **pypdf 6.1.1**: Biblioteca moderna para manipulação de PDFs (sucessora do PyPDF2)
- **Werkzeug 3.0.1**: Utilitários para aplicações web

### Frontend
- **Bootstrap 5.3.0**: Framework CSS para interface responsiva
- **Font Awesome 6.0.0**: Ícones vetoriais
- **CSS3 personalizado**: Estilos organizados e modulares
- **JavaScript Vanilla**: Funcionalidades interativas (drag & drop, validações)

### Banco de Dados
- **SQLite3**: Banco de dados embutido do Python

## 🚀 Instalação e Uso

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

## 📁 Estrutura do Projeto

```
Merge_pdf/
├── app.py                 # Aplicação principal Flask
├── requirements.txt       # Dependências Python
├── start.bat             # Script de inicialização
├── config.py             # Configurações da aplicação
├── README.md             # Documentação completa
├── GUIA_RAPIDO.md        # Manual de uso rápido
├── logo.png              # Logo original
├── static/               # Arquivos estáticos
│   ├── logo.png          # Logo para web
│   └── style.css         # Estilos CSS organizados
├── templates/            # Templates HTML
│   ├── base.html         # Template base com navbar
│   ├── index.html        # Página principal (upload)
│   └── history.html      # Histórico de PDFs
├── uploads/              # PDFs temporários (criado automaticamente)
├── merged_pdfs/          # PDFs unidos (criado automaticamente)
└── pdf_merger.db         # Banco de dados SQLite (criado automaticamente)
```

## 🎯 Funcionalidades Detalhadas

### 1. 📄 União de PDFs
- Selecione múltiplos arquivos PDF (2 ou mais)
- Interface **drag & drop** intuitiva ou botão de seleção
- Os PDFs são unidos na ordem selecionada
- Suporte a PDFs com qualquer número de páginas
- Processamento em tempo real com feedback visual

### 2. 🎨 Interface Web Moderna
- **Design responsivo** para desktop, tablet e mobile
- **Cores personalizadas** verde e branco para melhor usabilidade
- **Logo centralizado** no header para identidade visual
- **Navegação simplificada** entre páginas (Início/Histórico)
- **Indicadores visuais** de progresso e status

### 3. 💾 Banco de Dados Inteligente
- Armazena **automaticamente** informações dos PDFs unidos:
  - Nome do arquivo final gerado
  - Lista de arquivos originais utilizados
  - Número total de páginas processadas
  - Tamanho do arquivo resultante
  - Data e hora da criação
- **SQLite** para persistência local sem configuração

### 4. 📊 Estatísticas em Tempo Real
- **Cards visuais** com dados atualizados automaticamente:
  - Total de PDFs unidos no sistema
  - Número total de páginas processadas
  - Tamanho total dos arquivos gerados
  - Média de páginas por PDF
- **API JSON** para integração com outras ferramentas

### 5. 🔧 Gerenciamento Completo
- **Download direto** dos PDFs unidos
- **Exclusão segura** com confirmação
- **Histórico completo** de todas as operações
- **Visualização detalhada** de informações dos arquivos

## 🌐 API Endpoints

- `GET /` - Página principal
- `POST /upload` - Upload e união de PDFs
- `GET /history` - Histórico de PDFs unidos
- `GET /download/<id>` - Download de PDF específico
- `POST /delete/<id>` - Exclusão de PDF
- `GET /api/stats` - Estatísticas em JSON

## 🔒 Segurança e Validação

- **Validação rigorosa** de tipos de arquivo (apenas PDFs)
- **Nomes seguros** com `secure_filename` para evitar ataques
- **Limite de tamanho** por arquivo (16MB máximo)
- **Limpeza automática** de arquivos temporários após processamento
- **Sanitização** de inputs do usuário

## 💻 Requisitos do Sistema

- **Python 3.7+** (testado até Python 3.13)
- **Sistema Operacional**: Windows / Linux / macOS
- **Navegador**: Chrome, Firefox, Safari, Edge (versões modernas)
- **Espaço em disco**: Pelo menos 100MB livre
- **RAM**: Mínimo 512MB (recomendado 1GB+)

## 📚 Sobre as Tecnologias Escolhidas

### 🐍 pypdf vs PyPDF2
O projeto utiliza a biblioteca **pypdf** (versão 6.1.1), evolução moderna do PyPDF2:

- ✅ **Desenvolvimento ativo** e suporte contínuo
- ✅ **Melhor performance** e menos bugs
- ✅ **API mais limpa** e intuitiva
- ✅ **Recursos modernos** de PDF
- ✅ **Tratamento robusto** de erros

### 🌐 Flask Framework
Escolhido por ser leve e flexível, ideal para:
- **Desenvolvimento rápido** de aplicações web
- **APIs REST simples** e eficientes
- **Aplicações locais** e protótipos
- **Baixo overhead** e alta performance

### 🎨 CSS Modular
- **Arquivo separado** (`static/style.css`) para melhor organização
- **Estrutura comentada** para fácil manutenção
- **Cores consistentes** em todo o projeto
- **Responsividade** para todos os dispositivos

## 📖 Documentação Adicional

- **README.md**: Documentação técnica completa
- **GUIA_RAPIDO.md**: Manual de uso para usuários finais
- **config.py**: Configurações personalizáveis
- **Comentários no código**: Explicações detalhadas das funções

## 📈 Melhorias Futuras

- [ ] Suporte a mais formatos (DOC, DOCX)
- [ ] Compressão de PDFs resultantes
- [ ] Visualização prévia dos PDFs
- [ ] API REST completa
- [ ] Autenticação de usuários
- [ ] Upload em lote via pasta

## 📄 Licença

Este projeto é de **uso livre** para fins educacionais e pessoais.

## 🆘 Suporte e Solução de Problemas

### Problemas Comuns:
1. **Dependências**: Execute `pip install -r requirements.txt`
2. **Python**: Certifique-se de ter Python 3.7+ instalado
3. **Porta ocupada**: Altere a porta no arquivo `app.py` se necessário
4. **Permissões**: Execute como administrador se houver problemas de escrita

### Logs e Debug:
- A aplicação roda em modo debug por padrão
- Logs aparecem no terminal onde foi executada
- Verifique o arquivo `pdf_merger.db` para dados do banco

---

## 🎉 Agradecimentos

Ferramenta desenvolvida com foco na **simplicidade** e **eficiência**, utilizando as melhores práticas de desenvolvimento web moderno.

**Versão atual**: 1.0.0  
**Última atualização**: Outubro 2025