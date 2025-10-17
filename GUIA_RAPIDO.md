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

### 1. Unir PDFs
1. Acesse a página principal
2. **Arraste e solte** os arquivos PDF ou clique em "Selecionar Arquivos"
3. Selecione 2 ou mais arquivos PDF
4. Clique em "Unir PDFs"
5. O arquivo será processado e salvo automaticamente

### 2. Visualizar Histórico
1. Clique em "Histórico" no menu
2. Veja todos os PDFs unidos anteriormente
3. **Download**: Clique no botão verde para baixar
4. **Excluir**: Clique no botão vermelho para remover

### 3. Estatísticas
- Na página inicial, veja estatísticas em tempo real
- Total de PDFs unidos
- Número total de páginas
- Tamanho total dos arquivos

## ✅ Funcionalidades

- ✅ **Interface Drag & Drop**: Arraste arquivos diretamente
- ✅ **Múltiplos PDFs**: Une 2 ou mais arquivos
- ✅ **Qualquer tamanho**: PDFs com qualquer número de páginas
- ✅ **Histórico completo**: Todos os arquivos são salvos
- ✅ **Design responsivo**: Funciona em qualquer dispositivo
- ✅ **Banco de dados**: SQLite para persistência
- ✅ **Logo personalizado**: Sua marca na aplicação

## 🔧 Estrutura de Arquivos

```
Merge_pdf/
├── start.bat          # Inicia a aplicação
├── app.py             # Aplicação principal
├── requirements.txt   # Dependências Python
├── README.md          # Documentação completa
├── static/logo.png    # Logo da aplicação
├── templates/         # Interface web
└── merged_pdfs/       # PDFs unidos (criado automaticamente)
```

## 📋 Requisitos

- Python 3.7+
- Navegador web moderno
- Pelo menos 100MB de espaço livre

## 🆘 Solução de Problemas

### Erro ao iniciar
- Certifique-se que o Python está instalado
- Execute: `pip install -r requirements.txt`

### Erro ao unir PDFs
- Verifique se os arquivos são PDFs válidos
- Certifique-se que os arquivos não estão corrompidos

### Porta ocupada
- Se a porta 5000 estiver ocupada, feche outros programas ou reinicie o computador

## 🎯 Exemplo de Uso

1. **Cenário**: Unir contratos, relatórios, documentos
2. **Processo**: 
   - Selecione todos os PDFs necessários
   - Eles serão unidos na ordem selecionada
   - Baixe o arquivo final do histórico
3. **Resultado**: Um único PDF com todos os documentos

---

**💡 Dica**: Mantenha a aplicação sempre rodando para acesso rápido quando precisar unir PDFs!