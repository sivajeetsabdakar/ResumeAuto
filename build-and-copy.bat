@echo off
echo ========================================
echo Building resume and copying files...
echo ========================================
echo.

REM Set environment variable to skip pause in called scripts
set SKIP_PAUSE=1

REM Step 1: Build the resume in the custom directory
echo [Step 1/2] Building resume...
cd custom
call build-clean.bat
cd ..

echo.
echo ========================================
echo.

REM Step 2: Copy files after build is complete
echo [Step 2/2] Copying files...
call copy.bat

REM Clear the skip pause flag
set SKIP_PAUSE=

echo.
echo ========================================
echo All done!
echo ========================================
pause

