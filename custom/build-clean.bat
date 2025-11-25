@echo off
setlocal enabledelayedexpansion
echo Compiling LaTeX resume to PDF (with cleanup)...
echo.

REM Run pdflatex multiple times to resolve references and citations
C:\Users\sagar\AppData\Local\Programs\MiKTeX\miktex\bin\x64\pdflatex.exe -interaction=nonstopmode resume.tex
C:\Users\sagar\AppData\Local\Programs\MiKTeX\miktex\bin\x64\pdflatex.exe -interaction=nonstopmode resume.tex

REM Clean up auxiliary files
del *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz 2>nul

REM Crop PDF to fit content (maintain letter width, auto-adjust height)
echo.
echo Cropping PDF to fit content...
if exist "resume.pdf" (
    REM Use conda Python for cropping
    REM Try to find Python in conda
    if exist "C:\ProgramData\miniconda3\python.exe" (
        C:\ProgramData\miniconda3\python.exe crop-pdf.py resume.pdf resume_cropped.pdf 2>nul
        if exist "resume_cropped.pdf" (
            del resume.pdf
            ren resume_cropped.pdf resume.pdf
            echo PDF cropped to content bounds using Python script!
        ) else (
            echo Note: Cropping failed. Make sure PyPDF2 or pdfCropMargins is installed.
            echo To install: conda activate base ^&^& pip install PyPDF2
        )
    ) else (
        REM Try using conda activate
        call C:\ProgramData\miniconda3\Scripts\activate.bat base >nul 2>&1
        python crop-pdf.py resume.pdf resume_cropped.pdf 2>nul
        if exist "resume_cropped.pdf" (
            del resume.pdf
            ren resume_cropped.pdf resume.pdf
            echo PDF cropped to content bounds using Python script!
        ) else (
            echo Note: Python cropping not available. PDF has large height.
            echo To enable: conda activate base ^&^& pip install PyPDF2
        )
    )
)

echo.
echo PDF compilation complete and auxiliary files cleaned!
echo Check for resume.pdf in the current directory.
if not defined SKIP_PAUSE pause

