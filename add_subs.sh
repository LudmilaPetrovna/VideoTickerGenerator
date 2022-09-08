

-i subtitles-ara.srt
-i subtitles-deu.srt
-i subtitles-eng.srt
-i subtitles-fra.srt
-i subtitles-ita.srt
-i subtitles-por.srt
-i subtitles-rus.srt
-i subtitles-spa.srt
-i subtitles-srp.srt
-i subtitles-swa.srt



ffmpeg -i VIDEO.mp4 -i KOREAN.srt -i ENGLISH.srt \
  -c:v copy -c:a copy -c:s mov_text \
  -map 0:v -map 0:a -map 1 -map 2 \
  -metadata:s:s:0 language=kor -metadata:s:s:1 language=eng \