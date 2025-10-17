# 📄 PDF Merger - Ferramenta Profissional para Unir PDFs

<div align="center">

![PDF Merger](https://img.shields.io/badge/PDF_Merger-v2.0-brightgreen.svg?style=for-the-badge)
![Ubuntu](https://img.shields.io/badge/Ubuntu-Server-orange.svg?style=for-the-badge)
![Python](https://img.shields.io/badge/Python-3.8+-blue.svg?style=for-the-badge)

**🎯 Une múltiplos PDFs em um único documento com interface moderna e deploy automatizado**

[![Deploy](https://img.shields.io/badge/Deploy-Ubuntu_Only-orange.svg)](./docs/DEPLOY_UBUNTU.md)
[![Manual](https://img.shields.io/badge/Manual-Usuário-blue.svg)](./docs/MANUAL_USUARIO.md)
[![Dev](https://img.shields.io/badge/Dev-Diary-purple.svg)](./docs/DIARIO_DESENVOLVIMENTO.md)

</div>

---

## 🚀 **Quick Start**

### 🌐 **Para Usuários Finais**
Acesse a ferramenta pelo navegador no endereço fornecido pelo administrador.  
📖 **Manual completo**: [`docs/MANUAL_USUARIO.md`](./docs/MANUAL_USUARIO.md)

### 💻 **Para Desenvolvedores**
```bash
# 1. Clone o repositório
git clone https://github.com/CaioteSouza/merger_pdf.git
cd merger_pdf

# 2. Desenvolvimento local (qualquer SO)
python -m venv .venv
source .venv/bin/activate  # Linux/macOS
# ou .venv\Scripts\activate # Windows
pip install -r requirements.txt
python app.py

# 3. Deploy em produção (APENAS UBUNTU)
curl -sSL https://raw.githubusercontent.com/CaioteSouza/merger_pdf/master/deployment/install.sh | sudo bash
```

---

## ⚠️ **IMPORTANTE: Compatibilidade de Sistema**

| Sistema | Desenvolvimento | Produção | Status |
|---------|----------------|----------|--------|
| **🐧 Ubuntu 18.04+** | ✅ Suportado | ✅ **RECOMENDADO** | Deploy automatizado |
| **🪟 Windows** | ✅ Suportado | ❌ Não suportado | Apenas desenvolvimento |
| **🍎 macOS** | ✅ Suportado | ❌ Não suportado | Apenas desenvolvimento |
| **🐧 Outras Linux** | ⚠️ Manual | ⚠️ Manual | Scripts não testados |

**💡 Para produção, use Ubuntu Server para garantir compatibilidade total dos scripts de deploy.**

---

## 📚 **Documentação Completa**

### 📖 **Guias por Perfil**

| Documento | Público-Alvo | Descrição |
|-----------|--------------|-----------|
| **🚀 [DEPLOY_UBUNTU.md](./docs/DEPLOY_UBUNTU.md)** | **DevOps/SysAdmin** | **Deploy completo em Ubuntu** |
| **📱 [MANUAL_USUARIO.md](./docs/MANUAL_USUARIO.md)** | **Usuários Finais** | **Guia de uso da ferramenta** |
| **🔧 [DIARIO_DESENVOLVIMENTO.md](./docs/DIARIO_DESENVOLVIMENTO.md)** | **Desenvolvedores** | **Histórico técnico e decisões** |

### 🎯 **Acesso Rápido por Necessidade**

- **🚀 Quero fazer deploy**: → [`DEPLOY_UBUNTU.md`](./docs/DEPLOY_UBUNTU.md)
- **📱 Quero usar a ferramenta**: → [`MANUAL_USUARIO.md`](./docs/MANUAL_USUARIO.md)  
- **🔧 Quero entender o código**: → [`DIARIO_DESENVOLVIMENTO.md`](./docs/DIARIO_DESENVOLVIMENTO.md)

---

## ✨ **Principais Funcionalidades**

### 🎯 **Para Usuários**
- ✅ **Drag & Drop**: Interface moderna para upload
- ✅ **Múltiplos PDFs**: Combina 2+ arquivos em ordem específica
- ✅ **Histórico Completo**: Banco SQLite com todos os PDFs criados
- ✅ **Estatísticas Live**: Métricas de uso em tempo real
- ✅ **Mobile Friendly**: Interface responsiva para qualquer dispositivo

### 🛡️ **Para Administradores** 
- ✅ **Deploy Automatizado**: Scripts para Ubuntu Server
- ✅ **Produção Robusta**: Gunicorn + Supervisor + 17 workers
- ✅ **Segurança**: Validação rigorosa + firewall configurado
- ✅ **Monitoramento**: Logs detalhados + scripts de diagnóstico
- ✅ **Manutenção**: Ferramentas de correção automática

---

## 🛠️ **Stack Tecnológico Resumido**

| Camada | Tecnologia | Versão | Propósito |
|--------|------------|--------|-----------|
| **Backend** | Flask | 3.0.0 | Framework web |
| **PDF Engine** | pypdf | 6.1.1 | Manipulação de PDFs |
| **Database** | SQLite3 | - | Histórico e estatísticas |
| **Frontend** | Bootstrap | 5.3.0 | Interface responsiva |
| **Deploy** | Gunicorn + Supervisor | - | Produção Ubuntu |

**📋 Para detalhes técnicos completos**: [`DIARIO_DESENVOLVIMENTO.md`](./docs/DIARIO_DESENVOLVIMENTO.md)---

## 📁 **Arquitetura do Projeto**

```
📦 Merge_pdf/
├── 🐍 app.py                    # Aplicação Flask principal
├── ⚙️  config.py                # Configurações centralizadas
├── 📋 requirements.txt          # Dependências Python
├── 🖼️  logo.png                 # Logo da aplicação (raiz)
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
├── 📁 docs/                    # Documentação completa
│   ├── 📋 RESUMO_EXECUTIVO.md  # Visão executiva
│   ├── 🚀 GUIA_RAPIDO.md       # Manual do usuário
│   ├── 📝 CHANGELOG.md         # Histórico versões
│   ├── 🤝 CONTRIBUTING.md      # Guia contribuição
│   └── ✅ VERIFICACAO_FINAL.md # Auditoria projeto
├── 
├── 📁 scripts/                 # Scripts de correção
│   ├── 🔄 complete-reinstall.sh # Reinstalação total
│   ├── 🔧 fix-app.sh           # Correção da aplicação
│   ├── 🛠️  fix-errors.sh        # Diagnóstico geral  
│   └── 🔀 fix-navigation.sh    # Correção de rotas
├── 
├── 📁 deployment/              # Deploy em produção (OTIMIZADO)
│   ├── 🏗️  install.sh           # Instalação automática + firewall
│   ├── 📊 monitor.sh           # Monitor em tempo real
│   ├── ⚙️  gunicorn.conf.py     # Configuração Gunicorn 17 workers
│   └── 🌐 wsgi.py              # Entry point WSGI
├── 
├── 📁 uploads/                 # PDFs temporários (auto-criado)
├── 📁 merged_pdfs/            # PDFs processados (auto-criado)
└── 🗄️  pdf_merger.db           # Banco SQLite (auto-criado)
```

---

## 🔧 **Suporte e Manutenção**

### 🆘 **Problemas Comuns**
- **🚀 Deploy não funciona**: Verifique se está usando Ubuntu
- **📱 Usuário com dúvidas**: Direcione para [`MANUAL_USUARIO.md`](./docs/MANUAL_USUARIO.md)
- **🔧 Erro técnico**: Execute scripts em `scripts/fix-*.sh`
- **📊 Monitoramento**: Use `deployment/monitor.sh`

### 📞 **Canais de Suporte**
- **💬 GitHub Issues**: Para bugs e melhorias
- **📚 Documentação**: 3 guias especializados em `docs/`
- **🛠️ Scripts**: Ferramentas automáticas em `scripts/`

---

## 📈 **Status do Projeto & Roadmap**

### ✅ **Versão Atual: 2.0**
- **📊 Funcionalidades**: 15+ implementadas
- **📁 Estrutura**: Totalmente organizada
- **📚 Documentação**: 3 guias completos
- **🐧 Deploy Ubuntu**: 100% automatizado
- **🧹 Código**: Limpo e otimizado

### 🎯 **Próximas Versões (Roadmap)**

#### 📅 **Versão 2.1 (Próxima - Q2 2025)**
- [ ] 📁 **Suporte multi-formato**: DOC, DOCX, PPT para PDF
- [ ] 🗜️ **Compressão inteligente**: Otimização automática de tamanho
- [ ] 👁️ **Preview integrado**: Visualização antes do merge
- [ ] 🌐 **API REST completa**: CRUD via JSON endpoints
- [ ] 📦 **Upload em lote**: Processamento de pastas inteiras
- [ ] 🔄 **Processamento background**: Tasks assíncronas para arquivos grandes

#### 📅 **Versão 3.0 (Visão Longo Prazo)**
- [ ] 🔐 **Sistema de usuários**: Login/registro/perfis personalizados
- [ ] ☁️ **Cloud storage**: AWS S3, Google Drive integration
- [ ] 🤖 **AI features**: OCR, content analysis, categorização automática
- [ ] 📊 **Advanced analytics**: Usage patterns, insights detalhados
- [ ] 🔌 **Plugin system**: Extensões customizadas pela comunidade
- [ ] 🌍 **Internacionalização**: Multi-idiomas (EN, ES, FR)
- [ ] 📱 **Mobile app**: React Native companion

---

## 📄 **Licença & Contribuição**

### 📋 **Licença**
```
MIT License - Uso livre para fins educacionais e comerciais
Copyright (c) 2025 PDF Merger Project
```
---

<div align="center">

## 🎉 **Projeto Completo e Documentado**

### *Do desenvolvimento local ao deploy em produção*

**Para começar, acesse a documentação específica para seu perfil acima** ⬆️

[![Desenvolvido com ❤️](https://img.shields.io/badge/Desenvolvido%20com-%E2%9D%A4%EF%B8%8F-red.svg)]()
[![Ubuntu Ready](https://img.shields.io/badge/Ubuntu-Ready-orange.svg)]()

</div>