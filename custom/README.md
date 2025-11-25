# Resume Auto - LaTeX PDF Generation

This project contains a LaTeX resume that can be compiled to PDF, similar to how Overleaf works.

## Prerequisites

You need to have a LaTeX distribution installed on your Windows system:

1. **MiKTeX** (Recommended for Windows): [Download MiKTeX](https://miktex.org/download)
2. **TeX Live**: [Download TeX Live](https://www.tug.org/texlive/windows.html)

Make sure `pdflatex` is in your system PATH, or install the full LaTeX distribution which includes it.

## Quick Build

### Option 1: Using the build script (Recommended)
Double-click `build.bat` or run it from command prompt:
```cmd
build.bat
```

### Option 2: Using the clean build script
This compiles and removes auxiliary files:
```cmd
build-clean.bat
```

### Option 3: Manual compilation
Open command prompt in this directory and run:
```cmd
pdflatex resume.tex
pdflatex resume.tex
```

The PDF will be generated as `resume.pdf` in the same directory.

## Why run pdflatex twice?

LaTeX sometimes needs multiple passes to:
- Resolve cross-references
- Generate table of contents
- Properly format citations
- Calculate page layouts

Running it twice ensures all references are properly resolved (just like Overleaf does automatically).

## Troubleshooting

- **"pdflatex is not recognized"**: Make sure LaTeX is installed and added to your PATH, or use the full path to pdflatex.exe
- **Missing packages**: MiKTeX will automatically prompt to install missing packages on first run
- **Font errors**: Some fonts (like Lato) may need to be installed separately or use a different font package

## File Structure

- `resume.tex` - Main LaTeX file (compile this one)
- `src/` - Contains section files (education, experience, projects, etc.)
- `custom-commands.tex` - Custom LaTeX commands

