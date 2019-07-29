@echo off
setlocal

REM for error handling
if not "%selfWrapped%"=="%~0" (
  set selfWrapped=%~0
  %ComSpec% /s /c ""%~0" %*"
  goto :eof
)

set file_name=clojure-lib-template
echo **************************************
call :echo building %file_name%
echo **************************************

if /i [%1] == [patch] goto :increment
if /i [%1] == [minor] goto :increment
if /i [%1] == [major] goto :increment
if [%1] == [] goto :increment
call :error invalid increment
:increment

call :echo Deleting pom.xml
del pom.xml

call :echo Deleting emacs backup files
del /S *.*~

call :echo Generating pom.xml
clojure -Spom
call :check Generate pom.xml

call :echo Updating pom.xml
clojure -Agaramond:setprops
call :check garamond set pom properties

if [%1] == [] goto :no_increment
call :echo Incrementing version in pom and git
clojure -Agaramond:increment %1
call :check garamond git increment
:no_increment

call :echo Get version
clojure -Agaramond>version.txt
call :check garamond get version
set /p version=<version.txt
set version=%version:~1%
call :echo We're building version "%version%"
set jar=out\%file_name%-%version%.jar

call :echo Creating thin jar
clojure -A:depstar %jar%
call :check depstar create thin jar

if [%1] == [] goto :no_deploy
call :echo Deploying
clojure -A:deploy %jar%
call :check deploy

call :echo pushing tags
git push --tags origin
call :check push tags
:no_deploy

:the-end
exit /b

:check
if errorlevel 1 goto :error
exit /b

:error
echo !!!!!!!!!!!!!!!!!!!!! ERROR %* !!!!!!!!!!!!!!!!!!!!!
exit 1

:echo
echo **** %*
exit /b
