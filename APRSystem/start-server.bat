@ECHO OFF
REM ###################################################################
REM
REM This files deployes the webservice
REM 
REM ###################################################################
echo.
echo Starting the Flask web server ...
start autorun/applauncher.vbs

REM to track the time limit to wait
set /a timer=0
set /a interval=15

REM #### To ceheck ad if the service has been started #####
:while
netstat -o -n -a | find "127.0.0.1:5000" /c > tmpFile 
set /p count= < tmpFile
del tmpFile
IF %count%==1 (
	set message="Web server has been started successfully at 127.0.0.1:5000"
	break
) ELSE (
	IF %timer% gtr 300 (
		set message="Web server couldn't start"
	) ELSE (
		echo Waiting for the web server to start, Time Elapsed %timer% seconds
		set /a timer+=15
		Timeout /T %interval% /NOBREAK > NUL
		goto :while
	)
)
echo.
echo %message%
echo Total Time taken %timer%
echo.
echo Press any key to exit...
pause > nul