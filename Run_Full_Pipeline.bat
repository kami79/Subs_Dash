@echo off
setlocal
cd /d "%~dp0"

set "PY=python.exe"
if exist "%~dp0.venv\Scripts\python.exe" set "PY=%~dp0.venv\Scripts\python.exe"
if exist ".venv\Scripts\python.exe" set "PY=.venv\Scripts\python.exe"

echo ===================================================
echo   RUNNING: Full Sync and Dump Pipeline
echo ===================================================
echo.

"%PY%" scripts\run_all.py %*
if errorlevel 1 (
    echo.
    echo ===================================================
    echo [ERROR] Pipeline encountered an issue.
    echo Check logs\full_pipeline.log for details.
    echo ===================================================
    pause
    exit /b 1
)

echo.
echo ===================================================
echo All tasks finished successfully!
echo ===================================================
pause
