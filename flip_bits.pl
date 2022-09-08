


$filename=$ARGV[0];
$block=2000000;

open(dd,"+<".$filename);
binmode(dd);
seek(dd,-$block,2);
read(dd,$data,$block);

for($q=0;$q<100;$q++){
$p=rand()*rand()*rand()*rand()*$block;
$o=$block-1-$p;
substr($data,$o,1)=pack("C",unpack("C",substr($data,$o,1))^0x01);
}


seek(dd,-$block,2);
print dd $data;
close(dd);
