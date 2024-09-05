@echo off
setlocal
title Windows Maintenance Tool
echo Program Name: Windows Maintenance Tool
echo Version: 3.0.3
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
echo Getting WinSxS folder details.
Dism /Online /Cleanup-Image /AnalyzeComponentStore
if not "%errorlevel%"=="0" goto "Error"
goto "Clean"

:"Clean"
echo.
set Clean=
set /p Clean="Do you want to  clean WinSxS folder? (Yes/No) "
if /i "%Clean%"=="Yes" goto "Type"
if /i "%Clean%"=="No" goto "Start"
echo Invalid syntax!
goto "Clean"

:"Type"
echo.
echo [1] Component
echo [2] Service Pack
set Type=
set /p Type="Which do you have? (1/2) "
if /i "%Type%"=="1" goto "Component"
if /i "%Type%"=="2" goto "ServicePack"
echo Invalid syntax!
goto "Type"

:"Component"
echo.
set Base=
set /p Base="Would you like to reset base? (Yes/No) "
if /i "%Base%"=="Yes" goto "Component1"
if /i "%Base%"=="No" goto "Component2"
echo Invalid syntax!
goto "Component"

:"Component1"
echo.
echo Cleaning WinSxs folder.
Dism /Online /Cleanup-Image /startcomponentcleanup /ResetBase
if not "%errorlevel%"=="0" goto "Error"
echo WinSxS folder cleaned.
goto "Start"

:"Component2"
echo.
echo Cleaning WinSxs folder.
Dism /Online /Cleanup-Image /startcomponentcleanup
if not "%errorlevel%"=="0" goto "Error"
echo WinSxS folder cleaned.
goto "Start"

:"ServicePack"
echo.
echo Cleaning WinSxs folder.
Dism /Online /Cleanup-Image /SPSuperseded
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
