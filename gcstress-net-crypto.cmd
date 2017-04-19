@if not defined _echo @echo off
setlocal 
REM if "%~1"=="" ( set STRESSMODE=3 
REM ) else ( set STRESSMODE=%~1 )

if "%LOCATION%" == "" set LOCATION=%~dp0\corefx\bin\Windows_NT.AnyCPU.Debug
set ANYOS_ANYCPU_DEBUG_LOCATION=%~dp0\corefx\bin\AnyOS.AnyCPU.Debug
set WINDOWS_NT_ANYCPU_DEBUG_LOCATION=%~dp0\corefx\bin\Windows_NT.AnyCPU.Debug
if "%RUNTIME_PATH%" == "" set RUNTIME_PATH=%~dp0\corefx\bin\runtime\netcoreapp-Windows_NT-Debug-x64

set TESTHOST_PATH=%~dp0\corefx\bin\testhost\netcoreapp-Windows_NT-Debug-x64

REM set COMPlus_GCStress=%STRESSMODE%

@echo STRESSMODE : %STRESSMODE%

pushd %ANYOS_ANYCPU_DEBUG_LOCATION%

FOR /D %%F IN (System.Security.Crypto*.Tests) DO (
	IF EXIST %%F\netcoreapp (
		pushd %%F\netcoreapp
                @echo Looking in %cd%...
		IF EXIST RunTests.cmd (
                        @echo ... found tests
			CALL RunTests.cmd %TESTHOST_PATH%
		)
		popd
	)
	IF EXIST %%F\netstandard (
		pushd %%F\netstandard
                @echo Looking in %cd%...
		IF EXIST RunTests.cmd (
                        @echo ... found tests
			CALL RunTests.cmd %TESTHOST_PATH%
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
		)
		popd
	)
	IF EXIST %%F\netstandard (
		pushd %%F\netstandard
                @echo Looking in %cd%...
		IF EXIST RunTests.cmd (
                        @echo ... found tests
			CALL RunTests.cmd %TESTHOST_PATH%
		)
		popd
	)
)

popd

pushd %WINDOWS_NT_ANYCPU_DEBUG_LOCATION%

FOR /D %%F IN (System.Security.Crypto*.Tests) DO (
	IF EXIST %%F\netcoreapp (
		pushd %%F\netcoreapp
                @echo Looking in %cd%...
		IF EXIST RunTests.cmd (
                        @echo ... found tests
			CALL RunTests.cmd %TESTHOST_PATH%
		)
		popd
	)
	IF EXIST %%F\netstandard (
		pushd %%F\netstandard
                @echo Looking in %cd%...
		IF EXIST RunTests.cmd (
                        @echo ... found tests
			CALL RunTests.cmd %TESTHOST_PATH%
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
		)
		popd
	)
	IF EXIST %%F\netstandard (
		pushd %%F\netstandard
                @echo Looking in %cd%...
		IF EXIST RunTests.cmd (
                        @echo ... found tests
			CALL RunTests.cmd %TESTHOST_PATH%
		)
		popd
	)
)
popd