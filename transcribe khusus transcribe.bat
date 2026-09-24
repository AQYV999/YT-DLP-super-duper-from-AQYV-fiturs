@echo off
REM ============================================
REM  Download Audio untuk TRANSCRIBE - dari urls.txt
REM  Format: M4A 48 kbps Mono (Hemat Bandwidth)
REM ============================================

set "FOLDER=O:\Download\Youtube Dowloader"
set "ARCHIVE_FILE=archive_transcribe.txt"
set "COOKIES_FILE=cookies.txt"
set "URLS_FILE=urls.txt"

cd /d "%FOLDER%"

echo ============================================
echo  MODE: TRANSCRIBE - M4A 48 kbps Mono
echo  Sumber: urls.txt
echo ============================================
echo.

if not exist "%URLS_FILE%" (
    echo ERROR: File "%URLS_FILE%" tidak ditemukan.
    pause
    exit /b
)

echo Mendownload audio (M4A 48 kbps Mono)...
yt-dlp ^
  -f "139" ^
  --extract-audio --audio-format m4a ^
  --postprocessor-args "-b:a 48k -ac 1" ^
  --retries 20 ^
  --fragment-retries 20 ^
  --retry-sleep 5 ^
  --continue ^
  --download-archive "%ARCHIVE_FILE%" ^
  --cookies "%COOKIES_FILE%" ^
  --ignore-errors ^
  -a "%URLS_FILE%" ^
  -o "%%(title)s.%%(ext)s"