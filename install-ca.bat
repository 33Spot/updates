@echo off
setlocal

REM must run as administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo   This must be run as Administrator.
    echo   Right-click this file and choose "Run as administrator".
    echo.
    pause
    exit /b 1
)

set "CAFILE=%~dp0myCA.pem"

if not exist "%CAFILE%" (
    echo Could not find myCA.pem next to this batch file.
    pause
    exit /b 1
)

echo Installing CA certificate into Windows Trusted Root store...
certutil -addstore -f "Root" "%CAFILE%"

if %errorlevel% equ 0 (
    echo.
    echo   Done! You can now open the site without warnings.
    echo   Please close and reopen Opera.
    echo.
) else (
    echo.
    echo   Something went wrong.
    echo.
)

pause
