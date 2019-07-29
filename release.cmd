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
echo * building %file_name%
echo **************************************

if /i [%1] == [patch] goto :increment
if /i [%1] == [minor] goto :increment
if /i [%1] == [major] goto :increment
if [%1] == [] goto :increment
call :error invalid increment
:increment

echo Deleting pom.xml
del pom.xml

echo Deleting emacs backup files
del /S *.*~

echo Generating pom.xml
clojure -Spom
call :check Generate pom.xml

echo Updating pom.xml
clojure -Agaramond:setprops
call :check garamond set pom properties

if [%1] == [] goto :no_increment
echo Incrementing version in pom and git
clojure -Agaramond:increment %1
call :check garamond git increment
:no_increment

echo Get version
clojure -Agaramond>version.txt
call :check garamond get version
set /p version=<version.txt
set version=%version:~1%
echo We're building version "%version%"
set jar=out\%file_name%-%version%.jar

echo Creating thin jar
clojure -A:depstar %jar%
call :check depstar create thin jar

if [%1] == [] goto :no_deploy
echo Deploying
clojure -A:deploy %jar%
call :check deploy

echo pushing tags
git push --tags origin
call :check push tags
:no_deploy

:the-end
exit /b

:check
if errorlevel 1 goto :error
exit /b

:error
echo !!! ERROR %* !!!
exit 1
