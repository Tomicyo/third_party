for /f %%i in ('dir /b %ANDROID_HOME%\cmake') do set CMAKE_DIR=%ANDROID_HOME%\cmake\%%i
set CMAKE_BIN=%CMAKE_DIR%\bin\cmake
set CMAKE_NINJA=%CMAKE_DIR%\bin\ninja
set CMAKE_TOOLCHAIN=%ANDROID_NDK_HOME%\build\cmake\android.toolchain.cmake

set MK_OPT=-DCMAKE_MAKE_PROGRAM=%CMAKE_NINJA% -DANDROID_NDK=%ANDROID_NDK_HOME% -DANDROID_TOOLCHAIN=clang -DCMAKE_TOOLCHAIN_FILE=%CMAKE_TOOLCHAIN%
set INSTALL_DIR=..\ThirdParty_Prebuilt

call :Build Release armeabi-v7a 23 23 gnustl_shared
call :Build Debug armeabi-v7a 23 23 gnustl_shared
call :Build Release arm64-v8a 23 23 gnustl_shared
call :Build Debug arm64-v8a 23 23 gnustl_shared
call :Build Release armeabi-v7a 23 23 c++_shared
call :Build Debug armeabi-v7a 23 23 c++_shared
call :Build Release arm64-v8a 23 23 c++_shared
call :Build Debug arm64-v8a 23 23 c++_shared
exit /b %errorlevel%


:Build
set MK_CONFIG=%~1
set MK_ABI=%~2
set MK_LEV=%~3
set MK_PLATFORM=%~4
set MK_STL=%~5
set	MK_ANDROID_OPT=-DANDROID_ABI=%MK_ABI% -DANDROID_NATIVE_API_LEVEL=%MK_LEV% -DANDROID_PLATFORM=android-%MK_PLATFORM% -DANDROID_STL=%MK_STL% -DANDROID_CPP_FEATURES=rtti;exceptions
set MK_PREFIX=%INSTALL_DIR%\Android\%MK_CONFIG%\%MK_STL%\%MK_ABI%
set MK_INTERMEDIATE=build\android\%MK_CONFIG%\%MK_STL%\%MK_ABI%
%CMAKE_BIN% -G"Android Gradle - Ninja" -H. -B%MK_INTERMEDIATE% %MK_OPT% %MK_ANDROID_OPT% -DCMAKE_BUILD_TYPE=%MK_CONFIG% -DCMAKE_INSTALL_PREFIX=%MK_PREFIX%
%CMAKE_BIN% --build %MK_INTERMEDIATE% --config %MK_CONFIG% --target install
:End