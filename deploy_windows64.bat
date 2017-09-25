call :Build Release
call :Build Debug
exit /b %errorlevel%

:Build
cd C:/projects/kaleido3d/Source/ThirdParty_Prebuilt/Win64/%~1
if %errorlevel% neq 0 exit /b %errorlevel%
git init
git lfs track "lib/*.lib"
git add .
git commit -m "update build windows config=%~1"
git remote add origin https://github.com/Tomicyo/kaleido3d_dep_prebuilt.git
git branch win64_%~1
git push -u -f origin win64_%~1
if %errorlevel% neq 0 exit /b %errorlevel%
exit /b