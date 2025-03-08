@echo off
setlocal enabledelayedexpansion

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
if "%input%"=="12" set "packageName=com.android.chrome"echo %packageName% > .\proc\in.txt
echo Apk will be renamed to %packageName%
echo %packageName% > .\proc\in.txt
if not defined packageName (
    echo Invalid selection. Please run the script again and choose a number between 1 and 12.
    pause
    exit /b
)

echo Decompiling APK...
java -jar .\bin\apktool.jar d .\in\*.apk -o .\temp -f
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

echo Recompiling APK...
java -jar .\bin\apktool.jar b .\temp -o .\out\unsigned.apk
if %ERRORLEVEL% neq 0 (
    echo ERROR: Failed to recompile APK.
    pause
    exit /b
)

echo Aligning APK...
".\bin\zipalign.exe" -p -f -v 4 ".\out\unsigned.apk" ".\out\aligned.apk"
if %ERRORLEVEL% neq 0 (
    echo ERROR: Failed to align APK.
    pause
    exit /b
)


echo Signing APK...
java -jar .\bin\apksigner.jar sign --key .\keys\testkey.pk8 --cert .\keys\testkey.x509.pem --out .\out\out.apk .\out\unsigned.apk

del ".\out\aligned.apk"
del ".\out\unsigned.apk"
del ".\out\out.apk.idsig"



echo APK recompiled, aligned, and signed successfully.
pause
explorer ".\out"