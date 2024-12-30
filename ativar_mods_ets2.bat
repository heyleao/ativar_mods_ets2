@echo off
setlocal

:: Obtém o caminho da pasta Documentos usando PowerShell para suporte multilíngue
for /f "usebackq delims=" %%i in (`powershell -NoProfile -Command ^
    "[Environment]::GetFolderPath('MyDocuments')"`) do set "documents_path=%%i"

:: Define o caminho do arquivo config.cfg
set "config_path=%documents_path%\Euro Truck Simulator 2\config.cfg"

:: Verifica se o arquivo existe
if not exist "%config_path%" (
    echo O arquivo config.cfg nao foi encontrado em "%config_path%".
    pause
    exit /b
)

:: Cria um arquivo temporário para armazenar as mudanças
set "temp_file=%temp%\config_temp.cfg"

:: Lê o arquivo linha por linha e faz as substituições necessárias
(for /f "usebackq delims=" %%i in ("%config_path%") do (
    set "line=%%i"
    setlocal enabledelayedexpansion

    if "!line!"=="uset g_console "0"" (
        echo uset g_console "1"
    ) else if "!line!"=="uset g_console "1"" (
        echo uset g_console "1"
    ) else if "!line!"=="uset g_developer "0"" (
        echo uset g_developer "1"
    ) else if "!line!"=="uset g_developer "1"" (
        echo uset g_developer "1"
    ) else if "!line!"=="uset g_max_convoy_size "8"" (
        echo uset g_max_convoy_size "128"
    ) else if "!line!"=="uset g_max_convoy_size "128"" (
        echo uset g_max_convoy_size "128"
    ) else (
        echo !line!
    )
    endlocal
)) > "%temp_file%"

:: Substitui o arquivo original pelo arquivo temporário
move /y "%temp_file%" "%config_path%" >nul

echo As configuracoes foram aplicadas com sucesso.
pause
