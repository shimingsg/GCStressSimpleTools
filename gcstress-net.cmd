@if not defined _echo @echo off
setlocal 

set CONFIGURATIONGROUP=Release
set ANYOS_ANYCPU_DEBUG_LOCATION=%~dp0\corefx\bin\AnyOS.AnyCPU.%CONFIGURATIONGROUP%
set WINDOWS_NT_ANYCPU_DEBUG_LOCATION=%~dp0\corefx\bin\Windows_NT.AnyCPU.%CONFIGURATIONGROUP%
set TESTHOST_PATH=%~dp0\corefx\bin\testhost\netcoreapp-Windows_NT-%CONFIGURATIONGROUP%-x64

@echo TestGCStressLevel : %TestGCStressLevel%
@echo COMPlus_GCStress : %COMPlus_GCStress%

set ERRORLEVEL=0
set exitCode=0
set errorCount=0
set totalCount=0

call :RunSpecificLibs %ANYOS_ANYCPU_DEBUG_LOCATION%
call :RunSpecificLibs %WINDOWS_NT_ANYCPU_DEBUG_LOCATION%

@echo Networking - Total Count: %totalCount%
@echo Networking - Error Count: %errorCount%
exit /b %exitCode%


:RunSpecificLibs
set TARGET_PATH=%~1
@echo .
@echo Current Test Files are at %TARGET_PATH%
@echo .

pushd %TARGET_PATH%

FOR /D %%F IN (System.Net.*.Tests) DO (
	IF EXIST %%F\netcoreapp (
		pushd %%F\netcoreapp
        @echo Looking in %cd%...
		IF EXIST RunTests.cmd (
			set /a totalCount=%totalCount%+1
            @echo ... found tests
			CALL RunTests.cmd %TESTHOST_PATH%
			IF NOT %ERRORLEVEL% == 0 (
				set /a errorCount=%errorCount%+1
				set exitCode=%ERRORLEVEL%
				@echo "error: One or more tests failed while running tests from '%TARGET_PATH%\%%F\netcoreapp'.  Exit code %exitCode%."
			)
		)
		popd
	)
	IF EXIST %%F\netstandard (
		pushd %%F\netstandard
        @echo Looking in %cd%...
		IF EXIST RunTests.cmd (
			set /a totalCount=%totalCount%+1
            @echo ... found tests
			CALL RunTests.cmd %TESTHOST_PATH%
			IF NOT %ERRORLEVEL% == 0 (
				set /a errorCount=%errorCount%+1
				set exitCode=%ERRORLEVEL%
				@echo "error: One or more tests failed while running tests from '%TARGET_PATH%\%%F\netstandard'.  Exit code %exitCode%."
			)
		)
		popd
	)
)

popd

goto :EOF

REM Function END
