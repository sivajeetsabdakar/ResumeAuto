@echo off
echo Copying all files and folders from og to custom (excluding PDF files)...
echo.

REM Create custom directory if it doesn't exist
if not exist "custom" mkdir custom

REM Copy all files and subdirectories from og to custom, excluding PDF files
REM Using robocopy for better file exclusion support
robocopy "ogfolder" "custom" /E /NFL /NDL /NJH /NJS /XF *.pdf

REM Robocopy returns error codes: 0-7 = success, 8+ = error
REM Exit code 0 means no files copied, 1-7 means files were copied
echo.
echo Copy complete!
echo All files and folders from ogfolder have been copied to custom (PDF files excluded).

if not defined SKIP_PAUSE pause

