
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <math.h>
#include <time.h>

int main(int argc, char **argv){

int samplerate=48000;
int dur=600;

if(argc!=3){
printf("Usage: %s [samplerate] [duration in seconds]\n",argv[0]);
exit(1);
}

samplerate=atoi(argv[1]);
dur=atoi(argv[2]);

double freqmul;
double amp;

int16_t *buf=malloc(samplerate*2);
int q,e;

srand48(time(0));

for(q=0;q<dur;q++){
freqmul=2.0+drand48()*64.0;
for(e=0;e<samplerate;e++){
amp=(((double)samplerate-e)*32767.0/(double)samplerate);
//amp=32767.0;
buf[e]=(int16_t)((double)sin((double)e/freqmul)*amp);
}
fwrite(buf,1,samplerate*2,stdout);

}

return 0;
}
