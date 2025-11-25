#!/usr/bin/env python3
"""
Crop PDF to fit content while maintaining letter paper width (8.5 inches).
Uses pdfCropMargins if available, otherwise falls back to PyPDF2.
"""

import sys
import os
import subprocess

def crop_with_pdfcropmargins(input_path, output_path):
    """Use pdfCropMargins to crop height while maintaining 0.5 inch margins."""
    try:
        # Try using pdfCropMargins as a command-line tool
        # 0.5 inches = 36 bp (big points, 72 bp per inch)
        # Use -a (absolute offset) with negative values to ADD margins
        # -p 0 means tight crop, then -a -36 adds 36bp (0.5in) margin on all sides
        python_exe = sys.executable
        result = subprocess.run(
            [python_exe, '-m', 'pdfCropMargins', 
             '-p', '0',  # Tight crop first
             '-a4', '-36', '-36', '-36', '-36',  # Add 0.5 inch (36bp) margins: left, bottom, right, top
             '-o', output_path,
             input_path],
            capture_output=True,
            text=True,
            timeout=60
        )
        # Check if output file was created
        if os.path.exists(output_path) and os.path.getsize(output_path) > 1000:
            return True
        # If explicit output didn't work, check default naming
        default_output = input_path.replace('.pdf', '_cropped.pdf')
        if os.path.exists(default_output):
            import shutil
            shutil.copy(default_output, output_path)
            return os.path.getsize(output_path) > 1000
        return False
    except (FileNotFoundError, subprocess.TimeoutExpired) as e:
        return False
    except Exception as e:
        print(f"pdfCropMargins CLI error: {e}")
        # Try programmatic API as fallback
        try:
            from pdfCropMargins import crop
            crop(["-p", "0", "-a4", "-36", "-36", "-36", "-36", "-o", output_path, input_path])
            return os.path.exists(output_path) and os.path.getsize(output_path) > 1000
        except Exception as e2:
            print(f"pdfCropMargins API error: {e2}")
            return False

# Removed crop_with_pypdf2 - it can't properly detect content bounds
# PyPDF2 alone is insufficient for automatic content detection

def crop_with_ghostscript(input_path, output_path):
    """Use ghostscript to crop PDF."""
    gs_cmd = 'gswin64c'
    
    # Try different ghostscript executable names
    for gs_exe in ['gswin64c', 'gswin32c', 'gs']:
        try:
            result = subprocess.run(
                [gs_exe, '-h'],
                capture_output=True,
                text=True,
                timeout=2
            )
            if result.returncode == 0 or 'Ghostscript' in result.stderr:
                gs_cmd = gs_exe
                break
        except (FileNotFoundError, subprocess.TimeoutExpired):
            continue
    
    # Use ghostscript to set page size based on content
    try:
        result = subprocess.run(
            [gs_cmd,
             '-sDEVICE=pdfwrite',
             '-dCompatibilityLevel=1.4',
             '-dNOPAUSE',
             '-dQUIET',
             '-dBATCH',
             f'-sOutputFile={output_path}',
             '-dPDFFitPage',
             '-dFIXEDMEDIA',
             '-dDEVICEWIDTHPOINTS=612',  # Letter width in points
             '-dDEVICEHEIGHTPOINTS=792',  # Will be adjusted
             '-c', '[ /CropBox [0 0 612 792] /PAGE pdfmark',
             '-f', input_path
            ],
            capture_output=True,
            text=True,
            timeout=30
        )
        return os.path.exists(output_path) and os.path.getsize(output_path) > 0
    except (FileNotFoundError, subprocess.TimeoutExpired):
        return False
    except Exception as e:
        print(f"Ghostscript error: {e}")
        return False

def main():
    if len(sys.argv) != 3:
        print("Usage: crop-pdf.py <input.pdf> <output.pdf>")
        sys.exit(1)
    
    input_path = sys.argv[1]
    output_path = sys.argv[2]
    
    if not os.path.exists(input_path):
        print(f"Error: Input file '{input_path}' not found")
        sys.exit(1)
    
    # Try different cropping methods in order of preference
    if crop_with_pdfcropmargins(input_path, output_path):
        if os.path.exists(output_path) and os.path.getsize(output_path) > 1000:
            print(f"Successfully cropped PDF using pdfCropMargins")
            return
    
    if crop_with_ghostscript(input_path, output_path):
        if os.path.exists(output_path) and os.path.getsize(output_path) > 1000:
            print(f"Successfully cropped PDF using ghostscript")
            return
    
    # Don't use PyPDF2 for cropping - it can't detect content bounds properly
    # If all methods fail, just copy the original (better than empty PDF)
    print("Warning: Could not crop PDF automatically. Using original file.")
    print("Note: To enable cropping, ensure pdfCropMargins is properly installed.")
    import shutil
    shutil.copy(input_path, output_path)

if __name__ == '__main__':
    main()

