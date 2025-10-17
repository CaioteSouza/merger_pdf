@echo off
title PDF Merger - Ferramenta de Uniao de PDFs
echo.
echo ================================================
echo           PDF MERGER - INICIANDO
echo ================================================
echo.

echo [1/3] Verificando dependencias do Python...
pip install -r requirements.txt >nul 2>&1

if %errorlevel% neq 0 (
    echo ERRO: Falha ao instalar dependencias!
    echo Certifique-se de que o Python esta instalado.
    pause
    exit /b 1
)

echo [2/3] Dependencias instaladas com sucesso!
echo [3/3] Iniciando aplicacao PDF Merger...
echo.
echo ================================================
echo  Aplicacao iniciada com sucesso!
echo  Acesse: http://localhost:5000
echo  Pressione Ctrl+C para parar a aplicacao
echo ================================================
echo.

python app.py