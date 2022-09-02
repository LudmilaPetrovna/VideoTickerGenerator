
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

/*
#define FONTPATH "font/Spectrum/Syncwave Bubble.ch8"
#define WIDTH (2*8)
#define HEIGHT 16
#define FPS 60
#define TIME 600
*/

char *FONTPATH;
int WIDTH,HEIGHT,FPS,TIME,COLOR;

uint8_t *font;
uint8_t *pix;


void draw_char(int x, int y, char ch){
int q,w,fp,op;
for(w=0;w<8;w++){
fp=(ch-32)*8+w;
for(q=0;q<8;q++){
op=(q+x)+(w+y)*WIDTH;
if(q+x<0 || w+y<0 || q+x>=WIDTH || w+y>=HEIGHT){continue;}
if(COLOR){
pix[op]=(font[fp]>>(7-q))&1?255:0;
} else {
pix[op]=(font[fp]>>(7-q))&1?'@':0xff;
}
}
}
}

void draw_string(int x, int y, char *str){
int q,l=strlen(str);
for(q=0;q<l;q++){
draw_char(x+q*8,y,str[q]);
}
}


int main(int argc, char **argv){

if(argc!=7){
printf("Usage: %s filename.ch8 width height fps time in_color\n",argv[0]);
exit(1);
}

FONTPATH=argv[1];
WIDTH=atoi(argv[2]);
HEIGHT=atoi(argv[3]);
FPS=atoi(argv[4]);
TIME=atoi(argv[5]);
COLOR=atoi(argv[6]);

font=malloc(768);
pix=malloc(WIDTH*HEIGHT*4);

FILE *ff=fopen(FONTPATH,"rb");
fread(font,1,768,ff);
fclose(ff);

int f,frames=TIME*FPS;
int hour,minute,second,frame;
int c;

char str[16];
for(f=0;f<frames;f++){

hour=f/FPS/3600;
minute=f/FPS/60-hour*3600;
second=(f/FPS)%60;
frame=f%FPS;

memset(pix,0,WIDTH*HEIGHT*4);

sprintf(str,"%.2d:%.2d:%.2d.%.3d",hour,minute,second,frame);
draw_string(WIDTH-12*8,0,str);
sprintf(str,"%.12d",f%100);
draw_string(WIDTH-12*8,8,str);

if(COLOR){
for(c=0;c<HEIGHT/2;c++){
memset(pix+WIDTH*HEIGHT+WIDTH/2*c,(c*150+f)/20,WIDTH/2);
}
for(c=0;c<HEIGHT/2;c++){
memset(pix+WIDTH*HEIGHT+WIDTH/2*(HEIGHT/2+c),(c*50-f)/20,WIDTH/2);
}

fwrite(pix,1,WIDTH*HEIGHT*3/2,stdout);
} else {
fwrite(pix,1,WIDTH*HEIGHT,stdout);

}


}





return 0;
}
