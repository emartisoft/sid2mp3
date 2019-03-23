::
:: SID2MP3 by emarti, Murat Ozdemir Mar 2019
::
:: Requirements:
:: SID2WAV -> http://www.vgmpf.com/Wiki/images/2/2a/SID_to_WAV_v1.8.zip
:: FFMPEG  -> https://ffmpeg.zeranoe.com/builds/
::

@echo off
:: sid total time is 300 sec.(5 minutes), you may change it.
set sid_total_time=300
mode 80,6
color 0a
set count=0
set info=                   SID2MP3 by emarti, Murat Ozdemir Mar 2019
set line=-------------------------------------------------------------------------------
title %info%
:: *** convert from sid to wav ***
dir /b /s *.sid > sidlist.txt
for /f "tokens=*" %%A in (sidlist.txt) do (
	cls
	echo %info%
	echo %line%
	echo Please wait while converting from sid to wav 
	echo Converting : %%~nA.sid
	echo %line%
	SID2WAV.EXE -t%sid_total_time% %%~dpnxA %%~dpnA.wav > sid2wav.log
	set /a count+=1
	)
:: *** convert from wav to mp3 ***
dir /b /s *.wav > wavlist.txt
for /f "tokens=*" %%A in (wavlist.txt) do (
	cls	
	echo %info%
	echo %line%
	echo Folder   : %%~dpA
	echo Creating : %%~nA.mp3
	echo %line%
	ffmpeg -loglevel panic -i %%~ndpxA -codec:a libmp3lame -qscale:a 2 %%~dpnA.mp3 -y
	del %%~ndpxA
	)
del *.txt
del *.log
cls
echo %info%
echo %line%
if /I "%count%" EQU "1" echo The SID file was converted to MP3
if /I "%count%" GTR "1" echo %count% SID files were converted to MP3
echo Ok.
echo %line%
pause >NUL
