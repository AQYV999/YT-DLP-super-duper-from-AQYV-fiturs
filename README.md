# YT-DLP Super Duper Scripts

Kumpulan script siap pakai buat download audio/video dari YouTube pake **yt-dlp**.  
Khusus buat yang males ngetik command panjang-panjang.

## Fitur

- Download **20 video terbaru** dari channel (jadi MP3)
- Download **20 video terpopuler** dari channel (jadi MP3)
- Download dari daftar link di `urls.txt`
- Mode khusus **transcribe** (audio kecil M4A 48kbps mono biar hemat)
- Auto skip yang sudah pernah didownload (pakai archive)
- Support cookies untuk video age-restricted

## Cara Pakai

### 1. Install dulu
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- [ffmpeg](https://ffmpeg.org/)
- Python (untuk `get_videos.py`)

### 2. Setting script
Edit file `.bat` yang mau dipakai, ganti:
- `FOLDER` → folder tempat kamu mau simpan hasil download
- `CHANNEL_URL` → link channel YouTube yang mau di-download

### 3. Jalankan
Double-click file yang sesuai:

| File | Fungsi |
|------|--------|
| `download_terbaru.bat` | Ambil video terbaru |
| `download_terpopuler.bat` | Ambil video terpopuler |
| `download_urls.bat` | Download dari daftar di `urls.txt` |
| `transcribe khusus transcribe.bat` | Versi hemat buat transcribe |

## Catatan
- Taruh file `cookies.txt` di folder yang sama kalau mau download video yang dibatasi umur.
- Semua script sudah pakai archive biar gak double download.
