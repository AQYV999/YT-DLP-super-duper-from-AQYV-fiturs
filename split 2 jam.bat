@echo off
REM ============================================
REM  Auto Split - Drag & Drop File Audio
REM  Potong jadi 2 jam per bagian
REM ============================================

if "%~1"=="" (
    echo Cara pakai: DRAG file audio ke file .bat ini
    pause
    exit /b
)

set "INPUT=%~1"
set "FOLDER=%~dp1"
cd /d "%FOLDER%"

for %%F in ("%INPUT%") do set "BASENAME=%%~nF"
for %%F in ("%INPUT%") do set "EXT=%%~xF"

echo ============================================
echo  Memproses: %INPUT%
echo ============================================
echo.

ffmpeg -i "%INPUT%" ^
  -f segment ^
  -segment_time 7200 ^
  -c copy ^
  "%BASENAME%_part%%02d%EXT%"

echo.
echo ===== SELESAI =====
echo File hasil di folder yang sama.
pause