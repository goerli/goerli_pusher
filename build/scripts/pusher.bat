@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  pusher startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Add default JVM options here. You can also use JAVA_OPTS and PUSHER_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem Get command-line arguments, handling Windows variants

if not "%OS%" == "Windows_NT" goto win9xME_args

:win9xME_args
@rem Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:win9xME_args_slurp
if "x%~1" == "x" goto execute

set CMD_LINE_ARGS=%*

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\pusher.jar;%APP_HOME%\lib\kotlin-walletconnect-lib-1e2ed50602e1b288279b466888e7c3bf8b7bdd36.jar;%APP_HOME%\lib\erc55-0.73.1.jar;%APP_HOME%\lib\eip155-0.73.1.jar;%APP_HOME%\lib\erc681-0.73.1.jar;%APP_HOME%\lib\erc1328-0.73.1.jar;%APP_HOME%\lib\rpc-0.73.1.jar;%APP_HOME%\lib\keystore-0.73.1.jar;%APP_HOME%\lib\wallet-0.73.1.jar;%APP_HOME%\lib\crypto-0.73.1.jar;%APP_HOME%\lib\functions-0.73.1.jar;%APP_HOME%\lib\crypto_impl_bouncycastle-0.73.1.jar;%APP_HOME%\lib\crypto_impl_java_provider-0.73.1.jar;%APP_HOME%\lib\crypto_api-0.73.1.jar;%APP_HOME%\lib\uri_common-0.73.1.jar;%APP_HOME%\lib\erc831-0.73.1.jar;%APP_HOME%\lib\test_data-0.73.1.jar;%APP_HOME%\lib\model-0.73.1.jar;%APP_HOME%\lib\kotlinx-coroutines-core-1.0.1.jar;%APP_HOME%\lib\lib-0.2.jar;%APP_HOME%\lib\rlp-0.73.1.jar;%APP_HOME%\lib\extensions-0.73.1.jar;%APP_HOME%\lib\keccak_shortcut-0.73.1.jar;%APP_HOME%\lib\hashes-0.73.1.jar;%APP_HOME%\lib\sha3-0.7.jar;%APP_HOME%\lib\khex-0.6.jar;%APP_HOME%\lib\ripemd160-0.73.1.jar;%APP_HOME%\lib\kotlin-stdlib-1.3.21.jar;%APP_HOME%\lib\moshi-adapters-1.8.0.jar;%APP_HOME%\lib\moshi-1.8.0.jar;%APP_HOME%\lib\okhttp-3.12.1.jar;%APP_HOME%\lib\twitter4j-core-4.0.7.jar;%APP_HOME%\lib\kotlinx-coroutines-core-common-1.0.1.jar;%APP_HOME%\lib\kotlin-stdlib-common-1.3.21.jar;%APP_HOME%\lib\annotations-13.0.jar;%APP_HOME%\lib\slf4j-log4j12-1.7.25.jar;%APP_HOME%\lib\slf4j-api-1.7.25.jar;%APP_HOME%\lib\bcprov-jdk15on-1.60.jar;%APP_HOME%\lib\okio-1.16.0.jar;%APP_HOME%\lib\core-3.3.0.jar;%APP_HOME%\lib\log4j-1.2.17.jar

@rem Execute pusher
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %PUSHER_OPTS%  -classpath "%CLASSPATH%" net.goerli.pusher.MainKt %CMD_LINE_ARGS%

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable PUSHER_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%PUSHER_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
