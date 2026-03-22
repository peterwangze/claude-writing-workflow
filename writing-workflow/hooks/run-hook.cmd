@echo off
REM Writing Workflow Plugin Hook Runner
REM Usage: run-hook.cmd <hook-name>

REM First try to run the bash script via Git Bash or WSL if available
set SCRIPT_PATH=%~dp0%~1

REM For session-start: output the message directly (Windows native fallback)
if "%~1"=="session-start" (
    echo ==========================================
    echo Writing Workflow Plugin loaded.
    echo Use 'writing-workflow' skill to start.
    echo ==========================================
    exit /b 0
)

REM For other hooks: try to call the script if it exists
if exist "%SCRIPT_PATH%" (
    call "%SCRIPT_PATH%"
)
