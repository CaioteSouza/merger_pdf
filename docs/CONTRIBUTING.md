# 🤝 Contribuindo para o PDF Merger

Obrigado por considerar contribuir para o PDF Merger! 🎉  
Este documento fornece diretrizes para contribuições e desenvolvimento.

---

## 📋 Índice

- [🚀 Como Contribuir](#-como-contribuir)
- [🛠️ Configuração do Ambiente](#️-configuração-do-ambiente)
- [📝 Padrões de Código](#-padrões-de-código)
- [🧪 Testes](#-testes)
- [📤 Enviando Contribuições](#-enviando-contribuições)
- [🐛 Reportando Bugs](#-reportando-bugs)
- [💡 Sugerindo Funcionalidades](#-sugerindo-funcionalidades)

---

## 🚀 Como Contribuir

### 🎯 **Tipos de Contribuições Bem-vindas**

- 🐛 **Correções de bugs**
- ✨ **Novas funcionalidades**
- 📚 **Melhorias na documentação**
- 🎨 **Melhorias na interface**
- ⚡ **Otimizações de performance**
- 🔒 **Melhorias de segurança**
- 🧪 **Adição de testes**

### 📊 **Áreas Prioritárias**

| Área | Prioridade | Descrição |
|------|-----------|-----------|
| **🔒 Segurança** | 🔴 Alta | Validações, sanitização, proteções |
| **⚡ Performance** | 🟡 Média | Otimização de processamento |
| **📱 UX/UI** | 🟡 Média | Melhorias na experiência do usuário |
| **🧪 Testes** | 🟢 Baixa | Cobertura de testes automatizados |
| **📚 Docs** | 🟢 Baixa | Documentação e tutoriais |

---

## 🛠️ Configuração do Ambiente

### 📋 **Pré-requisitos**

- **Python 3.7+** (recomendado 3.11+)
- **Git** para controle de versão
- **Editor de código** (VS Code recomendado)

### 🔧 **Setup Local**

```bash
# 1. Fork e clone o repositório
git clone https://github.com/SEU_USUARIO/pdf-merger.git
cd pdf-merger

# 2. Criar ambiente virtual
python -m venv venv

# 3. Ativar ambiente virtual
# Windows
venv\Scripts\activate
# Linux/macOS  
source venv/bin/activate

# 4. Instalar dependências
pip install -r requirements.txt
pip install -r requirements-dev.txt  # Dependências de desenvolvimento

# 5. Executar aplicação
python app.py
```

### 🐳 **Setup com Docker (Opcional)**

```bash
# Build da imagem
docker build -t pdf-merger .

# Executar container
docker run -p 5000:5000 pdf-merger
```

---

## 📝 Padrões de Código

### 🐍 **Python - PEP 8**

```python
# ✅ Bom exemplo
def merge_pdfs(file_list: List[str]) -> str:
    """
    Une múltiplos arquivos PDF em um único documento.
    
    Args:
        file_list: Lista de caminhos para arquivos PDF
        
    Returns:
        Caminho para o arquivo PDF resultado
        
    Raises:
        ValueError: Se menos de 2 arquivos fornecidos
        FileNotFoundError: Se algum arquivo não existe
    """
    if len(file_list) < 2:
        raise ValueError("Mínimo 2 arquivos necessários")
    
    # Código de implementação...
    return output_path

# ❌ Exemplo ruim
def merge(files):
    if len(files)<2:raise ValueError("erro")
    #código sem documentação
    return result
```

### 🎨 **CSS - Organização**

```css
/* ✅ Estrutura organizada */
/* ======================
   1. RESET & BASE
   ====================== */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* ======================
   2. VARIABLES
   ====================== */
:root {
    --primary-color: #155229;
    --secondary-color: #b9f6ca;
    --background-color: #f0f0f0;
}

/* ======================
   3. COMPONENTS
   ====================== */
.upload-area {
    border: 2px dashed var(--primary-color);
    border-radius: 10px;
    padding: 2rem;
    transition: all 0.3s ease;
}
```

### 📜 **JavaScript - Padrões Modernos**

```javascript
// ✅ ES6+ com async/await
const uploadFiles = async (files) => {
    try {
        const formData = new FormData();
        files.forEach(file => formData.append('files', file));
        
        const response = await fetch('/upload', {
            method: 'POST',
            body: formData
        });
        
        if (!response.ok) {
            throw new Error(`HTTP ${response.status}`);
        }
        
        return await response.json();
    } catch (error) {
        console.error('Upload failed:', error);
        throw error;
    }
};

// ❌ Callback hell
function uploadFiles(files, callback) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                callback(null, xhr.responseText);
            } else {
                callback(new Error('Failed'));
            }
        }
    };
}
```

### 📝 **Commits - Conventional Commits**

```bash
# Formato: <tipo>(<escopo>): <descrição>

# ✅ Exemplos bons
feat(upload): add drag and drop functionality
fix(merge): resolve memory leak in PDF processing  
docs(readme): update installation instructions
style(css): improve responsive design for mobile
refactor(db): optimize database queries
test(upload): add unit tests for file validation
chore(deps): update Flask to version 3.0.1

# ❌ Exemplos ruins
update stuff
fix bug
changes
wip
```

---

## 🧪 Testes

### 🔬 **Estrutura de Testes**

```
tests/
├── unit/              # Testes unitários
│   ├── test_merge.py
│   ├── test_database.py
│   └── test_validation.py
├── integration/       # Testes de integração  
│   ├── test_upload_flow.py
│   └── test_api_endpoints.py
└── fixtures/          # Dados de teste
    ├── sample.pdf
    └── corrupted.pdf
```

### 🧩 **Exemplo de Teste Unitário**

```python
import pytest
from app import create_app, db
from models import MergedPDF

@pytest.fixture
def app():
    """Fixture da aplicação Flask para testes."""
    app = create_app(testing=True)
    with app.app_context():
        db.create_all()
        yield app
        db.drop_all()

@pytest.fixture
def client(app):
    """Cliente de teste HTTP."""
    return app.test_client()

def test_merge_pdf_success(client):
    """Teste de merge de PDFs com sucesso."""
    with open('tests/fixtures/sample.pdf', 'rb') as f1, \
         open('tests/fixtures/sample.pdf', 'rb') as f2:
        
        response = client.post('/upload', data={
            'files': [f1, f2]
        })
        
        assert response.status_code == 302  # Redirect
        assert MergedPDF.query.count() == 1

def test_merge_pdf_invalid_file(client):
    """Teste com arquivo inválido."""
    with open('tests/fixtures/text.txt', 'rb') as f:
        response = client.post('/upload', data={
            'files': [f]
        })
        
        assert response.status_code == 400
        assert b'Apenas arquivos PDF' in response.data
```

### 🏃 **Executando Testes**

```bash
# Todos os testes
pytest

# Testes com cobertura
pytest --cov=app --cov-report=html

# Testes específicos
pytest tests/unit/test_merge.py -v

# Testes com output detalhado
pytest -s -v
```

---

## 📤 Enviando Contribuições

### 🌿 **Workflow Git**

```bash
# 1. Criar branch para feature/fix
git checkout -b feature/nova-funcionalidade

# 2. Fazer alterações e commits
git add .
git commit -m "feat: add nova funcionalidade incrível"

# 3. Push para seu fork
git push origin feature/nova-funcionalidade

# 4. Abrir Pull Request no GitHub
```

### ✅ **Checklist do Pull Request**

Antes de enviar, verifique:

- [ ] **Código segue padrões** definidos neste documento
- [ ] **Testes passam** localmente (`pytest`)
- [ ] **Documentação atualizada** se necessário
- [ ] **Commit messages** seguem padrão conventional
- [ ] **Branch atualizada** com main (`git rebase main`)
- [ ] **Descrição clara** do que foi alterado e por quê

### 📋 **Template do Pull Request**

```markdown
## 📝 Descrição
Breve descrição das mudanças realizadas.

## 🎯 Tipo de Mudança
- [ ] 🐛 Bug fix
- [ ] ✨ Nova funcionalidade  
- [ ] 📚 Atualização de documentação
- [ ] 🎨 Mudança de estilo
- [ ] ♻️ Refatoração
- [ ] 🧪 Testes

## 🧪 Como Testar
1. Passo 1
2. Passo 2  
3. Resultado esperado

## 📋 Checklist
- [ ] Testes passam localmente
- [ ] Código segue padrões do projeto
- [ ] Documentação atualizada
- [ ] Commits seguem padrão conventional

## 📸 Screenshots
Se aplicável, adicione screenshots das mudanças visuais.
```

---

## 🐛 Reportando Bugs

### 📋 **Template de Bug Report**

```markdown
**🐛 Descrição do Bug**
Descrição clara e concisa do problema.

**🔄 Como Reproduzir**
1. Acesse '...'
2. Clique em '...'  
3. Faça upload de '...'
4. Observe o erro

**✅ Comportamento Esperado**
O que deveria acontecer.

**📸 Screenshots**
Se aplicável, adicione screenshots.

**🖥️ Ambiente:**
- OS: [Windows 10, Ubuntu 20.04, macOS]
- Navegador: [Chrome 120, Firefox 115]
- Versão do Python: [3.11.2]
- Versão do PDF Merger: [2.0.0]

**📝 Informações Adicionais**
Qualquer contexto adicional sobre o problema.
```

### 🔍 **Investigação de Bugs**

Antes de reportar, verifique:

1. **Reproduza o bug** consistentemente
2. **Verifique logs** no console do navegador (F12)
3. **Teste em navegador diferente**
4. **Procure issues similares** já reportadas
5. **Colete informações** do ambiente

---

## 💡 Sugerindo Funcionalidades

### 📋 **Template de Feature Request**

```markdown
**✨ Descrição da Funcionalidade**
Descrição clara da funcionalidade desejada.

**🎯 Problema que Resolve**
Que problema esta funcionalidade resolve?

**💡 Solução Proposta**  
Como você imagina que deveria funcionar?

**🔄 Alternativas Consideradas**
Outras soluções que você considerou?

**📊 Impacto Esperado**
Como isso beneficiaria os usuários?

**🎨 Mockups/Wireframes**
Se aplicável, adicione esboços da interface.
```

### 🎯 **Priorização de Features**

Features são priorizadas baseadas em:

- **👥 Impacto nos usuários** (quantos se beneficiam)
- **⚡ Complexidade de implementação** (esforço necessário)
- **🎯 Alinhamento com roadmap** (visão do produto)
- **🔧 Viabilidade técnica** (possível com stack atual)

---

## 🏆 Reconhecimento de Contribuidores

### 🎖️ **Hall da Fama**

Contribuidores serão reconhecidos no README principal:

- **🥇 Core Contributors**: Múltiplas contribuições significativas
- **🥈 Active Contributors**: Contribuições regulares  
- **🥉 Contributors**: Primeira contribuição aceita

### 🎁 **Recompensas**

- **Primeira contribuição**: Mention no README
- **5+ contribuições**: Badge de "Active Contributor"  
- **Contribuição major**: Feature credit no changelog

---

## 📞 Dúvidas e Suporte

### 💬 **Canais de Comunicação**

- **📧 Email**: Para questões privadas
- **💬 GitHub Discussions**: Para discussões públicas
- **🐛 GitHub Issues**: Para bugs e features
- **📱 Chat**: Para dúvidas rápidas

### 📚 **Recursos Úteis**

- **🐍 Python**: [PEP 8 Style Guide](https://pep8.org/)
- **🌶️ Flask**: [Documentation](https://flask.palletsprojects.com/)
- **🧪 pytest**: [Documentation](https://docs.pytest.org/)
- **🎨 Bootstrap**: [Components](https://getbootstrap.com/docs/5.3/)

---

<div align="center">

## 🙏 **Obrigado por Contribuir!**

### *Sua contribuição faz a diferença*

[![Contributors](https://img.shields.io/github/contributors/user/pdf-merger.svg)](./CONTRIBUTORS.md)
[![Pull Requests](https://img.shields.io/github/issues-pr/user/pdf-merger.svg)](../../pulls)
[![Issues](https://img.shields.io/github/issues/user/pdf-merger.svg)](../../issues)

**Desenvolvido com ❤️ pela comunidade**

</div>