
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>


int noise(uint8_t *pix, int width, int height, int offset_x, int offset_y, double iTime){
int q,w,mi;
float m;
double uv_x;
double uv_y;

double o_x,o_y,o_z,o_w;
double t_x,t_y,t_z,t_w;
double x_x,x_y,x_z,x_w;

for(w=0;w<height;w++){
uv_y=(float)(height-w)/height-.5+(double)offset_y/100.0;
for(q=0;q<width;q++){
uv_x=(float)q/width-.5+(double)offset_x/100.0;


    float 
    t=iTime*.25,
    u=(int)t,
    v=t-u,
    qq=5.*u+t/80.0;
//qq=555.0;
//u=505.;

// procedural col  
o_x=uv_x*5.;
o_y=uv_y*5.;
o_z=5.;
o_w=5.;
for (int i=0; i<200;i++){
t_x=.7+.2*cos(qq);
t_y=.2+.2*sin(qq*1.9);
t_z=0;
t_w=0;

double dot=o_x*o_x+o_y*o_y+o_z*o_z+o_w*o_w;
//dot=5;
x_x=fabs(o_x/dot-t_x);
x_z=fabs(o_y/dot-t_y);
x_y=fabs(o_z/dot-t_z);
x_w=fabs(o_w/dot-t_w);

o_x=x_x;
o_y=x_y;
o_z=x_z;
o_w=x_w;
}


o_x=-o_x+1;
o_y=-o_y+1;
o_z=-o_z+1;
o_w=-o_w+1;


o_x=pow(o_x,2);
o_y=pow(o_y,4);
o_z=pow(o_z,3);
o_w=pow(o_w,1);



/*    
    o*=pow(v,.3);
    //output  v       
    o=(S <.0)? o-o : S*o-o+1.;
    o=pow(o,vec4(2,4,3,1));

*/

#define to_rgb(a,b) b=(a*256.0);if(b<0){b=0;}if(b>255){b=255;}

int or,og,ob;

to_rgb(o_x,or);
//to_rgb(o_y,og);
//to_rgb(o_z,ob);
//pix[q+w*WIDTH]=ob|(og<<8)|(or<<16)|(0xff<<24);
pix[q+w*width]=or;

}
}

//fwrite(pix,1,PIXSIZE*4,stdout);

return 0;
}




