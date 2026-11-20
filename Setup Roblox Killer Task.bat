@echo off
:: Double-click this file. It must be in the same folder as "Roblox Killer.ps1".
:: Re-launch as administrator if needed
net session >nul 2>&1 || (powershell -Command "Start-Process '%~f0' -Verb RunAs" & exit /b)

set "SCRIPT=%~dp0Roblox Killer.ps1"
if not exist "%SCRIPT%" (
  echo Could not find "%SCRIPT%"
  echo Put this file in the same folder as Roblox Killer.ps1 and try again.
  pause & exit /b 1
)

schtasks /Create /F /TN "Roblox Killer" /SC ONSTART /RU SYSTEM /RL HIGHEST ^
 /TR "powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%SCRIPT%\""

if %errorlevel%==0 (
  echo.
  echo Done! Starting it now in the background (no window will appear)...
  schtasks /Run /TN "Roblox Killer"
) else (
  echo Something went wrong creating the task.
)
pause
