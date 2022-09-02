

$file=$ARGV[0];
`ffmpeg -nostdin -i $file -f s16le -ar 44100 -ac 1 -y tmp.raw`;
$TT=(-s($ARGV[0]))/44100/2;

`rubberband -P --smoothing -F -T$TT $file tmp.wav`;

$raw=$file;
$raw=~s/wav$/raw/i;
`ffmpeg -nostdin -i tmp.wav -f s16le -ar 44100 -ac 1 -y $raw`;


unlink("tmp.raw");
unlink("tmp.wav");

