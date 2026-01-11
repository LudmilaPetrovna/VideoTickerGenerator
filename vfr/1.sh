START=0
FPS=1
OFFSET=0

FONT="/usr/share/fonts/truetype/Fifaks10Dev1.ttf"
FONTOPTS="fontfile=$FONT:fontcolor=white:fontsize=48"

for i in {0..9}; do
  ffmpeg -y \
    -f lavfi -i color=c=black:s=640x360:d=1:r=$FPS \
    -vf "drawtext=$FONTOPTS:text='Frame\: %{eif\\:n+$START\\:d}':x=10:y=10,drawtext=$FONTOPTS:text='Time\: %{eif\\:(t+$OFFSET)\\:d}':x=10:y=40,drawtext=$FONTOPTS:text='FPS\: $FPS':x=10:y=70,scale=1920:1080" \
    -video_track_timescale 1000000 \
    -y seg_$i.mp4

  START=$((START + FPS))
  OFFSET=$((OFFSET + 1))
  FPS=$((FPS * 2))
done

printf "file '%s'\n" seg_*.mp4 > list.txt

ffmpeg -y -f concat -safe 0 -i list.txt -c copy vfr_test.mp4

#drawtext=text='Time\: %{eif\\:(t+$OFFSET)/3600\\:02d}:%{eif\\:((t+$OFFSET)/60)%60\\:02d}:%{eif\\:(t+$OFFSET)%60\\:06.3f}'
