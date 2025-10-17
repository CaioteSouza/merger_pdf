# 📄 PDF Merger - Guia de Uso Rápido

## 🚀 Como Iniciar

### Método Simples (Recomendado)
1. Execute o arquivo `start.bat`
2. Aguarde a instalação das dependências (apenas na primeira vez)
3. A aplicação abrirá automaticamente no navegador em `http://localhost:5000`

### Método Manual
```bash
pip install -r requirements.txt
python app.py
```

## 📱 Como Usar a Aplicação

### 1. 📄 Unir PDFs
1. Acesse a página principal
2. **Arraste e solte** os arquivos PDF ou clique em "Selecionar Arquivos"
3. Selecione 2 ou mais arquivos PDF
4. Visualize a lista de arquivos selecionados
5. Clique em "Unir PDFs" (botão verde claro)
6. O arquivo será processado e você será redirecionado ao histórico

### 2. 📊 Visualizar Histórico
1. Clique em "Histórico" no menu superior
2. Veja todos os PDFs unidos anteriormente com detalhes:
   - Nome do arquivo final
   - Arquivos originais utilizados
   - Número de páginas
   - Tamanho do arquivo
   - Data de criação
3. **Download**: Clique no botão verde para baixar
4. **Excluir**: Clique no botão vermelho para remover (com confirmação)

### 3. 📈 Estatísticas em Tempo Real
Na página inicial e no histórico, veja:
- **Total de PDFs unidos** no sistema
- **Número total de páginas** processadas
- **Tamanho total** dos arquivos
- **Média de páginas** por PDF

### 4. 🧭 Navegação
- **Logo centralizado** no topo para identidade visual
- **Menu superior** com links para "Início" e "Histórico"
- **Design responsivo** que funciona em celular, tablet e desktop

## ✅ Funcionalidades Principais

- ✅ **Interface Drag & Drop**: Arraste arquivos diretamente para a área de upload
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