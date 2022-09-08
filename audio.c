
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <math.h>
#include <time.h>

int main(int argc, char **argv){

int samplerate=32000;
int dur=600;

if(argc!=5){
printf("Usage: %s [language] [samplerate] [duration in seconds] [is_countdown?1:0]\n",argv[0]);
exit(1);
}

char *lang=argv[1];
samplerate=atoi(argv[2]);
dur=atoi(argv[3]);
int countdown=atoi(argv[4]);

double freqmul;
double amp;

int16_t *buf=malloc(samplerate*2);
int16_t *voice=malloc(44100*2);
int q,e;

srand48(time(0));

char filename[256];
int sample;
for(q=0;q<dur;q++){
if(countdown){
sprintf(filename,"sound/%s/%d.raw",lang,(60-(q%60)));
} else {
sprintf(filename,"sound/%s/%d.raw",lang,(q%60)+1);
}

FILE *v=fopen(filename,"rb");
memset(voice,0,44100*2);
fread(voice,1,44100*2,v);
fclose(v);

freqmul=2.0+drand48()*64.0;
for(e=0;e<samplerate;e++){
amp=(((double)samplerate-e)*30000.0/(double)samplerate);
//amp=32767.0;
sample=(double)sin((double)e/freqmul)*amp;
sample+=voice[(uint64_t)e*44100/samplerate];
if(sample>32767){sample=32767;}
if(sample<-32768){sample=-32768;}

buf[e]=(int16_t)sample;
}
fwrite(buf,1,samplerate*2,stdout);

}

return 0;
}
