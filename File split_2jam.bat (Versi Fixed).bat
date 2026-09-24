@echo off
REM ============================================
REM  Auto Split - Drag & Drop File Audio
REM  Potong jadi 2 jam per bagian (RE-ENCODE)
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

echo ============================================
echo  Memproses: %INPUT%
echo  (Re-encode, tunggu 30 detik - 2 menit)
echo ============================================
echo.

ffmpeg -i "%INPUT%" ^
  -f segment ^
  -segment_time 7200 ^
  -c:a aac -b:a 48k -ac 1 ^
  -reset_timestamps 1 ^
  "%BASENAME%_part%%02d.m4a"

echo.
echo ===== SELESAI =====
dir "%BASENAME%_part*.m4a"
pause