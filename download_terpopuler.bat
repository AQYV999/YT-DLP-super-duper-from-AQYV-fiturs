@echo off
REM ============================================
REM  Download 20 Video TERPOPULER dari Channel (MP3 192)
REM ============================================

set "FOLDER=O:\Download\Youtube Dowloader"
set "CHANNEL_URL=https://www.youtube.com/@dc.production5896/videos"
set "JUMLAH_LAGU=20"
set "ARCHIVE_FILE=archive_audio_192.txt"
set "TEMP_URLS=temp_urls.txt"
set "COOKIES_FILE=cookies.txt"

cd /d "%FOLDER%"

echo ============================================
echo  MODE: 20 Video TERPOPULER - MP3 192 kbps
echo  Channel: %CHANNEL_URL%
echo  (Proses scan metadata lebih lama, sabar ya...)
echo ============================================
echo.

REM --- Cek koneksi internet ---
ping -n 1 www.youtube.com >nul 2>&1
if errorlevel 1 (
    echo ERROR: Tidak bisa akses YouTube. Cek koneksi / DNS.
    pause
    exit /b
)

REM --- Cek file cookies ---
if not exist "%COOKIES_FILE%" (
    echo PERHATIAN: File "%COOKIES_FILE%" tidak ditemukan.
    echo Video age-restricted mungkin gagal diunduh.
    echo.
    timeout /t 5 >nul
)

python get_videos.py popular "%CHANNEL_URL%" %JUMLAH_LAGU% > "%TEMP_URLS%"

REM --- Cek file kosong ---
for %%A in ("%TEMP_URLS%") do set "SIZE=%%~zA"
if "%SIZE%"=="0" (
    echo Tidak ada URL yang didapat.
    del "%TEMP_URLS%"
    pause
    exit /b
)

echo.
echo Mendownload audio (MP3 192 kbps)...
yt-dlp ^
  -N 4 ^
  -f "ba/b" ^
  -x --audio-format mp3 --audio-quality 320K ^
  --download-archive "%ARCHIVE_FILE%" ^
  --extractor-args "youtube:player_client=android,web" ^
  --cookies "%COOKIES_FILE%" ^
  --ignore-errors ^
  -a "%TEMP_URLS%" ^
  -o "%%(title)s.%%(ext)s"

del "%TEMP_URLS%"

echo.
echo ===== SELESAI (TERPOPULER - MP3 192) =====
pause