import subprocess
import json
import sys
import time

def log(*args, **kwargs):
    """Cetak ke stderr supaya tidak ikut ke file URL."""
    print(*args, file=sys.stderr, **kwargs)

def run_ytdlp(command, timeout=None):
    try:
        result = subprocess.run(
            command, capture_output=True, text=True, check=True, timeout=timeout
        )
        return result.stdout
    except subprocess.CalledProcessError as e:
        log(f"Error saat menjalankan yt-dlp: {e}")
        if e.stderr:
            log(e.stderr)
        return ""
    except subprocess.TimeoutExpired:
        log("Timeout: yt-dlp terlalu lama, dilewati.")
        return ""

def parse_json_lines(output):
    videos = []
    for line in output.strip().split('\n'):
        if not line:
            continue
        try:
            v = json.loads(line)
        except json.JSONDecodeError:
            continue
        url = v.get('url') or v.get('webpage_url')
        if url:
            videos.append({
                'url': url,
                'title': v.get('title', 'N/A'),
                'view_count': v.get('view_count') or 0
            })
    return videos

def get_latest_videos(channel_url, top_n=25):
    """N video TERBARU -- pakai halaman /videos biasa."""
    log(f"Mengambil {top_n} video TERBARU dari: {channel_url} ...")

    command = [
        'yt-dlp', '--flat-playlist', '--dump-json',
        '--playlist-end', str(top_n), channel_url
    ]
    start = time.time()
    output = run_ytdlp(command, timeout=120)
    videos = parse_json_lines(output)
    log(f"Selesai dalam {time.time()-start:.1f} detik. Dapat {len(videos)} video.")

    log(f"\n--- {len(videos)} Video Terbaru ---")
    for i, v in enumerate(videos, 1):
        log(f"{i}. {v['title']}")

    return [v['url'] for v in videos]

def get_popular_videos(channel_url, top_n=25, max_check=100):
    """
    N video TERPOPULER.
    Menggunakan metode client-side sorting (mengambil metadata lalu diurutkan).
    Parameter max_check membatasi berapa banyak video yang diperiksa
    untuk mempercepat proses.
    """
    log(f"Mengambil {top_n} video TERPOPULER dari: {channel_url} ...")
    log(f"Akan memeriksa metadata {max_check} video pertama untuk mencari yang terpopuler.")

    command = [
        'yt-dlp', '--dump-json',
        '--playlist-end', str(max_check),
        channel_url
    ]
    start = time.time()
    output = run_ytdlp(command, timeout=1800)
    videos = parse_json_lines(output)
    elapsed = time.time() - start
    log(f"Selesai dalam {elapsed:.1f} detik. Dapat {len(videos)} video dengan view_count.")

    if not videos:
        log("Tidak ada video ditemukan.")
        return []

    videos.sort(key=lambda x: x['view_count'], reverse=True)
    top = videos[:top_n]

    log(f"\n--- Top {len(top)} Video Terpopuler ---")
    for i, v in enumerate(top, 1):
        log(f"{i}. [{v['view_count']:,} views] {v['title']}")

    return [v['url'] for v in top]

if __name__ == "__main__":
    if len(sys.argv) < 3:
        log("Gunakan: python get_videos.py <latest|popular> <CHANNEL_URL> [JUMLAH]")
        sys.exit(1)

    mode = sys.argv[1].lower()
    channel_url = sys.argv[2]
    jumlah = int(sys.argv[3]) if len(sys.argv) > 3 else 25

    if mode == "latest":
        urls = get_latest_videos(channel_url, jumlah)
    elif mode == "popular":
        # Anda bisa mengubah angka 100 di bawah ini untuk mengubah seberapa banyak
        # video yang diperiksa. Semakin kecil angkanya, semakin cepat prosesnya,
        # tetapi mungkin ada video populer lama yang terlewat.
        urls = get_popular_videos(channel_url, jumlah, max_check=100)
    else:
        log(f"Mode tidak dikenal: {mode}")
        sys.exit(1)

    for url in urls:
        print(url)