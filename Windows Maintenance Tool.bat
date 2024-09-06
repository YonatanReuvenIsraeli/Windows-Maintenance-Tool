@echo off
setlocal
title Windows Maintenance Tool
echo Program Name: Windows Maintenance Tool
echo Version: 4.1.2
echo Developer: @YonatanReuvenIsraeli
echo Website: https://www.yonatanreuvenisraeli.dev
echo License: GNU General Public License v3.0
net session > nul 2>&1
if not "%errorlevel%"=="0" goto "NotAdministrator"
net user > nul 2>&1
if not "%errorlevel%"=="0" goto "InWindowsRecoveryEnvironment"
goto "Start"

:"NotAdministrator"
echo.
echo Please run this batch file as an administrator. Press any key to close this batch file.
pause > nul 2>&1
goto "Close"

:"InWindowsRecoveryEnvironment"
echo.
echo Please run this batch file from within Windows. Press any key to close this batch file.
pause > nul 2>&1
goto "Close"

:"Start"
echo.
echo [1] Clear Windows Store cache.
echo [2] Clean WinSxS folder.
echo [3] Reset OpenSSH client keys for user %USERNAME%.
echo [4] Close
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
wsreset
if not "%errorlevel%"=="0" goto "Error"
echo Windows Store cache cleared.
goto "Start"

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
set /p SureInstallation="Are you sure "%Installation%" is the drive letter of your offline Winddows installation? (Yes/No) "
if /i "%SureInstallation%"=="Yes" goto "CheckExistInstallation"
if /i "%SureInstallation%"=="No" goto "Installation"
echo Invalid syntax!
goto "SureInstallation"

:"CheckExistInstallation"
if not exist "%Installation%" goto "NotExistInstallation"
goto "Offline"

:"NotExistInstallation"
echo "%Installation%" does not exist! Please try again.
goto "Installation"

:"Online"
echo.
echo Getting WinSxS folder details.
Dism /Online /Cleanup-Image /AnalyzeComponentStore
if not "%errorlevel%"=="0" goto "Error"
goto "CleanOnline"

:"CleanOnline"
echo.
set Clean=
set /p Clean="Do you want to  clean WinSxS folder? (Yes/No) "
if /i "%Clean%"=="Yes" goto "Type"
if /i "%Clean%"=="No" goto "Start"
echo Invalid syntax!
goto "CleanOnline"

:"TypeOnline"
echo.
echo [1] Component
echo [2] Service Pack
set Type=
set /p Type="Which do you have? (1/2) "
if /i "%Type%"=="1" goto "ComponentOnline"
if /i "%Type%"=="2" goto "ServicePackOnline"
echo Invalid syntax!
goto "TypeOnline"

:"ComponentOnline"
echo.
set Base=
set /p Base="Would you like to reset base? (Yes/No) "
if /i "%Base%"=="Yes" goto "Component1Online"
if /i "%Base%"=="No" goto "Component2Online"
echo Invalid syntax!
goto "ComponentOnline"

:"Component1Online"
echo.
echo Cleaning WinSxs folder.
Dism /Online /Cleanup-Image /startcomponentcleanup /ResetBase
if not "%errorlevel%"=="0" goto "Error"
echo WinSxS folder cleaned.
goto "Start"

:"Component2Online"
echo.
echo Cleaning WinSxs folder.
Dism /Online /Cleanup-Image /startcomponentcleanup
if not "%errorlevel%"=="0" goto "Error"
echo WinSxS folder cleaned.
goto "Start"

:"ServicePackOnline"
echo.
echo Cleaning WinSxs folder.
Dism /Online /Cleanup-Image /SPSuperseded
if not "%errorlevel%"=="0" goto "Error"
echo WinSxS folder cleaned.
goto "Start"

:"Offline"
echo.
echo Getting WinSxS folder details.
Dism /Image:"%Installation%" /Cleanup-Image /AnalyzeComponentStore
if not "%errorlevel%"=="0" goto "Error"
goto "CleanOffline"

:"CleanOffline"
echo.
set Clean=
set /p Clean="Do you want to  clean WinSxS folder? (Yes/No) "
if /i "%Clean%"=="Yes" goto "Type"
if /i "%Clean%"=="No" goto "Start"
echo Invalid syntax!
goto "CleanOffline"

:"TypeOffline"
echo.
echo [1] Component
echo [2] Service Pack
set Type=
set /p Type="Which do you have? (1/2) "
if /i "%Type%"=="1" goto "ComponentOffline"
if /i "%Type%"=="2" goto "ServicePackOffline"
echo Invalid syntax!
goto "TypeOffline"

:"ComponentOffline"
echo.
set Base=
set /p Base="Would you like to reset base? (Yes/No) "
if /i "%Base%"=="Yes" goto "Component1Offline"
if /i "%Base%"=="No" goto "Component2Offline"
echo Invalid syntax!
goto "ComponentOffline"

:"Component1Offline"
echo.
echo Cleaning WinSxs folder.
Dism /Image:"%OfflineInstallation%" /Cleanup-Image /startcomponentcleanup /ResetBase
if not "%errorlevel%"=="0" goto "Error"
echo WinSxS folder cleaned.
goto "Start"

:"Component2Offline"
echo.
echo Cleaning WinSxs folder.
Dism /Image:"%OfflineInstallation%" /Cleanup-Image /startcomponentcleanup
if not "%errorlevel%"=="0" goto "Error"
echo WinSxS folder cleaned.
goto "Start"

:"ServicePackOffline"
echo.
echo Cleaning WinSxs folder.
Dism /Image:"%OfflineInstallation%" /Cleanup-Image /SPSuperseded
if not "%errorlevel%"=="0" goto "Error"
echo WinSxS folder cleaned.
goto "Start"

:"3"
if not exist "%USERPROFILE%\.ssh" goto "NotExist"
echo.
echo Reseting OpenSSH client keys for user %USERPROFILE%.
rd "%USERPROFILE%\.ssh" /s /q > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
echo OpenSSH client keys reset for user %USERPROFILE%.
goto "Start"

:"NotExist"
echo.
echo OpenSSH client keys for user %USERNAME% already in reset state.
goto "Start"

:"Error"
echo There has been an error! You can try again.
goto "Start"

:"Close"
endlocal
exit
