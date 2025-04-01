@echo off
setlocal enabledelayedexpansion

cd /d %~dp0

echo Please choose one item:
echo ------------------------------------------------
echo ------------------------------------------------
echo 1: Spotify - com.spotify.music
echo 2: Spotify Kids - com.spotify.kids
echo 3: Pandora - com.pandora.android
echo 4: Tidal - com.aspiro.tidal
echo 5: Deezer - deezer.android.app
echo 6: Amazon Music - com.amazon.mp3
echo 7: Apple Music - com.apple.android.music
echo 8: Audible - com.audible.application
echo 9: Kindle - com.amazon.kindle
echo 10: Moon+ Reader Pro - com.flyersoft.moonreaderp
echo 11: Facebook - com.facebook.katana
echo 12: Chrome (Web Browser) - com.android.chrome
echo ------------------------------------------------
echo ------------------------------------------------

set /p input=Please type in the desired number: 

if "%input%"=="1" set "packageName=com.spotify.music"
if "%input%"=="2" set "packageName=com.spotify.kids"
if "%input%"=="3" set "packageName=com.pandora.android"
if "%input%"=="4" set "packageName=com.aspiro.tidal"
if "%input%"=="5" set "packageName=deezer.android.app"
if "%input%"=="6" set "packageName=com.amazon.mp3"
if "%input%"=="7" set "packageName=com.apple.android.music"
if "%input%"=="8" set "packageName=com.audible.application"
if "%input%"=="9" set "packageName=com.amazon.kindle"
if "%input%"=="10" set "packageName=com.flyersoft.moonreaderp"
if "%input%"=="11" set "packageName=com.facebook.katana"
if "%input%"=="12" set "packageName=com.android.chrome"

if not defined packageName (
    echo Invalid selection. Please run the script again and choose a number between 1 and 12.
    pause
    exit /b
)

echo %packageName% > .\proc\in.txt
echo Apk will be renamed to %packageName%

echo Checking dependencies...
if not exist .\bin\apktool.jar (
    echo ERROR: apktool.jar not found in .\bin\
    pause
    exit /b
)
if not exist .\in\*.apk (
    echo ERROR: No APK file found in .\in\
    pause
    exit /b
)

echo Decompiling APK...
for %%f in (.\in\*.apk) do (
    java -jar .\bin\apktool.jar d "%%f" -o .\temp -f
)
if %ERRORLEVEL% neq 0 (
    echo ERROR: Failed to decompile APK.
    pause
    exit /b
)

echo Updating package name...
powershell -NoProfile -ExecutionPolicy Bypass -File ".\proc\update.ps1"
if %ERRORLEVEL% neq 0 (
    echo ERROR: Failed to update package name.
    pause
    exit /b
)
