@echo off
REM ============================================
REM  Download 20 Video TERBARU dari Channel (MP3)
REM ============================================

set "FOLDER=%~dp0Download"
set "CHANNEL_URL=https://www.youtube.com/@NAMA_CHANNEL_MU/videos"
set "JUMLAH_LAGU=20"
set "ARCHIVE_FILE=archive_audio_192.txt"
set "TEMP_URLS=temp_urls.txt"
set "COOKIES_FILE=cookies.txt"

if not exist "%FOLDER%" mkdir "%FOLDER%"
cd /d "%FOLDER%"

echo ============================================
echo  MODE: 20 Video TERBARU - MP3
echo  Channel: %CHANNEL_URL%
echo ============================================
echo.

ping -n 1 www.youtube.com >nul 2>&1
if errorlevel 1 (
    echo ERROR: Tidak bisa akses YouTube. Cek koneksi.
    pause
    exit /b
)

if not exist "%COOKIES_FILE%" (
    echo PERHATIAN: cookies.txt tidak ditemukan.
    echo Video age-restricted mungkin gagal.
    timeout /t 3 >nul
)

python "%~dp0get_videos.py" latest "%CHANNEL_URL%" %JUMLAH_LAGU% > "%TEMP_URLS%"

for %%A in ("%TEMP_URLS%") do set "SIZE=%%~zA"
if "%SIZE%"=="0" (
    echo Tidak ada URL yang didapat.
    del "%TEMP_URLS%" 2>nul
    pause
    exit /b
)

echo.
echo Mendownload audio (MP3)...
yt-dlp ^
  -N 4 ^
  -f "ba/b" ^
  -x --audio-format mp3 --audio-quality 192K ^
  --download-archive "%ARCHIVE_FILE%" ^
  --extractor-args "youtube:player_client=android,web" ^
  --cookies "%COOKIES_FILE%" ^
  --ignore-errors ^
  -a "%TEMP_URLS%" ^
  -o "%%(title)s.%%(ext)s"

del "%TEMP_URLS%" 2>nul

echo.
echo ===== SELESAI (TERBARU) =====
pause
