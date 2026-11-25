@echo off
setlocal
cd /d "%~dp0"

set "PY=python.exe"
if exist "%~dp0.venv\Scripts\python.exe" set "PY=%~dp0.venv\Scripts\python.exe"
if exist ".venv\Scripts\python.exe" set "PY=.venv\Scripts\python.exe"

set "NET_IP="
for /f "usebackq tokens=*" %%a in (`powershell -NoProfile -Command "(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notlike '*Loopback*' -and $_.IPAddress -notlike '169.254*' } | Select-Object -First 1).IPAddress" 2^>nul`) do set "NET_IP=%%a"

echo =======================================================================
echo     KOREK TELECOM - CORE NETWORK PERFORMANCE DASHBOARD PORTAL
echo =======================================================================
echo.
echo Starting FastAPI and Telemetry Server on http://0.0.0.0:8080 ...
echo.
echo   [Local Access]     http://localhost:8080
if defined NET_IP (
    echo   [Company Network]  http://%NET_IP%:8080
)
echo   [Hostname Access]  http://%COMPUTERNAME%:8080
echo.
echo * Tip: Share the Company Network or Hostname URL above with other employees.
echo   If colleagues cannot connect, right-click and run:
echo   Open_Firewall_Port_8080.bat (Run as administrator)
echo.
echo =======================================================================
echo.

rem Launch browser automatically after 2 seconds in the background
start "" /b cmd /c "timeout /t 2 /nobreak >nul & start http://localhost:8080"

rem Run Uvicorn server with auto-reload binding on all interfaces (0.0.0.0)
"%PY%" -m uvicorn dashboard.backend.app.main:app --host 0.0.0.0 --port 8080 --reload

if errorlevel 1 (
    echo.
    echo =======================================================================
    echo [ERROR] Dashboard server terminated unexpectedly.
    echo =======================================================================
    pause
    exit /b 1
)

pause
