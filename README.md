# 📄 PDF Merger - Ferramenta Profissional para Unir PDFs

> Uma aplicação web completa e moderna para unir múltiplos arquivos PDF, com interface intuitiva, histórico completo e sistema de deploy em produção.

[![Python](https://img.shields.io/badge/Python-3.7+-blue.svg)](https://python.org)
[![Flask](https://img.shields.io/badge/Flask-3.0.0-green.svg)](https://flask.palletsprojects.com)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ Funcionalidades Principais

### 🎯 Core Features
- ✅ **União Inteligente**: Combina 2+ PDFs mantendo qualidade e formatação
- ✅ **Interface Drag & Drop**: Arrastar e soltar arquivos intuitivamente
- ✅ **Histórico Completo**: Banco SQLite com todos os PDFs processados
- ✅ **Estatísticas Live**: Métricas em tempo real do uso da aplicação
- ✅ **Design Responsivo**: Interface otimizada para desktop, tablet e mobile

### 🛡️ Segurança & Performance
- ✅ **Validação Rigorosa**: Apenas arquivos PDF válidos são aceitos
- ✅ **Limpeza Automática**: Remove arquivos temporários após processamento
- ✅ **Configuração Flexível**: Ajustes de tamanho, timeout e limites
- ✅ **Deploy em Produção**: Scripts completos para Ubuntu Server

### 🎨 Interface Moderna
- ✅ **Logo Personalizado**: Identidade visual centralizada
- ✅ **Cores Profissionais**: Paleta verde harmoniosa (#155229, #b9f6ca)
- ✅ **Bootstrap 5.3**: Framework CSS moderno e responsivo
- ✅ **Font Awesome 6.0**: Ícones vetoriais profissionais

## 🛠️ Stack Tecnológico

### Backend
```
Flask 3.0.0      -> Framework web leve e poderoso
pypdf 6.1.1      -> Biblioteca moderna de PDF (sucessora PyPDF2)
SQLite3          -> Banco de dados embutido
Werkzeug 3.0.1   -> Utilities WSGI
```

### Frontend
```
Bootstrap 5.3.0  -> Framework CSS responsivo
Font Awesome 6.0 -> Biblioteca de ícones
JavaScript ES6   -> Funcionalidades interativas
CSS3 Modular     -> Estilos organizados e customizados
```

### Deploy & Produção
```
Gunicorn         -> Servidor WSGI para produção
Nginx            -> Proxy reverso e arquivos estáticos
Supervisor       -> Gerenciamento de processos
Ubuntu Server    -> Sistema operacional recomendado
```

## 🚀 Quick Start

### � Desenvolvimento Local

```bash
# 1. Clone o repositório
git clone https://github.com/CaioteSouza/merger_pdf.git
cd merger_pdf

# 2. Execute o launcher (Windows)
start.bat

# 3. Ou instale manualmente
pip install -r requirements.txt
python app.py

# 4. Acesse no navegador
http://localhost:8080
```

### 🌐 Deploy em Produção (Ubuntu)

```bash
# 1. Baixar e executar script de instalação
curl -sSL https://raw.githubusercontent.com/CaioteSouza/merger_pdf/master/deployment/install.sh | sudo bash

# 2. Ou instalação manual
sudo bash deployment/install.sh

# 3. Monitorar aplicação
sudo supervisorctl status pdf-merger
./deployment/monitor.sh
```

## 📁 Arquitetura do Projeto

```
📦 Merge_pdf/
├── 🐍 app.py                    # Aplicação Flask principal
├── ⚙️  config.py                # Configurações centralizadas
├── 📋 requirements.txt          # Dependências Python
├── 🚀 start.bat                # Launcher Windows
├── 📄 README.md                # Documentação principal
├── 
├── 📁 static/                   # Assets estáticos
│   ├── 🖼️  logo.png             # Logo da aplicação
│   └── 🎨 style.css            # Estilos CSS organizados
├── 
├── 📁 templates/               # Templates HTML
│   ├── 🏗️  base.html            # Layout base com navbar
│   ├── 🏠 index.html           # Página inicial (upload)
│   └── 📊 history.html         # Histórico de PDFs
├── 
├── 📁 docs/                    # Documentação
│   └── 📖 GUIA_RAPIDO.md       # Manual do usuário
├── 
├── 📁 scripts/                 # Scripts de correção
│   ├── 🔧 fix-app.sh           # Correção da aplicação
│   ├── 🛠️  fix-errors.sh        # Diagnóstico geral  
│   └── 🔀 fix-navigation.sh    # Correção de rotas
├── 
├── 📁 deployment/              # Deploy em produção
│   ├── 🏗️  install.sh           # Instalação automática
│   ├── 📊 monitor.sh           # Monitor em tempo real
│   ├── ⚙️  gunicorn.conf.py     # Configuração Gunicorn
│   ├── 🌐 wsgi.py              # Entry point WSGI
│   ├── 🔧 service.sh           # Gerenciador de serviço
│   ├── 🐧 start.sh             # Launcher Linux
│   └── 📋 pdf-merger.service   # Arquivo systemd
├── 
├── 📁 uploads/                 # PDFs temporários (auto-criado)
├── 📁 merged_pdfs/            # PDFs processados (auto-criado)
└── 🗄️  pdf_merger.db           # Banco SQLite (auto-criado)
```

## 🎯 Funcionalidades Detalhadas

### � Sistema de União de PDFs
```
📄 Input:  PDF1 (10 páginas) + PDF2 (5 páginas) + PDF3 (3 páginas)
⚡ Process: Merge inteligente preservando formatação
📊 Output: PDF_Final (18 páginas) + Histórico no banco
```

**Características:**
- ✅ **Ordem personalizada**: PDFs unidos na sequência escolhida
- ✅ **Preservação de qualidade**: Mantém resolução e formatação originais
- ✅ **Suporte ilimitado**: Qualquer número de páginas por PDF
- ✅ **Validação rigorosa**: Apenas arquivos PDF válidos aceitos
- ✅ **Feedback em tempo real**: Progress indicators durante processamento

### 🎨 Interface & User Experience

**Design System:**
```css
Cores Primárias:   #155229 (Verde escuro)
Cores Secundárias: #b9f6ca (Verde claro)
Background:        #f0f0f0 (Cinza neutro)
Acentos:          #a5d6a7 (Verde médio)
```

**Features UX:**
- 🖱️ **Drag & Drop nativo**: Arraste arquivos diretamente para área de upload
- 📱 **Mobile-first**: Interface 100% responsiva para todos os dispositivos
- 🎭 **Micro-interactions**: Animações suaves e feedback visual
- 🧭 **Navegação intuitiva**: Apenas 2 páginas principais (Início/Histórico)
- 🚨 **Sistema de alertas**: Flash messages com Bootstrap styling

### 💾 Sistema de Persistência

**Banco de Dados SQLite:**
```sql
Table: merged_pdfs
├── id (PRIMARY KEY)         -> Identificador único
├── filename                 -> Nome do arquivo gerado  
├── original_files          -> Lista de PDFs originais
├── file_path               -> Caminho físico do arquivo
├── total_pages             -> Número total de páginas
├── created_at              -> Timestamp de criação
└── file_size               -> Tamanho em bytes
```

**Features de Persistência:**
- 🗄️ **Auto-backup**: Histórico permanente de todas as operações
- 📊 **Métricas agregadas**: Estatísticas calculadas em tempo real
- 🔍 **Busca por metadados**: Filtros por data, tamanho, páginas
- ♻️ **Gestão de arquivos**: Download e exclusão com confirmação

### 📊 Dashboard & Analytics

**Cards de Estatísticas:**
- 📈 **Total de PDFs**: Contador de arquivos processados
- 📄 **Total de Páginas**: Soma cumulativa de todas as páginas
- 💽 **Volume de Dados**: Tamanho total dos arquivos gerados
- ⚖️ **Média por PDF**: Páginas médias por documento

**API Endpoints:**
```javascript
GET /api/stats
{
  "total_merged": 142,
  "total_pages": 3847,
  "total_size": 1073741824
}
```

## 🌐 Arquitetura & APIs

### 🔌 REST API Endpoints

| Método | Endpoint | Descrição | Resposta |
|--------|----------|-----------|----------|
| `GET` | `/` | Página principal | HTML |
| `POST` | `/upload` | Upload + merge PDFs | Redirect |
| `GET` | `/history` | Histórico completo | HTML |
| `GET` | `/download/<id>` | Download por ID | File |
| `POST` | `/delete/<id>` | Exclusão por ID | Redirect |
| `GET` | `/api/stats` | Estatísticas JSON | JSON |

### �️ Segurança & Validação

**Camadas de Proteção:**
```python
# 1. Validação de tipo de arquivo
ALLOWED_EXTENSIONS = ['pdf']

# 2. Limite de tamanho por arquivo  
MAX_FILE_SIZE = 50 * 1024 * 1024  # 50MB

# 3. Sanitização de nomes
secure_filename(user_input)

# 4. Limpeza automática
cleanup_temp_files()
```

**Proteções Implementadas:**
- 🛡️ **Path Traversal**: `secure_filename()` para nomes seguros
- 📏 **Size Limits**: Limite configurável por arquivo e request total
- 🧹 **Temp Cleanup**: Remoção automática de arquivos temporários
- 🔍 **File Validation**: Verificação de headers e extensões PDF

## 💻 Requisitos & Compatibilidade

### � Requisitos Mínimos

| Componente | Versão Mínima | Recomendado |
|------------|---------------|-------------|
| **Python** | 3.7+ | 3.11+ |
| **RAM** | 512MB | 2GB+ |
| **Storage** | 100MB | 1GB+ |
| **CPU** | 1 core | 2+ cores |

### 🌐 Navegadores Suportados

| Navegador | Versão | Status |
|-----------|--------|--------|
| **Chrome** | 90+ | ✅ Testado |
| **Firefox** | 88+ | ✅ Testado |
| **Safari** | 14+ | ✅ Compatível |
| **Edge** | 90+ | ✅ Compatível |

### �️ Sistemas Operacionais

| SO | Status | Deploy |
|----|--------|--------|
| **Windows** | ✅ Nativo | start.bat |
| **Ubuntu** | ✅ Produção | install.sh |
| **macOS** | ✅ Compatível | python app.py |
| **CentOS** | ⚠️ Manual | python app.py |

## 🚀 Deploy & Produção

### 🏗️ Deploy Automático (Ubuntu)

```bash
# Download e execução em uma linha
curl -sSL https://raw.githubusercontent.com/CaioteSouza/merger_pdf/master/deployment/install.sh | sudo bash
```

**O que o script faz:**
- 📦 Instala dependências (Python, Nginx, Supervisor)
- 🔧 Configura ambiente virtual isolado
- 🌐 Setup Nginx como proxy reverso
- 👤 Cria usuário dedicado `pdfmerger`
- 🗄️ Inicializa banco de dados SQLite
- 🔄 Configura Supervisor para auto-restart
- 🔥 Setup firewall básico com UFW
- 📊 Sistema de logs rotativos

### 📊 Monitoramento em Produção

```bash
# Monitor em tempo real
./deployment/monitor.sh

# Logs da aplicação
sudo tail -f /var/log/pdf-merger/app.log

# Status dos serviços
sudo supervisorctl status pdf-merger
```

### 🔧 Troubleshooting Avançado

```bash
# Diagnóstico completo
sudo bash scripts/fix-errors.sh

# Correção de navegação
sudo bash scripts/fix-navigation.sh

# Correção da aplicação
sudo bash scripts/fix-app.sh
```

## � Documentação & Recursos

### 📖 Guias Disponíveis

- 📘 **README.md**: Documentação técnica completa (este arquivo)
- 📗 **docs/GUIA_RAPIDO.md**: Manual do usuário final
- 📙 **config.py**: Configurações comentadas
- 📓 **Code Comments**: Documentação inline no código

### 🔗 Links Úteis

- 🐍 [pypdf Documentation](https://pypdf.readthedocs.io/)
- 🌶️ [Flask Documentation](https://flask.palletsprojects.com/)
- 🎨 [Bootstrap 5 Components](https://getbootstrap.com/docs/5.3/)
- � [Gunicorn Configuration](https://docs.gunicorn.org/)

## 🎯 Roadmap & Futuro

### 📅 Versão 2.0 (Planejada)
- [ ] 🔐 **Sistema de usuários**: Login/registro/perfis
- [ ] 📁 **Suporte multi-formato**: DOC, DOCX, PPT para PDF
- [ ] 🗜️ **Compressão inteligente**: Otimização automática de tamanho
- [ ] 👁️ **Preview integrado**: Visualização antes do merge
- [ ] 🌐 **API REST completa**: CRUD via JSON
- [ ] 📦 **Upload em lote**: Processamento de pastas inteiras

### � Versão 3.0 (Visão)
- [ ] ☁️ **Cloud storage**: AWS S3, Google Drive integration
- [ ] 🤖 **AI features**: OCR, content analysis
- [ ] 📊 **Advanced analytics**: Usage patterns, insights
- [ ] 🔌 **Plugin system**: Extensões customizadas
- [ ] 🌍 **Internacionalização**: Multi-idiomas
- [ ] 📱 **Mobile app**: React Native companion

## 📄 Licença & Contribuição

### 📋 Licença
```
MIT License - Uso livre para fins educacionais e comerciais
Copyright (c) 2025 PDF Merger Project
```

### 🤝 Como Contribuir
1. 🍴 Fork o repositório
2. 🌿 Crie uma branch: `git checkout -b feature/nova-funcionalidade`
3. 💻 Faça suas alterações
4. ✅ Teste suas mudanças
5. 📤 Submit um Pull Request

---

## 🎉 Reconhecimentos

### 👨‍💻 Desenvolvimento
**Core Team**: Arquitetura moderna, UX otimizada, deploy automatizado

### 🛠️ Tecnologias
**Open Source**: Flask, pypdf, Bootstrap, SQLite e comunidade

### 💡 Inspiração  
**Princípios**: Simplicidade, performance, experiência do usuário

---

<div align="center">

### 🚀 **PDF Merger v2.0** 
#### *A ferramenta definitiva para união de PDFs*

[![Deploy](https://img.shields.io/badge/Deploy-Ready-brightgreen.svg)](./deployment/)
[![Docs](https://img.shields.io/badge/Docs-Complete-blue.svg)](./docs/)
[![Support](https://img.shields.io/badge/Support-Active-orange.svg)](./scripts/)

**Desenvolvido com ❤️ para simplificar o trabalho com PDFs**

</div>