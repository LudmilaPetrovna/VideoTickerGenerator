#gcc video.c && ./a.out font/Spectrum/Carton.ch8 128 64 15 300 0 | ffmpeg -f rawvideo -r 15 -pix_fmt gray -s 128x64 -i - -y gray.gif
#gcc video.c && ./a.out font/Spectrum/Carton.ch8 32 32 15 300 0 | ffmpeg -f rawvideo -r 15 -pix_fmt gray -s 32x32 -i - -y gray-32.gif
#gcc video.c && ./a.out font/Spectrum/Carton.ch8 16 16 30 300 0 | ffmpeg -f rawvideo -r 30 -pix_fmt gray -s 16x16 -i - -y gray-16.gif
#gcc video.c && ./a.out font/Spectrum/Carton.ch8 128 16 60 600 1 | ffmpeg -f rawvideo -r 60 -pix_fmt yuv420p -s 128x16 -i - -vcodec libx264 -qmin 0 -qmax 0 -y ticker-h264-128x60.60.mp4
#gcc video.c && ./a.out font/Spectrum/Carton.ch8 128 16 60 600 1 | ffmpeg -f rawvideo -r 60 -pix_fmt yuv420p -s 128x16 -i - -vcodec libx264 -qmin 0 -qmax 0 -x264opts keyint=1:min-keyint=1 -y ticker-h264-128x60.60-all-keys.mp4
#gcc video.c && ./a.out font/Spectrum/Carton.ch8 128 16 60 600 1 | ffmpeg -f rawvideo -r 60 -pix_fmt yuv420p -s 128x16 -i - -vcodec libx264 -qmin 0 -qmax 0 -b_strategy 2 -bf 80 -x264opts min-keyint=3600 -y ticker-h264-128x60.60-key-per-minute.mp4
#gcc video.c && ./a.out font/Spectrum/Carton.ch8 128 16 60 600 1 | ffmpeg -f rawvideo -r 60 -pix_fmt yuv420p -s 128x16 -i - -vcodec libx265 -qmin 0 -qmax 0 -b_strategy 2 -bf 80 -y ticker-h265-128x60.60.mp4
gcc audio.c -lm -O3 && ./a.out 96000 60 | ffmpeg -f s16le -ar 96000 -ac 1 -i - -ab 192000 -y sound-96000.wav
gcc audio.c -lm -O3 && ./a.out 96000 60 | ffmpeg -f s16le -ar 96000 -ac 1 -i - -ab 192000 -y sound-96000.m4a
#gcc audio.c -lm -O3 && ./a.out 32000 60 | ffmpeg -f s16le -ar 16000 -ac 1 -i - -y sound-g32-16000.m4a
#gcc audio.c -lm -O3 && ./a.out 16000 60 | ffmpeg -f s16le -ar 16000 -ac 1 -i - -ab 19000 -y sound-16000.m4a
#gcc audio.c -lm -O3 && ./a.out 8000 60 | ffmpeg -f s16le -ar 8000 -ac 1 -i - -y sound-8000.m4a
#gifsicle -O99 -o gray-16-optimized.gif gray-16.gif
#gifsicle -O99 -o gray-32-optimized.gif gray-32.gif
#gifsicle -O99 -o gray-optimized.gif gray.gif
