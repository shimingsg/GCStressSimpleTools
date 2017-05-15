@if not defined _echo @echo off
setlocal 

set CONFIGURATIONGROUP=Release
set ANYOS_ANYCPU_DEBUG_LOCATION=%~dp0\corefx\bin\AnyOS.AnyCPU.%CONFIGURATIONGROUP%
set WINDOWS_NT_ANYCPU_DEBUG_LOCATION=%~dp0\corefx\bin\Windows_NT.AnyCPU.%CONFIGURATIONGROUP%
set TESTHOST_PATH=%~dp0\corefx\bin\testhost\netcoreapp-Windows_NT-%CONFIGURATIONGROUP%-x64
set LOG_FILE=%~dp0\gcstress-all-except-net.crypto.log

@echo TestGCStressLevel : %TestGCStressLevel%
@echo COMPlus_GCStress : %COMPlus_GCStress%

set ERRORLEVEL=0
set exitCode=0

call :RunSpecificLibs %ANYOS_ANYCPU_DEBUG_LOCATION%
call :RunSpecificLibs %WINDOWS_NT_ANYCPU_DEBUG_LOCATION%

exit /b %exitCode%


:RunSpecificLibs
set TARGET_PATH=%~1
@echo .
@echo Current Test Files are at %TARGET_PATH%
@echo .

pushd %TARGET_PATH%

FOR /D %%N in ("System.Net.*.Tests") do rd /s /q "%%~N"
FOR /D %%C in ("System.Security.Crypto*.Tests") do rd /s /q "%%~C"

FOR /D %%F IN (*.Tests) DO (
	
	IF EXIST %%F\netcoreapp (
		pushd %%F\netcoreapp
        @echo Looking in %cd%...
		IF EXIST RunTests.cmd (
			@echo ... found tests
			CALL RunTests.cmd %TESTHOST_PATH%
			IF NOT %ERRORLEVEL% == 0 (
				set exitCode=%ERRORLEVEL%
				@echo "error: One or more tests failed while running tests from '%TARGET_PATH%\%%F\netcoreapp'.  Exit code %exitCode%."
				@echo "error: One or more tests failed while running tests from '%TARGET_PATH%\%%F\netcoreapp'.  Exit code %exitCode%." >> %LOG_FILE%
			)
		)
		popd
	)
	IF EXIST %%F\netstandard (
		pushd %%F\netstandard
        @echo Looking in %cd%...
		IF EXIST RunTests.cmd (
            @echo ... found tests
			CALL RunTests.cmd %TESTHOST_PATH%
			IF NOT %ERRORLEVEL% == 0 (
				set exitCode=%ERRORLEVEL%
				@echo "error: One or more tests failed while running tests from '%TARGET_PATH%\%%F\netstandard'.  Exit code %exitCode%."
				@echo "error: One or more tests failed while running tests from '%TARGET_PATH%\%%F\netstandard'.  Exit code %exitCode%." >> %LOG_FILE%
			)
		)
		popd
	)
)

popd

goto :EOF

REM Function END
