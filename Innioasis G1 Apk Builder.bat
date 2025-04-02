@echo off
setlocal EnableDelayedExpansion

:: Clean previous APKs
del ".\Data\in\*.apk" 2>nul

:: File selection dialog with secure file paths
set "psCommand=Add-Type -AssemblyName System.Windows.Forms; $dialog=New-Object System.Windows.Forms.OpenFileDialog; "
set "psCommand=!psCommand! $dialog.Filter='APK Files (*.apk)|*.apk'; "
set "psCommand=!psCommand! if($dialog.ShowDialog() -eq 'OK') { "
set "psCommand=!psCommand! $source=$dialog.FileName; $dest='Data\in\' + [System.IO.Path]::GetFileName($source); "
set "psCommand=!psCommand! [System.IO.File]::Copy($source, $dest, $true) "
set "psCommand=!psCommand! } else { exit 1 }"

powershell -Command "!psCommand!"
if errorlevel 1 (
    echo Operation cancelled
    timeout /t 2 /nobreak >nul
    exit /b
)

:: Additional validation: verify that the file was successfully copied
for %%F in (".\Data\in\*.apk") do (
    set "apkFile=%%~nxF"
)
if not defined apkFile (
    echo Error: APK file could not be copied.
    timeout /t 2 /nobreak >nul
    exit /b
)

:: Success confirmation
cls
echo APK file (!apkFile!) successfully copied to .\Data\in\
timeout /t 2 /nobreak >nul

:: Continue processing
cd /d "./Data" && call start.bat
