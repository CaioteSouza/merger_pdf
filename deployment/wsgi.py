#!/usr/bin/env python3
"""
WSGI Entry Point para PDF Merger
Usado pelo Gunicorn para servir a aplicação
"""

import sys
import os

# Adicionar o diretório pai (onde está app.py) ao path
current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)
sys.path.insert(0, parent_dir)

from app import app

# Configurações específicas para WSGI
application = app

if __name__ == "__main__":
    application.run()