set INSTALL_ROOT=..\Test
call :Build "Release"
call :Build "Debug"
xcopy /S tools\win_pack.py ..\Test\Win64
xcopy /S tools\third_party.cmake artifacts\lib\cmake\
pushd %~dp0
cd ..\Test\Win64
python win_pack.py
popd
xcopy /S ..\Test\Win64\artifacts artifacts\
exit /b %errorlevel%

:Build
set mk_config=%~1
set mk_intermediate=build\win64\%mk_config%
set mk_prefix=%INSTALL_ROOT%\Win64\%mk_config%
cmake -G"Visual Studio 15 2017 Win64" -H. -B%mk_intermediate% -DCMAKE_BUILD_TYPE=%mk_config% -DCMAKE_INSTALL_PREFIX=%mk_prefix%
cmake --build %mk_intermediate% --config %mk_config% --target install
if %errorlevel% neq 0 exit /b %errorlevel%
exit /b