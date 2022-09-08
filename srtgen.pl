
$BOM="\xEF\xBB\xBF";

%langs=split(/\s+/,<<CODE);
English	eng
French	fra
Arabic	ara
Spanish	spa
Portuguese	por
German	deu
Russian	rus
Swahili	swa
Serbian	srp
Italian	ita
CODE



$len=$ARGV[0];
if($len<1){
die "Usage: $0 [time]\n";
}

foreach $lang(keys %langs){
$filename="subtitles-$langs{$lang}.srt";
open(dd,">$filename") or die $!;
print dd $BOM;

for($tt=0;$tt<$len;$tt++){
print dd "".($tt+1)."\r\n".getTimecode($tt)." --> ".getTimecode($tt+1)."\r\n$lang ".substr(getTimecode($tt),0,8)."\r\n\r\n";
}
close(dd);
}



sub getTimecode{
my $t=shift;
my $hour=int($t/3600);
my $min=int($t/60)%60;
my $sec=int($t)%60;
my $fra=$t-int($t);
return(sprintf("%.2d:%.2d:%.2d,%.3d",$hour,$min,$sec,$fra));
}