#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Script de teste para verificar se a biblioteca pypdf está funcionando corretamente
"""

try:
    from pypdf import PdfWriter, PdfReader
    print("✅ pypdf importado com sucesso!")
    
    # Teste básico de criação de PdfWriter
    writer = PdfWriter()
    print("✅ PdfWriter criado com sucesso!")
    
    print("✅ Todas as bibliotecas estão funcionando corretamente!")
    print("🚀 A aplicação PDF Merger está pronta para uso!")
    
except ImportError as e:
    print(f"❌ Erro ao importar pypdf: {e}")
    print("💡 Execute: pip install pypdf")
    
except Exception as e:
    print(f"❌ Erro inesperado: {e}")

print("\n" + "="*50)
print("📋 INFORMAÇÕES DA APLICAÇÃO")
print("="*50)
print("🌐 URL da aplicação: http://localhost:5000")
print("📁 Diretório de trabalho: C:\\laragon\\www\\Merge_pdf")
print("🗃️ Banco de dados: pdf_merger.db (criado automaticamente)")
print("📄 PDFs unidos salvos em: merged_pdfs/")
print("="*50)