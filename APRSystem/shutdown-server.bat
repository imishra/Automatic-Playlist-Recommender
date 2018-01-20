@ECHO OFF
REM ###################################################################
REM
REM This files deployes the webservice
REM 
REM ###################################################################
echo.
echo Shutting down the flask web server ...
taskkill /IM python.exe /F > nul
echo.
echo Flask web server has been shutdown
echo.
echo Press any key to exit...
pause > nul