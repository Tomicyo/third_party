set INSTALL_ROOT=..\kaleido3d\Source\ThirdParty_Prebuilt

call :Build "Release"
call :Build "Debug"
exit /b %errorlevel%

:Build
set mk_config=%~1
set mk_intermediate=build\win64\%mk_config%
set mk_prefix=%INSTALL_ROOT%\Win64\%mk_config%
cmake -G"Visual Studio 15 2017 Win64" -H. -B%mk_intermediate% -DCMAKE_BUILD_TYPE=%mk_config% -DCMAKE_INSTALL_PREFIX=%mk_prefix% -DCMAKE_SYSTEM_NAME=WindowsStore -DCMAKE_SYSTEM_VERSION=10.0
cmake --build %mk_intermediate% --config %mk_config% --target install
if %errorlevel% neq 0 exit /b %errorlevel%
exit /b