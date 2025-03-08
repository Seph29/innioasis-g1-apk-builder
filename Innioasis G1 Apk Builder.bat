@echo off
setlocal EnableDelayedExpansion

echo Please move APK file to "in" folder:
pause

set "LEFT_PATH=%USERPROFILE%\Downloads"
set "RIGHT_PATH=.\Data\in"

start explorer "%LEFT_PATH%"
start explorer "%RIGHT_PATH%"

timeout /t 3 /nobreak >nul

powershell -Command ^
    "Add-Type -AssemblyName System.Windows.Forms; " ^
    "$shell = New-Object -ComObject Shell.Application; " ^
    "$windows = $shell.Windows(); " ^
    "$count = $windows.Count; " ^
    "$leftSet = $false; " ^
    "$rightSet = $false; " ^
    "for ($i = 0; $i -lt $count; $i++) { " ^
    "    $win = $windows.Item($i); " ^
    "    $name = $win.LocationName; " ^
    "    if ($name -eq 'Downloads' -and -not $leftSet) { " ^
    "        $win.Left = 0; " ^
    "        $win.Top = 0; " ^
    "        $win.Width = [math]::Round([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width / 2); " ^
    "        $win.Height = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height; " ^
    "        $leftSet = $true; " ^
    "    } elseif ($name -eq 'in' -and -not $rightSet) { " ^
    "        $win.Left = [math]::Round([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width / 2); " ^
    "        $win.Top = 0; " ^
    "        $win.Width = [math]::Round([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width / 2); " ^
    "        $win.Height = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height; " ^
    "        $rightSet = $true; " ^
    "    } " ^
    "}" >nul 2>&1

cls
echo Please continue once file is moved:
pause
powershell -Command "(New-Object -com shell.application).Windows() | Where-Object {$_.Name -eq 'File Explorer'} | ForEach-Object {$_.Quit()}"
cls
cd /d "./Data" && call start.bat