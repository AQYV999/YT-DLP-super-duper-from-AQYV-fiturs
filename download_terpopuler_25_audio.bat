@echo off
REM ============================================
REM  Download 25 Video TERPOPULER (Audio MP3)
REM ============================================
REM  Taruh file ini satu folder dengan:
REM    - yt-dlp.exe
REM    - get_videos.py
REM    - ffmpeg (di folder yang sama atau di PATH)
REM ============================================

set "CHANNEL_URL=https://www.youtube.com/@dc.production5896/videos"
set "JUMLAH=25"
set "KUALITAS=192K"
set "ARCHIVE_FILE=archive_audio_192.txt"
set "TEMP_URLS=temp_urls.txt"
set "COOKIES_FILE=cookies.txt"

REM --- Pindah ke folder tempat file .bat ini berada ---
cd /d "%~dp0"

echo ============================================
echo  MODE: %JUMLAH% Video TERPOPULER - Audio MP3 %KUALITAS%
echo  Channel: %CHANNEL_URL%
echo  (Scan metadata agak lama, sabar ya...)
echo ============================================
echo.

REM --- Cek koneksi internet ---
ping -n 1 www.youtube.com >nul 2>&1
if errorlevel 1 (
    echo ERROR: Tidak bisa akses YouTube. Cek koneksi / DNS.
    pause
    exit /b
)

REM --- Cek cookies (opsional) ---
set "COOKIES_OPT="
if exist "%COOKIES_FILE%" (
    set COOKIES_OPT=--cookies "%COOKIES_FILE%"
) else (
    echo PERHATIAN: "%COOKIES_FILE%" tidak ditemukan.
    echo Video age-restricted mungkin gagal diunduh.
    echo.
    timeout /t 3 >nul
)

REM --- Ambil daftar URL video terpopuler ---
python get_videos.py popular "%CHANNEL_URL%" %JUMLAH% > "%TEMP_URLS%"

REM --- Cek hasil kosong ---
for %%A in ("%TEMP_URLS%") do set "SIZE=%%~zA"
if "%SIZE%"=="0" (
    echo Tidak ada URL yang didapat.
    del "%TEMP_URLS%"
    pause
    exit /b
)

echo.
echo Mendownload audio (MP3 %KUALITAS%)...
yt-dlp ^
  -N 4 ^
  -f "ba/b" ^
  -x --audio-format mp3 --audio-quality %KUALITAS% ^
  --download-archive "%ARCHIVE_FILE%" ^
  --extractor-args "youtube:player_client=android,web" ^
  %COOKIES_OPT% ^
  --ignore-errors ^
  -a "%TEMP_URLS%" ^
  -o "%%(title)s.%%(ext)s"

del "%TEMP_URLS%"

echo.
echo ===== SELESAI (TERPOPULER - AUDIO MP3) =====
pause
