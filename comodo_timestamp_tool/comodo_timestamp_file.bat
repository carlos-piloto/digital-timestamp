echo off

if [%1]==[] goto usage

REM Get the filename
set FILE_NAME=%1
REM Timestamp request filename
set TSQ_FILENAME=%FILE_NAME%_timestamp_request.tsq
REM Timestamp response filename
set TSR_FILENAME=%FILE_NAME%_timestamp_response.tsr

@echo ---------------------------------------------------------------
@echo Generating the timestamp request for the filename with openSSL
@echo ---------------------------------------------------------------
openssl ts -query -data %FILE_NAME% -cert -sha256 -no_nonce -out %TSQ_FILENAME%

@echo --------------------------------------------------
@echo Sending the request to the COMODO timestamp server
@echo --------------------------------------------------
CURL.EXE -k  -H "Content-Type: application/timestamp-query" --data-binary @%TSQ_FILENAME% "http://timestamp.comodoca.com?td=sha256" > %TSR_FILENAME%

@echo ----------------------------------------------
@echo Display the response of the timestamp server
@echo ----------------------------------------------
openssl.exe ts -reply -in %TSR_FILENAME% -text

@echo ----------------------------------------------
@echo Verify the response of the timestamp server
@echo ----------------------------------------------
openssl ts -verify -data %FILE_NAME% -in %TSR_FILENAME% -CAfile comodoCA.crt

goto :eof

:usage
@echo Usage: %0 ^<File name^>
exit /B 1