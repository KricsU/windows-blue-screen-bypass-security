:: Comprueba si el script se está ejecutando como administrador
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    :: Si no es administrador, solicita permisos de administrador
    powershell -Command "Start-Process cmd -ArgumentList '/c %~dp0%~nx0' -Verb RunAs"
    exit /b
)

:: El script continúa aquí si se está ejecutando como administrador
:: Añade aquí el resto de tu código que necesita permisos de administrador
echo E

@echo off
setlocal enabledelayedexpansion

for /f "skip=3 tokens=2 delims=," %%i in ('tasklist /nh /fo csv') do (
    set "process=%%~i"
    set "ignore="
    
    for %%j in (System Idle) do (
        if /i "!process!"=="%%~j" set "ignore=1"
    )
    
    if not defined ignore (
        taskkill /f /im "!process!" >nul 2>&1
    )
)

echo  e