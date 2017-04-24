@if not defined _echo @echo off
setlocal 

set ANYOS_ANYCPU_DEBUG_LOCATION=%~dp0\corefx\bin\AnyOS.AnyCPU.Debug
set WINDOWS_NT_ANYCPU_DEBUG_LOCATION=%~dp0\corefx\bin\Windows_NT.AnyCPU.Debug
set TESTHOST_PATH=%~dp0\corefx\bin\testhost\netcoreapp-Windows_NT-Debug-x64

@echo STRESSLEVEL : %TestGCStressLevel%
@echo STRESSMODE : %COMPlus_GCStress%

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

FOR /D %%F IN (System.Security.Crypto*.Tests) DO (
	IF EXIST %%F\netcoreapp (
		pushd %%F\netcoreapp
                @echo Looking in %cd%...
		IF EXIST RunTests.cmd (
                        @echo ... found tests
			CALL RunTests.cmd %TESTHOST_PATH%
			IF %ERRORLEVEL% neq 0 (
				set exitCode=%ERRORLEVEL%
				@echo "error: One or more tests failed while running tests from '%%F\netcoreapp'.  Exit code %exitCode%."
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
			IF %ERRORLEVEL% neq 0 (
				set exitCode=%ERRORLEVEL%
				@echo "error: One or more tests failed while running tests from '%%F\netstandard'.  Exit code %exitCode%."
			)
		)
		popd
	)
)

FOR /D %%F IN (System.Net.*.Tests) DO (
	IF EXIST %%F\netcoreapp (
		pushd %%F\netcoreapp
                @echo Looking in %cd%...
		IF EXIST RunTests.cmd (
                        @echo ... found tests
			CALL RunTests.cmd %TESTHOST_PATH%
			IF %ERRORLEVEL% neq 0 (
				set exitCode=%ERRORLEVEL%
				@echo "error: One or more tests failed while running tests from '%%F\netcoreapp'.  Exit code %exitCode%."
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
			IF %ERRORLEVEL% neq 0 (
				set exitCode=%ERRORLEVEL%
				@echo "error: One or more tests failed while running tests from '%%F\netstandard'.  Exit code %exitCode%."
			)
		)
		popd
	)
)

FOR /D %%F IN (System.Console.Tests) DO (
	IF EXIST %%F\netcoreapp (
		pushd %%F\netcoreapp
                @echo Looking in %cd%...
		IF EXIST RunTests.cmd (
                        @echo ... found tests
			CALL RunTests.cmd %TESTHOST_PATH%
			IF %ERRORLEVEL% neq 0 (
				set exitCode=%ERRORLEVEL%
				@echo "error: One or more tests failed while running tests from '%%F\netcoreapp'.  Exit code %exitCode%."
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
			IF %ERRORLEVEL% neq 0 (
				set exitCode=%ERRORLEVEL%
				@echo "error: One or more tests failed while running tests from '%%F\netstandard'.  Exit code %exitCode%."
			)
		)
		popd
	)
)

popd

goto :EOF

REM Function END
