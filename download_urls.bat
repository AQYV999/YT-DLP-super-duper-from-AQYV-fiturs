@echo off
REM ============================================
REM  Download dari urls.txt - MP3 192 kbps
REM ============================================
REM  Cara pakai:
REM  1. Paste link video ke urls.txt (1 link per baris)
REM  2. Double-click file ini
REM ============================================

set "FOLDER=O:\Download\Youtube Dowloader"
set "ARCHIVE_FILE=archive_audio_192.txt"
set "COOKIES_FILE=cookies.txt"
set "URLS_FILE=urls.txt"

cd /d "%FOLDER%"

echo ============================================
echo  MODE: Download dari urls.txt - MP3 192 kbps
echo ============================================
echo.

if not exist "%URLS_FILE%" (
    echo ERROR: File "%URLS_FILE%" tidak ditemukan.
    pause
    exit /b
)

echo Mendownload audio (MP3 192 kbps)...
yt-dlp ^
  -f "ba/b" ^
  -x --audio-format mp3 --audio-quality 320K ^
  --download-archive "%ARCHIVE_FILE%" ^
  --extractor-args "youtube:player_client=android,web" ^
  --cookies "%COOKIES_FILE%" ^
  --ignore-errors ^
  -a "%URLS_FILE%" ^
  -o "%%(title)s.%%(ext)s"

echo.
echo ===== SELESAI =====
pause