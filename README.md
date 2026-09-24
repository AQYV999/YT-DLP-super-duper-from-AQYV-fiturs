YT-DLP Super Duper Scripts
Kumpulan script siap pakai buat download audio/video dari YouTube pake yt-dlp.

Khusus buat yang males ngetik command panjang-panjang.
Fitur yang ada:

Download 20 video terbaru dari channel (jadi MP3)
Download 20 video terpopuler dari channel (jadi MP3)
Download dari daftar link di urls.txt
Mode khusus transcribe (audio kecil M4A 48kbps mono biar hemat)
Auto skip yang udah pernah didownload (pake archive)
Support cookies buat video age-restricted

Cara Pakai Cepat

Install dulu yang dibutuhkan:
yt-dlp
ffmpeg
Python (buat get_videos.py)

Edit file .bat yang mau dipakai, ganti:
FOLDER → folder tempat lo mau simpan hasil download
CHANNEL_URL → link channel YouTube yang mau di-download

Double-click file .bat yang sesuai:
download_terbaru.bat → ambil video terbaru
download_terpopuler.bat → ambil video terpopuler
download_urls.bat → download dari daftar di urls.txt
transcribe khusus transcribe.bat → versi hemat buat transcribe


Catatan

Taruh file cookies.txt di folder yang sama kalau mau download video yang dibatasi umur.
Semua script sudah pakai archive biar gak double download.



Scroll ke bawah, tulis commit message bebas (contoh: Add README), terus klik Commit new file.

Langkah 3: Isi About section
Masih di halaman repo:

Di sebelah kanan ada tulisan About → klik icon pensil (Edit)
Isi:
Description: Kumpulan script yt-dlp siap pakai: download terbaru, terpopuler, dari list URL, mode transcribe
Topics: ketik satu-satu lalu enter → yt-dlp youtube downloader batch python audio

Klik Save changes

Langkah 4: Selesai dulu
Setelah README + About selesai, repo lo udah kelihatan jauh lebih profesional.
Nanti bilang aja “udah” atau “lanjut”, gue kasih langkah berikutnya (cara ganti path biar gak hardcoded, atau cara sebar biar mulai ada yang liat).
Tinggal ikut, gak usah mikir. Mau mulai dari Langkah 1 sekarang?
