from pytube import YouTube
from pathlib import Path
import ffmpeg
import sys
import os

output_folder="output"

def download_mp3(youtube_url):
    yt = YouTube(youtube_url)
    stream = yt.streams.get_by_itag(140)
    downloaded_m4a_full_path = Path(stream.default_filename)
    converted_mp3_full_path = Path(output_folder).joinpath(f"{downloaded_m4a_full_path.stem}.mp3")

    if converted_mp3_full_path.exists():
        print(f"'{converted_mp3_full_path.name}' already exists. Skipping...")
    else: 
        print(f"Downloading '{yt.title}'")
        Path(output_folder).mkdir(exist_ok=True)
        stream.download()
        (ffmpeg
            .input(str(downloaded_m4a_full_path))
            .output(str(converted_mp3_full_path))
            .run()
        )
        downloaded_m4a_full_path.unlink()

for line in sys.stdin:
    line = line.strip()
    if line:
        download_mp3(line)
