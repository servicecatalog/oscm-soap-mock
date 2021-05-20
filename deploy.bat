@echo off
REM Copyright FUJITSU LIMITED 2021
REM Author L. Goebel

REM Use this Windows batch file to deploy the SOAP Mock Application on your OSCM server.
REM Make sure you have built the war file with maven, the docker host is accessible with Putty and OSCM is running.

if [%1]==[] goto usage

SET REMOTE_CONNECTION=%1
for %%X in (plink.exe) do (set FOUND_PLINK=%%~$PATH:X)
for %%X in (pscp.exe) do (set FOUND_PSCP=%%~$PATH:X)

IF NOT EXIST "%FOUND_PLINK%" goto noputty
IF NOT EXIST "%FOUND_PSCP%" goto noputty

set user=%REMOTE_CONNECTION::=&rem %
set password=%REMOTE_CONNECTION:*:=%
set password=%password:@=&rem %
set host=%REMOTE_CONNECTION:*@=%

plink -v %host% -l %user% -pw %password%  mkdir --parents /tmp/transfer/
pscp -l %user% -pw %password% -scp .\target\oscm-soap-mock.war %host%:/tmp/transfer/
plink -v %host% -l %user% -pw %password% docker exec oscm-core rm -rf /opt/apache-tomee/webapps/oscm-soap-mock.war
plink -v %host% -l %user% -pw %password% docker exec oscm-core rm -rf /opt/apache-tomee/webapps/oscm-soap-mock
plink -v %host% -l %user% -pw %password% docker cp /tmp/transfer/oscm-soap-mock.war oscm-core:/opt/apache-tomee/webapps
plink -v %host% -l %user% -pw %password% docker cp /tmp/transfer/oscm-soap-mock.war oscm-core:/opt/apache-tomee/webapps
plink -v %host% -l %user% -pw %password% docker restart oscm-core

echo.
echo Hang on! The soap mock is now being the deployed in oscm-core. It should be available soon.
goto :eof

:usage
  echo *** Missing argument 'remote connection'. Use "%~n0 user:password@host.domain" (replaced by the SSH access values for your running OSCM server)
  exit /B 1

:noputty
  echo Please install putty and make sure the included plink.exe and pscp.exe are accessible from CMD (included in the system PATH variable on Windows).
  exit /B 1