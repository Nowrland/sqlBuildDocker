@echo off
setlocal

set SSL_DIR=%~dp0ssl

if not exist "%SSL_DIR%" mkdir "%SSL_DIR%"

:: Tenta encontrar o openssl: primeiro no PATH, depois no Git for Windows
set OPENSSL=openssl
where openssl >nul 2>&1
if %ERRORLEVEL% neq 0 (
    if exist "C:\Program Files\Git\usr\bin\openssl.exe" (
        set OPENSSL=C:\Program Files\Git\usr\bin\openssl.exe
        echo OpenSSL encontrado via Git for Windows.
    ) else (
        echo ERRO: OpenSSL nao encontrado no PATH nem no Git for Windows.
        echo Instale com: winget install ShiningLight.OpenSSL
        pause
        exit /b 1
    )
)

echo Gerando certificados SSL em: %SSL_DIR%
echo.

"%OPENSSL%" req -new -x509 -days 3650 -nodes ^
    -out "%SSL_DIR%\server.crt" ^
    -keyout "%SSL_DIR%\server.key" ^
    -subj "/CN=postgres-local/O=Dev/C=BR"

if %ERRORLEVEL% neq 0 (
    echo.
    echo ERRO: OpenSSL falhou.
    pause
    exit /b 1
)

echo.
echo Certificados gerados com sucesso!
echo   %SSL_DIR%\server.crt
echo   %SSL_DIR%\server.key
echo.
echo Proximo passo: docker compose down ^&^& docker compose up -d
pause
