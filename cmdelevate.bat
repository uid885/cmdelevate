@echo off
:: Check if the script is already running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Already running with administrative privileges.
    pause
    exit
)

:: Get the path of the current script
set "scriptPath=%~dp0"

:: Create a temporary VBScript file to perform the elevation
echo Set UAC = CreateObject("Shell.Application") > "%temp%\runas.vbs"
echo UAC.ShellExecute "cmd.exe", "/k cd ""%scriptPath%""", "", "runas", 1 >> "%temp%\runas.vbs"

:: Run the temporary VBScript file to elevate the command prompt
cscript //nologo "%temp%\runas.vbs"

:: Clean up the temporary VBScript file
del "%temp%\runas.vbs"
