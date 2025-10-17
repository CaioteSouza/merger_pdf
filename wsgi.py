#!/usr/bin/env python3
"""
WSGI Entry Point para PDF Merger
Usado pelo Gunicorn para servir a aplicação
"""

import sys
import os

# Adicionar o diretório da aplicação ao path
sys.path.insert(0, os.path.dirname(__file__))

from app import app

# Configurações específicas para WSGI
application = app

if __name__ == "__main__":
    application.run()