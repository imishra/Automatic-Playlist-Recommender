@ECHO OFF
REM ###################################################################
REM
REM APR is the python virtual environment which has all the required 
REM packages to execute the Auto Playlist Generator app.
REM 
REM ###################################################################
call activate APR
python PlaylistRecommenderAPI.py