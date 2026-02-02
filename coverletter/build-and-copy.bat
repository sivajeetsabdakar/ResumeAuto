@echo off
setlocal enabledelayedexpansion
echo ========================================
echo Building cover letter and copying PDF...
echo ========================================
echo.

REM Run pdflatex multiple times to resolve references
echo [Step 1/3] Compiling cover letter (first pass)...
C:\Users\sagar\AppData\Local\Programs\MiKTeX\miktex\bin\x64\pdflatex.exe -interaction=nonstopmode coverletter.tex >nul 2>&1

echo [Step 2/3] Compiling cover letter (second pass)...
C:\Users\sagar\AppData\Local\Programs\MiKTeX\miktex\bin\x64\pdflatex.exe -interaction=nonstopmode coverletter.tex >nul 2>&1

REM Clean up auxiliary files
echo [Step 3/3] Cleaning up auxiliary files...
del *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz 2>nul

REM Copy PDF to custom directory
if exist "coverletter.pdf" (
    echo.
    echo Copying coverletter.pdf to custom/ directory...
    copy /Y coverletter.pdf ..\custom\coverletter.pdf >nul
    if exist "..\custom\coverletter.pdf" (
        echo Successfully copied coverletter.pdf to custom/ directory!
    ) else (
        echo Error: Failed to copy PDF file.
    )
) else (
    echo Error: coverletter.pdf was not generated. Check for compilation errors.
)

echo.
echo ========================================
echo Build and copy complete!
echo ========================================
pause

