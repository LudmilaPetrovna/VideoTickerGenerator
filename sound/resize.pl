

$file=$ARGV[0];
`ffmpeg -hide_banner -nostdin -i $file -f s16le -ar 44100 -ac 1 -y tmp.raw`;
$TT=(-s("tmp.raw"))/44100/2;

print STDERR "RATIO: $TT\n";

`rubberband -P --smoothing -F -T$TT $file tmp.wav`;

$raw=$file;
$raw=~s/wav$/raw/i;
`ffmpeg -hide_banner -nostdin -i tmp.wav -f s16le -ar 44100 -ac 1 -y $raw`;


unlink("tmp.raw");
unlink("tmp.wav");

