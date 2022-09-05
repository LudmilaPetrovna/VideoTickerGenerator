
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

#include <math.h>
#include <time.h>

#include "noise.h"

/*
#define FONTPATH "font/Spectrum/Syncwave Bubble.ch8"
#define WIDTH (2*8)
#define HEIGHT 16
#define FPS 60
#define TIME 600
*/

typedef struct{
double a,b,c,d,tx,ty;
} MAT2D;

typedef struct{
double x,y;
} P2D;

void print_mat(MAT2D *m){
printf("matrix %p:\n%f %f %f\n%f %f %f\n",m,m->a,m->b,m->tx,m->c,m->d,m->ty);
}
void print_pix(P2D *p){
printf("pixel %p:\n%fx%f\n",p,p->x,p->y);
}

void pix_mul_mat(P2D *pix,MAT2D *m){
double rx,ry;
rx=pix->x*m->a+pix->y*m->c+m->tx;
ry=pix->x*m->b+pix->y*m->d+m->ty;
pix->x=rx;
pix->y=ry;
}

void mat_cpy(MAT2D *to, MAT2D *from){
memcpy(to,from,sizeof(MAT2D));
}

void mat_inv(MAT2D *fow){
double dt=fow->a*fow->d-fow->b*fow->c;
MAT2D inv={fow->d/dt,-fow->b/dt,-fow->c/dt,fow->a/dt,(fow->c*fow->ty-fow->d*fow->tx)/dt,-(fow->a*fow->ty-fow->b*fow->tx)/dt};
memcpy(fow,&inv,sizeof(MAT2D));
}

void mat_rot(MAT2D *mat, double rot){
mat->a=cos(rot);
mat->b=sin(rot);
mat->c=-mat->b;
mat->d=mat->a;
mat->tx=0;
mat->ty=0;
}
void mat_scale(MAT2D *mat, double p){
mat->a*=p;
mat->b*=p;
mat->c*=p;
mat->d*=p;
}


char *FONTPATH;
int WIDTH,HEIGHT,FPS,TIME,COLOR,COUNTDOWN;


uint8_t *font;
uint8_t *pix;


void draw_pix(int x, int y, int col){
int op=x+y*WIDTH;
if(x<0 || y<0 || x>=WIDTH || y>=HEIGHT){return;}
pix[op]=col;
}
void draw_pix_add(int x, int y, int col){
int op=x+y*WIDTH;
if(x<0 || y<0 || x>=WIDTH || y>=HEIGHT){return;}
pix[op]+=col;
}

void draw_char(int x, int y, char ch, int col){
int q,w,fp,op,b;
for(w=0;w<8;w++){
fp=(ch-32)*8+w;
for(q=0;q<8;q++){
b=(font[fp]>>(7-q))&1;
if(b){
draw_pix(q+x,w+y,col);
}
}
}
}

void draw_string(int x, int y, char *str, int col){
int q,l=strlen(str);
int a,s;
for(q=0;q<l;q++){
for(a=-1;a<2;a++){
for(s=-1;s<2;s++){
draw_char(x+q*8+a,y+s,str[q],255-col);
}
}
}

for(q=0;q<l;q++){
draw_char(x+q*8,y,str[q],col);
}
}

void draw_string_mat(int x, int y, int col, char *str, MAT2D *mat){
int c,l=strlen(str),q,w,p,b;
MAT2D inv;
mat_cpy(&inv,mat);
mat_inv(&inv);

// calc inner box
P2D in[2]={{0,0},{l*8,8}};

// calc bounding box
P2D bb[2];
P2D corners[4]={
{in[0].x,in[0].y},
{in[0].x,in[1].y},
{in[1].x,in[0].y},
{in[1].x,in[1].y}
};
for(q=0;q<4;q++){
pix_mul_mat(&corners[q],mat);
if(q==0){
bb[0].x=bb[1].x=corners[q].x;
bb[0].y=bb[1].y=corners[q].y;
} else {
if(bb[0].x>corners[q].x){bb[0].x=corners[q].x;}
if(bb[1].x<corners[q].x){bb[1].x=corners[q].x;}
if(bb[0].y>corners[q].y){bb[0].y=corners[q].y;}
if(bb[1].y<corners[q].y){bb[1].y=corners[q].y;}
}
}
/*
bb[0].x=-200;
bb[0].y=-200;
bb[1].x=200;
bb[1].y=200;*/
//fprintf(stderr,"bb:\n,%fx%f  %fx%f\n",bb[0].x,bb[0].y,bb[1].x,bb[1].y);

// filling
P2D cp;
int bx,by;
int mw=bb[1].x-bb[0].x,mh=bb[1].y-bb[0].y;
//fprintf(stderr,"ff\n%dx%d\n",mw,mh);
for(w=0;w<mh;w++){
for(q=0;q<mw;q++){
cp.x=q+bb[0].x;
cp.y=w+bb[0].y;
pix_mul_mat(&cp,&inv);
bx=cp.x;
by=cp.y;
if(bx<0 || by<0 || bx>=in[1].x || by>=in[1].y){continue;}
c=bx/8;
c=0;
//fprintf(stderr,"writing char %c   %dx%d\n",str[c],bx,by);

b=(font[(str[c]-32)*8+by]>>(7-(bx%8)))&1;
if(b){
draw_pix(q+x+bb[0].x,w+y+bb[0].y,col);
draw_pix_add(q+x+bb[0].x,w+y+bb[0].y,col);
}
}
}
}


void time_split(int f, int *hour, int *minute, int *second, int *frame){

*hour=f/FPS/3600;
*minute=f/FPS/60-(*hour)*3600;
*second=(f/FPS)%60;
*frame=f%FPS;

}




int main(int argc, char **argv){

srand(time(0));
srand48(time(0));


if(argc!=8){
printf("Usage: %s filename.ch8 width height fps time in_color is_countdown\n",argv[0]);
exit(1);
}

FONTPATH=argv[1];
WIDTH=atoi(argv[2]);
HEIGHT=atoi(argv[3]);
FPS=atoi(argv[4]);
TIME=atoi(argv[5]);
COLOR=atoi(argv[6]);
COUNTDOWN=atoi(argv[7]);



font=malloc(768);
pix=malloc(WIDTH*HEIGHT*4);

FILE *ff=fopen(FONTPATH,"rb");
fread(font,1,768,ff);
fclose(ff);

int f,frames=TIME*FPS;
int hour,minute,second,frame;
int c;
MAT2D flake_mat={3,0,0,3,0,0};

char str[16];

typedef struct{
double x,y,size,opacity,rot,falling,rotdir;
}FLAKE;

FLAKE flakes[20];
int q;
for(q=0;q<20;q++){
flakes[q].x=drand48()*WIDTH;
flakes[q].y=drand48()*HEIGHT;
flakes[q].size=drand48()*5.0;
flakes[q].opacity=drand48()*128.0;
flakes[q].falling=drand48()*5.0;
flakes[q].rot=drand48()-.5;
flakes[q].rotdir=(drand48()-.5)/10.0;
}


for(f=0;f<frames;f++){

// draw frame
if(COLOR){
memset(pix,0x0,WIDTH*HEIGHT*4);
} else {
memset(pix,0xff,WIDTH*HEIGHT*4);
}

for(q=0;q<20;q++){
flakes[q].y+=flakes[q].falling;
if(flakes[q].opacity>0){
flakes[q].opacity--;
}
flakes[q].rot+=flakes[q].rotdir;
if(flakes[q].y>HEIGHT+8*flakes[q].size){
flakes[q].y=-100;
flakes[q].x=drand48()*WIDTH;
flakes[q].size=drand48()*5.0;
flakes[q].opacity=drand48()*128.0;
flakes[q].falling=drand48()*5.0;

}
mat_rot(&flake_mat,flakes[q].rot);
mat_scale(&flake_mat,flakes[q].size);
draw_string_mat(flakes[q].x,flakes[q].y,flakes[q].opacity,"*",&flake_mat);
}

for(q=0;q<10;q++){
}

time_split(COUNTDOWN?TIME*FPS-f-1:f,&hour,&minute,&second,&frame);

sprintf(str,"%.2d:%.2d:%.2d.%.2d",hour,minute,second,frame);
draw_string(WIDTH-(strlen(str))*8,8+0,str,COLOR?255:'@');
sprintf(str,"%.11d",f);
draw_string(WIDTH-(strlen(str))*8,8+8,str,COLOR?255:'@');

if(COLOR){
/*
for(c=0;c<HEIGHT/2;c++){
memset(pix+WIDTH*HEIGHT+WIDTH/2*c,(c*150+f)/20,WIDTH/2);
}
for(c=0;c<HEIGHT/2;c++){
memset(pix+WIDTH*HEIGHT+WIDTH/2*(HEIGHT/2+c),(c*50-f)/20,WIDTH/2);
}
*/
noise(pix+WIDTH*HEIGHT,WIDTH/2,HEIGHT,sin(f/20.0)*25.0,f,0);


fwrite(pix,1,WIDTH*HEIGHT*3/2,stdout);
} else {
fwrite(pix,1,WIDTH*HEIGHT,stdout);

}


}





return 0;
}
