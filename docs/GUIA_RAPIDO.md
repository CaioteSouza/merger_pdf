# 🔄 PDF Merger - Guia Completo do Usuário

<div align="center">

![PDF Merger](https://img.shields.io/badge/PDF_Merger-v2.0-brightgreen.svg?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-green.svg?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Web-blue.svg?style=for-the-badge)

**A ferramenta definitiva para união de PDFs**

</div>

---

## 🎯 O que é o PDF Merger?

O **PDF Merger** é uma **aplicação web profissional** que permite unir múltiplos arquivos PDF em um único documento, com interface moderna e recursos avançados de gerenciamento.

### ✨ **Principais Vantagens**
- 🚀 **Processamento local**: Seus arquivos não saem do seu computador
- 💾 **Histórico permanente**: Todos os PDFs criados ficam salvos
- 📊 **Estatísticas detalhadas**: Acompanhe sua produtividade
- 🎨 **Interface moderna**: Design responsivo e intuitivo
- 🔒 **100% seguro**: Validação rigorosa e limpeza automática

---

## 🚀 Como Iniciar a Aplicação

### 💻 **Método Simples (Windows)**
1. Execute o arquivo **`start.bat`**
2. Aguarde a instalação das dependências (apenas na primeira vez)
3. A aplicação abrirá automaticamente no navegador em `http://localhost:5000`

### 🐧 **Método Manual (Qualquer SO)**
```bash
# Instalar dependências
pip install -r requirements.txt

# Executar aplicação
python app.py
```

### 🌐 **Deploy em Produção (Ubuntu)**
```bash
# Download e instalação automática
curl -sSL https://raw.githubusercontent.com/user/repo/master/deployment/install.sh | sudo bash
```

---

## 📱 Tutorial Completo de Uso

### 1️⃣ **Upload e União de PDFs**

#### 🖱️ **Método 1: Drag & Drop (Recomendado)**
1. **Abra** a página principal
2. **Arraste** os arquivos PDF diretamente para a área marcada
3. **Solte** os arquivos (mínimo 2 PDFs)
4. **Confirme** a lista de arquivos selecionados
5. **Clique** em "Unir PDFs" (botão verde)

#### 📁 **Método 2: Seleção Manual**
1. **Clique** em "Selecionar Arquivos"
2. **Navegue** até a pasta dos PDFs
3. **Selecione** múltiplos arquivos usando:
   - `Ctrl + Clique` (Windows/Linux)
   - `Cmd + Clique` (macOS)
4. **Confirme** e clique em "Unir PDFs"

#### ⚡ **Processo de União**
```
📄 Validação → 🔄 Processamento → ✅ Conclusão → 📊 Redirecionamento
```

### 2️⃣ **Gerenciamento de Histórico**

#### 📊 **Acessando o Histórico**
1. **Clique** em "Histórico" no menu superior
2. **Visualize** todos os PDFs unidos com detalhes completos:

| Campo | Descrição | Exemplo |
|-------|-----------|---------|
| **📄 Nome** | Arquivo final gerado | `documento_unido_20250115.pdf` |
| **📋 Originais** | Lista de arquivos fonte | `arquivo1.pdf, arquivo2.pdf` |
| **📊 Páginas** | Total de páginas | `42 páginas` |
| **💽 Tamanho** | Tamanho do arquivo | `2.5 MB` |
| **📅 Data** | Timestamp da criação | `15/01/2025 14:30` |

#### ⚡ **Ações Disponíveis**
- **💾 Download**: Baixar PDF novamente (botão verde)
- **🗑️ Excluir**: Remover do histórico com confirmação (botão vermelho)

### 3️⃣ **Dashboard de Estatísticas**

#### 📈 **Métricas em Tempo Real**
Na página inicial e histórico, veja cards com:

```
📄 Total de PDFs Unidos      📊 Total de Páginas
   ✨ 1,247 documentos          ✨ 28,451 páginas

💽 Volume Total              ⚖️ Média por PDF  
   ✨ 2.8 GB processados        ✨ 23 páginas/PDF
```

### 4️⃣ **Sistema de Navegação**

#### 🧭 **Elementos da Interface**
- **🏠 Logo Centralizado**: Identidade visual no header
- **📋 Menu Superior**: Links diretos para "Início" e "Histórico"
- **📱 Design Responsivo**: Funciona perfeitamente em:
  - 💻 Desktop (1920x1080+)
  - 📱 Tablet (768x1024)
  - 📲 Mobile (375x667)
- ✅ **Múltiplos PDFs**: Une 2 ou mais arquivos em ordem específica
- ✅ **Qualquer tamanho**: PDFs com qualquer número de páginas
- ✅ **Histórico completo**: Todos os arquivos são salvos no banco de dados
- ✅ **Design responsivo**: Funciona perfeitamente em qualquer dispositivo
- ✅ **Banco de dados SQLite**: Persistência automática de dados
- ✅ **Logo personalizado**: Identidade visual própria centralizada
- ✅ **Cores personalizadas**: Interface verde e branca otimizada
- ✅ **Navegação simples**: Menu intuitivo Início/Histórico
- ✅ **Confirmações de segurança**: Avisos antes de excluir arquivos
- ✅ **Estatísticas visuais**: Cards coloridos com informações em tempo real

## 🔧 Estrutura de Arquivos Atualizada

```
Merge_pdf/
├── start.bat          # Inicia a aplicação
├── app.py             # Aplicação principal Flask
├── config.py          # Configurações personalizáveis
├── requirements.txt   # Dependências Python
├── README.md          # Documentação técnica completa
├── GUIA_RAPIDO.md     # Este guia de uso
├── .gitignore         # Arquivos ignorados pelo Git
├── static/            # Arquivos estáticos
│   ├── logo.png       # Logo da aplicação
│   └── style.css      # Estilos CSS organizados
├── templates/         # Interface web
│   ├── base.html      # Template base com navbar
│   ├── index.html     # Página principal (upload)
│   └── history.html   # Página de histórico
├── uploads/           # PDFs temporários (auto-criado)
├── merged_pdfs/       # PDFs unidos (auto-criado)
└── pdf_merger.db      # Banco SQLite (auto-criado)
```

## 📋 Requisitos do Sistema

- **Python 3.7+** (testado até Python 3.13)
- **Navegador moderno** (Chrome, Firefox, Safari, Edge)
- **Pelo menos 100MB** de espaço livre
- **Sistema**: Windows, Linux ou macOS

## 🆘 Solução de Problemas Comuns

### ❌ Erro ao iniciar
- **Problema**: Aplicação não inicia
- **Solução**: 
  - Certifique-se que o Python está instalado
  - Execute: `pip install -r requirements.txt`
  - Verifique se a porta 5000 não está ocupada

### ❌ Erro ao unir PDFs
- **Problema**: Falha no processamento
- **Solução**:
  - Verifique se os arquivos são PDFs válidos
  - Certifique-se que os arquivos não estão corrompidos
  - Tente com arquivos menores primeiro

### ❌ Porta ocupada
- **Problema**: "Porta 5000 já está em uso"
- **Solução**:
  - Feche outros programas que possam usar a porta
  - Reinicie o computador se necessário
  - Ou altere a porta no arquivo `config.py`

### ❌ Arquivo não baixa
- **Problema**: Download não funciona
- **Solução**:
  - Verifique se o arquivo ainda existe no histórico
  - Tente atualizar a página
  - Verifique permissões de escrita na pasta

## 🎯 Exemplos de Uso Prático

### 📄 Cenário 1: Documentos Empresariais
- **Situação**: Unir contratos, relatórios e anexos
- **Processo**: 
  1. Selecione: contrato.pdf + relatorio.pdf + anexos.pdf
  2. Arraste para a área de upload
  3. Clique "Unir PDFs"
  4. Baixe o arquivo final do histórico
- **Resultado**: Um documento único com tudo organizado

### 🎓 Cenário 2: Material Acadêmico
- **Situação**: Compilar artigos científicos
- **Processo**:
  1. Reúna todos os PDFs dos artigos
  2. Use drag & drop para adicionar todos de uma vez
  3. Confira a ordem na lista
  4. Process e salve o compêndio
- **Resultado**: Biblioteca personalizada em um arquivo

### 🏠 Cenário 3: Documentos Pessoais
- **Situação**: Organizar documentos para processo
- **Processo**:
  1. Escaneie documentos individuais
  2. Una tudo na ordem necessária
  3. Mantenha histórico para futuras consultas
  4. Compartilhe arquivo único quando necessário
- **Resultado**: Pasta digital organizada

## 🎨 Interface e Design

- **🎯 Header**: Logo centralizado com navegação nas laterais
- **🟢 Botões**: Verde claro (#b9f6ca) para ações principais
- **⚫ Títulos**: Verde escuro (#155229) para hierarquia visual
- **📊 Cards**: Estatísticas com cores diferenciadas e texto branco
- **🔘 Ações**: Botões de download (verde) e exclusão (vermelho) padrão

## 💡 Dicas de Uso

- **🔄 Mantenha rodando**: Deixe a aplicação aberta para uso rápido
- **📁 Organize previamente**: Renomeie arquivos antes de unir para melhor controle
- **💾 Use o histórico**: Aproveite o banco de dados para não perder trabalhos anteriores
- **📱 Acesse mobile**: A interface funciona perfeitamente no celular
- **🔍 Confira antes**: Visualize a lista de arquivos antes de processar

---

## 📞 Suporte

**Para problemas técnicos**: Consulte o README.md  
**Para uso básico**: Este guia tem tudo que você precisa!

**Versão do Guia**: 2.0 (Outubro 2025)  
**💡 Última dica**: A aplicação salva tudo automaticamente - você nunca perde seu trabalho!