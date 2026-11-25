@echo off
setlocal
cd /d "%~dp0"

set "PY=python.exe"
if exist "%~dp0.venv\Scripts\python.exe" set "PY=%~dp0.venv\Scripts\python.exe"
if exist ".venv\Scripts\python.exe" set "PY=.venv\Scripts\python.exe"

echo ===================================================
echo   RUNNING: BC, VLR, and HLR Subscriber Dump
echo ===================================================
echo.

"%PY%" scripts\dump_bc_vlr_hlr.py --days 90
if errorlevel 1 (
    echo.
    echo ===================================================
    echo [ERROR] Subscriber Dump failed.
    echo Check logs\dump_bc_vlr_hlr.log for details.
    echo ===================================================
    pause
    exit /b 1
)

echo.
echo ===================================================
echo Subscriber Dump completed successfully!
echo Saved to: output\BC_VLR_HLR_Dump.xlsx
echo ===================================================
pause
