use GD;
use Data::Dumper;
use File::Slurp;

my $exam_file='vfr_test_sound.mp4';
#$exam_file='ultra_noise.mp4';

my $timeline_width=1900;
my $timeline_height=1;
my $preview_height=64;
my $track_height=$preview_height+15;
my $ruler_height=30;

if(!-s('ffprobe_plain.txt')){
write_file('ffprobe_plain.txt',`ffprobe "$exam_file" 2>&1`);
}
my $plain=read_file('ffprobe_plain.txt');

# find streams
my @streams=();
while($plain=~/(Stream #\d+:\d+[^\n]+)/gs){
push(@streams,$1);
}

$timeline_height=$track_height*@streams+$ruler_height;

$pic=GD::Image->new($timeline_width,$timeline_height,1);
$pic->alphaBlending(1);
$pic->saveAlpha(1);

# draw ruler
############$good_scales=[[.5],[1],[5],[10]];
$good_scale_interval=.5;

$ruler_offset_y=$track_height*@streams;
$ruler_scale=200;
$timecode_width=72;
$pic->filledRectangle(0,$ruler_offset_y,$timeline_width,$ruler_offset_y+$ruler_height-1,0xCCCCCC);
for($q=0;$q<$timeline_width;$q+=$good_scale_interval*$ruler_scale){
$ctime=$q/$ruler_scale;
$hours=int($ctime/3600);
$minutes=int($ctime/60)-$hours*60;
$seconds=int($ctime)-$hours*60*60-$minutes*60;
$mseconds=($ctime-int($ctime))*1000;
$timecode=sprintf("%02d:%02d:%02d.%03d",$hous,$minutes,$seconds,$mseconds);
$pic->line($q,$ruler_offset_y,$q,$ruler_offset_y+10,0);
$pic->string(gdSmallFont,$q,$ruler_offset_y+12,$timecode,0);
}

for($q=0;$q<$timeline_width;$q+=$good_scale_interval*$ruler_scale/10){
$pic->line($q,$ruler_offset_y,$q,$ruler_offset_y+5,0);
}

%tracks_colors=(audio=>0x007788,video=>0x009955,unknown=>0x990000);

for($s=0;$s<@streams;$s++){
$stream_name=$streams[$s];
$offset_y=$s*$track_height;
$type="unknown";
if($stream_name=~/: (Audio|Video): /){
$type=lc($1);
}
$pic->filledRectangle(0,$offset_y,$timeline_width,$offset_y+$track_height-2,$tracks_colors{$type});
$pic->string(gdSmallFont,0,$offset_y,$stream_name,0xFFFFFF);
$pic->line(0,$offset_y,$timeline_width,$offset_y,0x33FFFFFF);
$pic->line(0,$offset_y,0,$offset_y+$track_height-1,0x33FFFFFF);

$pic->line($timeline_width-1,$offset_y+$track_height-2,$timeline_width,$offset_y+$track_height-2,0x33000000);
$pic->line($timeline_width-1,$offset_y,$timeline_width-1,$offset_y+$track_height-2,0x33000000);

}

# draw packets
=pod
codec_type=video
stream_index=0
pts=9996095
pts_time=9.996095
dts=9994142
dts_time=9.994142
duration=1953
duration_time=0.001953
size=168
pos=668290
flags=___
=cut

if(!-s('ffprobe_packets.txt')){
write_file('ffprobe_packets.txt',`ffprobe -show_packets "$exam_file" 2>&1`);
}
my @packets=split(/\[PACKET\]/, scalar read_file('ffprobe_packets.txt'));
my %packet_offsets=();
foreach $pi(@packets){
%info=();
while($pi=~/\n([^=]+)=([^\n]+)/gs){
$info{lc($1)}=$2;
}
$info{keyframe}=substr($info{flags},0,1) eq "K"?1:0;

$packet_opacity=0x22-int($info{size}/1000);
if($packet_opacity<0){$packet_opacity=0;}
$packet_width=int($info{duration_time}*$ruler_scale-1);
if($packet_width<1){$packet_width=1;}

# PTS
$offset_y=$track_height*$info{stream_index}+12+16+2;
$offset_y2=$offset_y+16;
$offset_x=int($info{pts_time}*$ruler_scale);
$offset_x2=int($info{pts_time}*$ruler_scale+$packet_width)-1;
$pic->filledRectangle($offset_x,$offset_y,$offset_x2,$offset_y2,0x55FFFFFF);
$pic->rectangle($offset_x,$offset_y,$offset_x2,$offset_y2,0x22000000|($info{keyframe}?0xFF0000:0));
$arrow_x1=int(($offset_x+$offset_x2)/2);
$arrow_y1=int(($offset_y+$offset_y2)/2);

# DTS
$offset_y=$track_height*$info{stream_index}+12;
$offset_y2=$offset_y+16;
$offset_x=int($info{dts_time}*$ruler_scale);
$offset_x2=int($info{dts_time}*$ruler_scale+$packet_width)-1;
$pic->filledRectangle($offset_x,$offset_y,$offset_x2,$offset_y2,0x55FFFFFF);
$pic->rectangle($offset_x,$offset_y,$offset_x2,$offset_y2,0x22000000|($info{keyframe}?0xFF0000:0));
$arrow_x2=int(($offset_x+$offset_x2)/2);
$arrow_y2=int(($offset_y+$offset_y2)/2);

$packet_offsets{$info{pos}}=[$arrow_x2,$arrow_y2];


$pic->line($arrow_x1,$arrow_y1,$arrow_x2,$arrow_y2,0x00FF00);
}




# draw frames
=pod
[FRAME]
stream_index=0
key_frame=0
pts=9998048
pts_time=9.998048
duration=1953
duration_time=0.001953
pkt_pos=667665
pkt_size=348
pict_type=P
repeat_pict=0
[/FRAME]
=cut

if(!-s('ffprobe_frames.txt')){
write_file('ffprobe_frames.txt',`ffprobe -show_frames "$exam_file" 2>&1`);
}
my @frames=split(/\[FRAME\]/, scalar read_file('ffprobe_frames.txt'));
foreach $fi(@frames){
%info=();
while($fi=~/\n([^=]+)=([^\n]+)/gs){
$info{lc($1)}=$2;
}

$frame_dur=int($info{duration_time}*$ruler_scale-1);
if($frame_dur<1){$frame_dur=1;}

# PTS
$offset_y=$track_height*$info{stream_index}+12+16+2+16+2;
$offset_y2=$offset_y+20;
$offset_x=int($info{pts_time}*$ruler_scale);
$offset_x2=int($info{pts_time}*$ruler_scale+$frame_dur)-1;
$pic->filledRectangle($offset_x,$offset_y,$offset_x2,$offset_y2,0x55FFFFFF);
$pic->rectangle($offset_x,$offset_y,$offset_x2,$offset_y2,0x22000000|($info{key_frame}?0xFF0000:0));

$pic->string(gdTinyFont,$offset_x+1,$offset_y+2,$info{pict_type},0xFFFFFF);
$pic->string(gdTinyFont,$offset_x+1,$offset_y+10,$info{repeat_pict},0xFFFFFF);

$arrow_x1=int(($offset_x+$offset_x2)/2);
$arrow_y1=int(($offset_y+$offset_y2)/2);

$pic->line($arrow_x1,$arrow_y1,@{$packet_offsets{$info{pkt_pos}}},0x0055FF);

if($info{stream_index}==0){
$t=join("x",@{$packet_offsets{$info{pkt_pos}}});
print "pkt_pos $info{pkt_pos} - $t\n";
}

}







write_file("timeline.png",$pic->png(9));



