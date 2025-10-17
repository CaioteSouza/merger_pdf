# 📋 Changelog - PDF Merger

Todas as mudanças notáveis deste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Semantic Versioning](https://semver.org/lang/pt-BR/).

---

## [2.0.0] - 2025-01-15

### 🚀 Adicionado
- **Nova interface moderna** com Bootstrap 5.3.0
- **Dashboard com estatísticas** em tempo real
- **Sistema de deploy automatizado** para Ubuntu Server
- **Scripts de monitoramento** e correção automática
- **Validação avançada** de arquivos PDF
- **Sistema de limpeza automática** de arquivos temporários
- **Logs rotativos** para melhor gestão
- **Estrutura de projeto organizada** em diretórios lógicos
- **Documentação completa** com guias técnicos e de usuário
- **Suporte a arquivos de até 50MB** (aumento de 16MB)

### 🔄 Alterado
- **Migração de PyPDF2 para pypdf** 6.1.1 (biblioteca mais moderna)
- **Cores da interface** para esquema verde personalizado
- **Estrutura de arquivos** reorganizada em `docs/`, `scripts/`, `deployment/`
- **Sistema de navegação** aprimorado com correções automáticas
- **Performance de processamento** otimizada para arquivos grandes
- **Responsividade mobile** melhorada significativamente

### 🛠️ Corrigido  
- **Problemas de navegação** após merge de PDFs
- **Conflitos de porta** no deploy em produção
- **Validação de tipos de arquivo** mais rigorosa
- **Limpeza de memória** após processamento
- **Tratamento de erros** mais robusto e informativo

### 🔒 Segurança
- **Implementação de secure_filename()** para prevenir path traversal  
- **Validação de MIME types** além de extensões
- **Limitação rigorosa de tamanho** de arquivos
- **Sanitização de inputs** do usuário
- **Limpeza automática** de uploads temporários

---

## [1.0.0] - 2024-12-01

### 🚀 Adicionado (Lançamento Inicial)
- **Funcionalidade básica de merge** de múltiplos PDFs
- **Interface web simples** com Flask
- **Sistema de upload** drag & drop
- **Banco de dados SQLite** para histórico
- **Download de PDFs unidos**
- **Exclusão de arquivos** do histórico
- **Estatísticas básicas** de uso
- **Design responsivo básico**
- **Validação de arquivos PDF**
- **Sistema de flash messages**

### 🛠️ Técnico
- **Flask 3.0.0** como framework web
- **PyPDF2** para manipulação de PDFs
- **SQLite3** para persistência de dados  
- **Bootstrap 5** para interface
- **JavaScript vanilla** para interações
- **Werkzeug** para upload seguro de arquivos

---

## 🔮 Próximas Versões

### [2.1.0] - Planejado para Q2 2025
- [ ] **Suporte a múltiplos formatos** (DOC, DOCX, PPT → PDF)
- [ ] **Compressão inteligente** de PDFs resultantes
- [ ] **Preview de PDFs** antes do merge
- [ ] **API REST** completa com endpoints JSON
- [ ] **Processamento em background** para arquivos grandes
- [ ] **Notificações push** para conclusão de tarefas

### [2.2.0] - Planejado para Q3 2025  
- [ ] **Sistema de usuários** com login/registro
- [ ] **Perfis personalizados** e preferências
- [ ] **Histórico por usuário** isolado
- [ ] **Compartilhamento de PDFs** entre usuários
- [ ] **Controle de acesso** granular
- [ ] **Dashboard administrativo**

### [3.0.0] - Visão de Longo Prazo
- [ ] **Cloud storage integration** (AWS S3, Google Drive)
- [ ] **OCR e análise de conteúdo** com AI
- [ ] **Mobile app** React Native
- [ ] **Plugin system** para extensões
- [ ] **Internacionalização** multi-idiomas
- [ ] **Analytics avançados** de uso

---

## 📊 Estatísticas de Versões

| Versão | Linhas de Código | Arquivos | Funcionalidades | Data Lançamento |
|--------|------------------|----------|-----------------|-----------------|
| **2.0.0** | ~2,500 | 25+ | 15+ | 15/01/2025 |
| **1.0.0** | ~800 | 8 | 8 | 01/12/2024 |

---

## 🏷️ Tags de Commit

### Convenção de Commits
```
feat: nova funcionalidade
fix: correção de bug
docs: atualização de documentação  
style: mudanças de estilo (sem alteração de lógica)
refactor: refatoração de código
test: adição ou correção de testes
chore: tarefas de manutenção
```

### Exemplos de Commits Recentes
```
feat: add automated deployment scripts for Ubuntu
fix: resolve navigation issues after PDF merge
docs: update README with comprehensive documentation  
refactor: reorganize project structure into logical directories
chore: update dependencies to latest versions
```

---

## 🤝 Contribuições

Quer contribuir para o próximo release? Veja como:

1. **Fork** o repositório
2. **Crie** uma branch: `git checkout -b feature/nova-funcionalidade`
3. **Commit** suas mudanças: `git commit -m 'feat: add nova funcionalidade'`
4. **Push** para a branch: `git push origin feature/nova-funcionalidade`
5. **Abra** um Pull Request

---

## 📞 Reporte de Bugs

Encontrou um problema? Ajude-nos a melhorar:

- 🐛 **GitHub Issues**: Para bugs e feature requests
- 📧 **Email**: Para suporte técnico
- 💬 **Discussões**: Para ideias e sugestões

---

<div align="center">

**Desenvolvido com ❤️ para máxima produtividade**

[![Versão Atual](https://img.shields.io/badge/versão-2.0.0-brightgreen.svg)](./CHANGELOG.md)
[![Status](https://img.shields.io/badge/status-ativo-green.svg)]()
[![Contribuições](https://img.shields.io/badge/contribuições-bem--vindas-blue.svg)]()

</div>