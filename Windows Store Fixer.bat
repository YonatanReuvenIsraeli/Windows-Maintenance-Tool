@echo off
title Windows Store Fixer
echo Program Name: Windows Store Fixer
echo Version: 1.0.0
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
echo Press any key to fix the Windows store.
pause > nul 2>&1
echo.
echo Fixing the Windows Store.
wsreset
exit
