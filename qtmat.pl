


open(dd,$ARGV[0]) or die $!;
binmode(dd);
read(dd,$file,-s(dd));
close(dd);

#mvhd
($offset,$size)=seekBox("mvhd");
printMatrix($offset+36,$size);
#writeMatrix($offset+36,2,0,0, 0,2,0, 0,0,16384);

($offset,$size)=seekBox("tkhd",$offset);
printMatrix($offset+40,$size);

$th=10/180*3.14159265358;
($si,$co)=(sin($th),cos($th));

writeMatrix($offset+40,2,0,0, 0,2,0, 0,0,1);
writeMatrix($offset+40,$co,$si,0, $si,$co,0, 20,30,1);


#writeMatrix($offset+40,2,0,0, 0,2,0, 0,0,16384, 128,64);
printMatrix($offset+40,$size);

open(dd,">out-".time().".mov") or die $!;
binmode(dd);
print dd $file;
close(dd);


sub seekBox{
my $box=shift;
my $offset=shift;
my $ind=index($file,$box,$offset);
if($ind<0){
return $ind;
}
my $data=$ind+4;
my $size=unpack("N",substr($file,$ind-4,4));
if($size==1){ #extended box
print STDERR "This is ENTENDED box\n";
$size=unpack("N",substr($file,$ind+8,4));
$data+=16;
$size-=16;
} else {
$size-=8;
}
return($data,$size);
}

sub writeMatrix{
my $offset=shift;
my $pos=0;
my $data=join("",map{pack("N",$_)}map{$pos++;$_*(1<<(($pos)%3==0?30:16))}@_);
my $len=length($data);
print STDERR "Writing at $offset $len bytes\n";
substr($file,$offset,$len)=$data;
}


sub printMatrix{
my($offset,$size)=@_;
my $pos=0;
my($mat_a,$mat_b,$mat_u,$mat_c,$mat_d,$mat_v,$mat_x,$mat_y,$mat_w,$width,$height)=map{$pos++;$_/(1<<(($pos)%3==0?30:16))}unpack("i>i>i>i>i>i>i>i>i>i>i>",substr($file,$offset,36+8)); #"
#my($acos,$asin)=map{$_/3.14159265358*180.0}(acos($mat_a),asin($mat_b));
print <<MAT
--==[Matrix]==-- at $offset:
a:$mat_a b:$mat_b u:$mat_u       ${acos}deg    ${asin}deg
c:$mat_c d:$mat_d v:$mat_v
x:$mat_x y:$mat_y w:$mat_w
width:$width height:$height (may be absent)
MAT

}


sub acos { atan2( sqrt(1 - $_[0] * $_[0]), $_[0] ) }
sub asin { atan2($_[0], sqrt(1 - $_[0] * $_[0])) }
