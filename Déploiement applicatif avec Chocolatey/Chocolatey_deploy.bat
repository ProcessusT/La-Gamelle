@echo off
cls
echo *************************************
echo **** Install Chocolatey par Proc ****
echo *************************************
echo.
echo.
echo.
echo Checking Admin rights to install everything...
net session >nul 2>&1
if %errorLevel% == 0 (
	echo Success: Les privileges Administrateur sont disponibles !
) else (
	echo Vous devez executer ce script en tant que Administrateur
	pause
	exit /b 0
)
echo.
echo.
echo Installation de Chocolatey...
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
echo Chocolatey a bien ete installe
choco feature enable -n=allowGlobalConfirmation
setlocal disableDelayedExpansion
set InputFile=C:\ProgramData\chocolatey\config\chocolatey.config
set OutputFile=C:\ProgramData\chocolatey\config\chocolatey.config2
set '_strFind=<feature name="allowGlobalConfirmation" enabled="false"'
set '_strInsert=<feature name="allowGlobalConfirmation" enabled="true"'

>"%OutputFile%" (
  for /f "usebackq delims=" %%A in ("%InputFile%") do (
    if "%%A" equ "%_strFind%" (echo %_strInsert%) else (echo %%A)
  )
)


REM on attend quelques secondes...
ping 127.0.0.1 -n 6 > nul
echo.
echo Installation de Adobe reader...
choco install adobereader
echo Adobe reader a bien ete installe
echo.
echo Installation de Firefox...
choco install firefox
echo Firefox a bien ete installe
echo.
echo Installation de 7zip...
choco install 7zip.install
echo 7zip a bien ete installe
echo.
echo Installation de VLC...
choco install vlc
echo VLC a bien ete installe
echo.
echo Installation de Ccleaner...
choco install ccleaner
echo Ccleaner a bien ete installe
echo.
echo Installation de PDF creator...
choco install pdfcreator
echo PDF Creator a bien ete installe
echo.
echo Installation de Java Runtime Environment...
choco install javaruntime
echo Java a bien ete installe
echo.
echo Installation de Visual C++...
choco install vcredist2008
choco install vcredist140
choco install vcredist2013
choco install vcredist2015
choco install vcredist2017
echo Visual C++ a bien ete installe
echo.
echo Installation de .Net Framework...
choco install dotnet3.5
choco install dotnet4.5
choco install dotnet4.6.2
choco install dotnet4.7.1
echo .Net framework a bien ete installe
echo.
echo Installation de AdBlock pour Firefox et IE...
choco install adblockplus-firefox
choco install adblockplusie
echo AdBlock a bien ete installe sur Firefox et IE
echo.
echo.
echo.
echo Installation de Iperius Remote sur le bureau...
powershell -Command "& {$wc = New-Object System.Net.WebClient; $wc.DownloadFile('https://www.iperiusremote.fr/IperiusRemote.exe', '%USERPROFILE%\desktop\DEPANNAGE.exe');}"
echo Iperius a ete mis sur le bureau
echo.
echo Mise en place de www.google.fr en page accueil...
taskkill /im firefox.exe* /f
cd /D "%APPDATA%\Mozilla\Firefox\Profiles"
cd *.default
set ffile=%cd%
echo user_pref("browser.startup.homepage", "https://www.google.fr");>>"%ffile%\prefs.js"
set ffile=
cd %windir%
REG ADD "HKCU\SOFTWARE\MICROSOFT\INTERNET EXPLORER\MAIN" /V "START PAGE" /D "https://www.google.fr"; /F
REG ADD "HKCU\SOFTWARE\MICROSOFT\GOOGLE CHROME\MAIN" /V "START PAGE" /D "https://www.google.fr"; /F
REG ADD "HKCU\SOFTWARE\MICROSOFT\MOZILLA FIREFOX\MAIN" /V "START PAGE" /D "https://www.google.fr"; /F
echo www.google.fr a bien ete mis en page accueil
echo.
echo Mise a jour regedit credssp...
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v "AllowEncryptionOracle" /t REG_DWORD /d 2 /f
echo Mise a jour credssp OK
echo.
echo Mise a jour regedit VPN L2TP...
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PolicyAgent" /v "AssumeUDPEncapsulationContextOnSendRule" /t REG_DWORD /d 2 /f
echo Mise a jour regedit VPN L2TP OK
echo.
echo Desinstallation de OneDrive...
IF EXIST "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" REG Delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
IF EXIST "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" REG Delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
REG ADD "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /d "0" /t REG_DWORD /f
echo OneDrive a bien ete desinstalle
echo.
echo.
echo.
echo Installation de Bulk crap uninstaller pour suppression surcouche HP...
choco install bulk-crap-uninstaller
echo Bulk crap a bien ete installe
echo.
echo.
echo.
echo Recherche des mises a jour systeme...
wuauclt /forcedetect /detectnow
echo Fin de recherche des mises a jour
echo.
echo *******************************
echo.
echo Fin du script
pause
