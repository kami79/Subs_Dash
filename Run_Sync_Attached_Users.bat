@echo off
setlocal
cd /d "%~dp0"

set "PY=python.exe"
if exist "%~dp0.venv\Scripts\python.exe" set "PY=%~dp0.venv\Scripts\python.exe"
if exist ".venv\Scripts\python.exe" set "PY=.venv\Scripts\python.exe"

echo ===================================================
echo   RUNNING: Huawei Attached Users Sync
echo ===================================================
echo.

"%PY%" scripts\sync_attached_users.py
if errorlevel 1 (
    echo.
    echo ===================================================
    echo [ERROR] Attached Users Sync failed.
    echo Check logs\sync_attached_users.log for details.
    echo ===================================================
    pause
    exit /b 1
)

echo.
echo ===================================================
echo Attached Users Sync completed successfully!
echo Updated: output\Network Data Attach Users.xlsx
echo ===================================================
pause
