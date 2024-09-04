@echo off
setlocal
title Windows Maintenance Tool
echo Program Name: Windows Maintenance Tool
echo Version: 2.0.0
echo Developer: @YonatanReuvenIsraeli
echo Website: https://www.yonatanreuvenisraeli.dev
echo License: GNU General Public License v3.0
net user > nul 2>&1
if not "%errorlevel%"=="0" goto "InWindowsRecoveryEnvironment"
goto "Start"

:"InWindowsRecoveryEnvironment"
echo.
echo Please run this batch file from within Windows. Press any key to close this batch file.
pause > nul 2>&1
goto "Close"

:"Start"
echo.
echo [1] Clear Windows Store cache.
echo [2] Reset OpenSSH client keys for user %USERNAME%.
echo [3] Close
set Start=
set /p Start="What do you want to do? (1-3) "
if "%Start%"=="1" goto "1"
if "%Start%"=="2" goto "2"
if "%Start%"=="3" goto "Close"
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
echo Reseting OpenSSH client keys.
rd "%USERPROFILE%\.ssh" /s /q > nul 2>&1
if not "%errorlevel%"=="0" goto "Error"
echo OpenSSH client keys reset.
goto "Start"

:"Error"
echo There has been an error! You can try again.
goto "Start"

:"Close"
endlocal
exit
