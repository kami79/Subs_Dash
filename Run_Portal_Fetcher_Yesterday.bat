@echo off
setlocal
cd /d "%~dp0"

set "PY=python.exe"
if exist "%~dp0.venv\Scripts\python.exe" set "PY=%~dp0.venv\Scripts\python.exe"
if exist ".venv\Scripts\python.exe" set "PY=.venv\Scripts\python.exe"

echo ===================================================================
echo   RUNNING: Huawei Portal Fetcher (Yesterday Preset) & Table Append
echo ===================================================================
echo.
echo 1. Downloads Yesterday reports from Huawei Portal (fast 1-day query).
echo 2. Automatically appends yesterday's details to the end of tables.
echo.

"%PY%" scripts\portal_fetcher.py %*
if errorlevel 1 (
    echo.
    echo ===================================================================
    echo [ERROR] Portal Fetcher failed.
    echo Check logs\portal_fetcher.log for details.
    echo ===================================================================
    pause
    exit /b 1
)

echo.
echo ===================================================================
echo Portal fetch and table update completed successfully!
echo Target files updated:
echo   - output\Network Data Attach Users.xlsx (and Desktop)
echo   - output\BC_VLR_HLR_Dump.xlsx (and Desktop)
echo ===================================================================
pause
