@echo off
setlocal
title Windows Maintenance Tool
echo Program Name: Windows Maintenance Tool
echo Version: 4.1.21
echo License: GNU General Public License v3.0
echo Developer: @YonatanReuvenIsraeli
echo GitHub: https://github.com/YonatanReuvenIsraeli
echo Sponsor: https://github.com/sponsors/YonatanReuvenIsraeli
"%windir%\System32\net.exe" session > nul 2>&1
if not "%errorlevel%"=="0" goto "NotAdministrator"
"%windir%\System32\net.exe" user > nul 2>&1
if not "%errorlevel%"=="0" goto "InWindowsPreinstallationEnvironmentWindowsRecoveryEnvironment"
goto "Start"

:"NotAdministrator"
echo.
echo Please run this batch file as an administrator. Press any key to close this batch file.
pause > nul 2>&1
goto "Close"

:"InWindowsPreinstallationEnvironmentWindowsRecoveryEnvironment"
echo.
echo You are in Windows Preinstallation Environment or Windows Recovery Environment! You must run this batch file in Windows. Press any key to close this batch file.
pause > nul 2>&1
goto "Close"

:"Start"
echo.
echo [1] Clear Windows Store cache.
echo [2] Clean Windows Component Store.
echo [3] Reset OpenSSH client keys for user %USERNAME%.
echo [4] Close.
set Start=
set /p Start="What do you want to do? (1-4) "
if /i "%Start%"=="1" goto "1"
if /i "%Start%"=="2" goto "2"
if /i "%Start%"=="3" goto "3"
if /i "%Start%"=="4" goto "Close"
echo Invalid syntax!
goto "Start"

:"1"
echo.
echo Clearing Windows Store cache.
"%windir%\System32\WSReset.exe"
if not "%errorlevel%"=="0" goto "Error1"
echo Windows Store cache cleared.
goto "Start"

:"Error1"
echo There has been an error! Press any key to again.
pause > nul 2>&1
goto "1"

:"2"
echo.
set OnlineOffline=
set /p OnlineOffline="Are you repairing an online or offline Windows installation? (Online/Offline) "
if /i "%OnlineOffline%"=="Online" goto "Online"
if /i "%OnlineOffline%"=="Offline" goto "Installation"
echo Invalid syntax
goto "2"

:"Installation"
echo.
set Installation=
set /p Installation="What is the drive letter to your offline Windows installation? (A:-Z:) "
if /i "%Installation%"=="A:" goto "SureInstallation"
if /i "%Installation%"=="B:" goto "SureInstallation"
if /i "%Installation%"=="C:" goto "SureInstallation"
if /i "%Installation%"=="D:" goto "SureInstallation"
if /i "%Installation%"=="E:" goto "SureInstallation"
if /i "%Installation%"=="F:" goto "SureInstallation"
if /i "%Installation%"=="G:" goto "SureInstallation"
if /i "%Installation%"=="H:" goto "SureInstallation"
if /i "%Installation%"=="I:" goto "SureInstallation"
if /i "%Installation%"=="J:" goto "SureInstallation"
if /i "%Installation%"=="K:" goto "SureInstallation"
if /i "%Installation%"=="L:" goto "SureInstallation"
if /i "%Installation%"=="M:" goto "SureInstallation"
if /i "%Installation%"=="N:" goto "SureInstallation"
if /i "%Installation%"=="O:" goto "SureInstallation"
if /i "%Installation%"=="P:" goto "SureInstallation"
if /i "%Installation%"=="Q:" goto "SureInstallation"
if /i "%Installation%"=="R:" goto "SureInstallation"
if /i "%Installation%"=="S:" goto "SureInstallation"
if /i "%Installation%"=="T:" goto "SureInstallation"
if /i "%Installation%"=="U:" goto "SureInstallation"
if /i "%Installation%"=="V:" goto "SureInstallation"
if /i "%Installation%"=="W:" goto "SureInstallation"
if /i "%Installation%"=="X:" goto "SureInstallation"
if /i "%Installation%"=="Y:" goto "SureInstallation"
if /i "%Installation%"=="Z:" goto "SureInstallation"
echo Invalid syntax!
goto "Installation"

:"SureInstallation"
echo.
set SureInstallation=
set /p SureInstallation="Are you sure "%Installation%" is the drive letter of your offline Windows installation? (Yes/No) "
if /i "%SureInstallation%"=="Yes" goto "CheckExistInstallation"
if /i "%SureInstallation%"=="No" goto "Installation"
echo Invalid syntax!
goto "SureInstallation"

:"CheckExistInstallation"
if not exist "%Installation%\Windows" goto "NotExistInstallation"
goto "Offline"

:"NotExistInstallation"
echo "%Installation%" does not exist or is not an offline Windows installation! Please try again.
goto "Installation"

:"Online"
echo.
echo Getting Windows Component Store details.
"%windir%\System32\Dism.exe" /Online /Cleanup-Image /AnalyzeComponentStore
if not "%errorlevel%"=="0" goto "2"
echo Got Windows Component Store details.
goto "Clean"

:"Offline"
echo.
echo Getting Windows Component Store details on Windows installation "%Installation%".
if not exist "%Installation%\Windows\Logs\DISM" md "%Installation%\Windows\Logs\DISM" > nul 2>&1
"%windir%\System32\Dism.exe" /Image:"%Installation%" /Cleanup-Image /AnalyzeComponentStore /LogPath:"%Installation%\Windows\Logs\DISM\dism.log"
if not "%errorlevel%"=="0" goto "Installation"
echo Got Windows Component Store details on Windows installation "%Installation%".
goto "Clean"

:"Clean"
echo.
set Clean=
set /p Clean="Do you want to clean Windows Component Store? (Yes/No) "
if /i "%Clean%"=="Yes" goto "Type"
if /i "%Clean%"=="No" goto "Start"
echo Invalid syntax!
goto "Clean"

:"Type"
echo.
echo [1] Component
echo [2] Service Pack
echo.
set Type=
set /p Type="Which do you have? (1-2) "
if /i "%Type%"=="1" goto "Component"
if /i "%OnlineOffline%"=="Online" if /i "%Type%"=="2" goto "ServicePackOnline"
if /i "%OnlineOffline%"=="Offline" if /i "%Type%"=="2" goto "ServicePackOffline"
echo Invalid syntax!
goto "Type"

:"Component"
echo.
set Base=
set /p Base="Would you like to reset base? (Yes/No) "
if /i "%OnlineOffline%"=="Online" if /i "%Base%"=="Yes" goto "Component1Online"
if /i "%OnlineOffline%"=="Online" if /i "%Base%"=="No" goto "Component2Online"
if /i "%OnlineOffline%"=="Offline" if /i "%Base%"=="Yes" goto "Component1Offline"
if /i "%OnlineOffline%"=="Offline" if /i "%Base%"=="No" goto "Component2Offline"
echo Invalid syntax!
goto "Component"

:"Component1Online"
echo.
echo Cleaning Windows Component Store.
"%windir%\System32\Dism.exe" /Online /Cleanup-Image /startcomponentcleanup /ResetBase
if not "%errorlevel%"=="0" goto "2"
echo Windows Component Store cleaned.
goto "Start"

:"Component2Online"
echo.
echo Cleaning Windows Component Store.
"%windir%\System32\Dism.exe" /Online /Cleanup-Image /startcomponentcleanup
if not "%errorlevel%"=="0" goto "2"
echo Windows Component Store cleaned.
goto "Start"

:"ServicePackOnline"
echo.
echo Cleaning Windows Component Store.
"%windir%\System32\Dism.exe" /Online /Cleanup-Image /SPSuperseded
if not "%errorlevel%"=="0" goto "2"
echo Windows Component Store cleaned.
goto "Start"

:"Component1Offline"
echo.
echo Cleaning Windows Component Store on Windows installation "%Installation%".
if not exist "%Installation%\Windows\Logs\DISM" md "%Installation%\Windows\Logs\DISM" > nul 2>&1
"%windir%\System32\Dism.exe" /Image:"%Installation%" /Cleanup-Image /startcomponentcleanup /ResetBase /LogPath:"%Installation%\Windows\Logs\DISM\dism.log"
if not "%errorlevel%"=="0" goto "Installation"
echo Windows Component Store cleaned on Windows installation "%Installation%".
goto "Start"

:"Component2Offline"
echo.
echo Cleaning Windows Component Store on Windows installation "%Installation%".
if not exist "%Installation%\Windows\Logs\DISM" md "%Installation%\Windows\Logs\DISM" > nul 2>&1
"%windir%\System32\Dism.exe" /Image:"%Installation%" /Cleanup-Image /startcomponentcleanup /LogPath:"%Installation%\Windows\Logs\DISM\dism.log"
if not "%errorlevel%"=="0" goto "Installation"
echo Windows Component Store cleaned on Windows installation "%Installation%".
goto "Start"

:"ServicePackOffline"
echo.
echo Cleaning Windows Component Store on Windows installation "%Installation%".
if not exist "%Installation%\Windows\Logs\DISM" md "%Installation%\Windows\Logs\DISM" > nul 2>&1
"%windir%\System32\Dism.exe" /Image:"%Installation%" /Cleanup-Image /SPSuperseded /LogPath:"%Installation%\Windows\Logs\DISM\dism.log"
if not "%errorlevel%"=="0" goto "Installation"
echo Windows Component Store cleaned on Windows installation "%Installation%".
goto "Start"

:"3"
echo.
set Sure=
set /p Sure="Are you sure you want to reset OpenSSH client keys for user %USERNAME%? (Yes/No) "
if /i "%Sure%"=="Yes" goto "Reset"
if /i "%Sure%"=="No" goto "Start"
echo Invalid syntax!
goto "3"

:"Reset"
if not exist "%USERPROFILE%\.ssh" goto "NotExist"
echo.
echo Reseting OpenSSH client keys for user %USERPROFILE%.
rd "%USERPROFILE%\.ssh" /s /q > nul 2>&1
if not "%errorlevel%"=="0" goto "Error2"
echo OpenSSH client keys reset for user %USERPROFILE%.
goto "Start"

:"NotExist"
echo.
echo OpenSSH client keys for user %USERNAME% already in reset state.
goto "Start"

:"Error2"
echo There has been an error! Press any key to again.
pause > nul 2>&1
goto "Reset"

:"Close"
endlocal
exit
