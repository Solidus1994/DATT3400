import processing.sound.*;

AudioIn mic;
Amplitude amp;

int num = 500;
float mts = PI/200;
float r;
int rdtr = 100;
int rdu = 3;

PVector v[] = new PVector[num];
boolean mv = true;
boolean mo = true;
color c[] = new color[num];
float theta[] = new float[num];
float mtheta[] = new float[num];
float dtheta[] = new float[num];
float easing[] = new float[num];
int rdt[] = new int[num];

void setup(){
colorMode(RGB,255,255,255);
size(1080,720);
for(int i = 0;i<num-1;i++){
  c[i] = color(random(0,255), random(0,255), random(0,255));
  v[i] = new PVector(random(width),random(height));
  theta[i] = round(random(360));
  dtheta[i] = random(mts);
  mtheta[i] = theta[i]/180*PI;
  rdt[i] = round(random(-rdtr,rdtr));
  easing[i] = random(0.02,1);
 }
 frameRate(60);
 
mic = new AudioIn(this);
  mic.start();
  amp = new Amplitude(this);
  amp.input(mic);
}

void draw(){
  r = map(amp.analyze(),0,0.1,100,width);
  fill(0,0,0,25);
  rect(0,0,width,height);
  pushMatrix();
  noStroke();
  if(mv){
    if(mo){
      for(int i = 0; i<num-1; i++){
        mtheta[i] += dtheta[i];
        v[i].lerp(mouseX+cos(mtheta[i])*(rdt[i]+r),mouseY+sin(mtheta[i])*(rdt[i]+r),0,easing[i]);
        fill(c[i]);
        ellipse(v[i].x,v[i].y,rdu,rdu);
      }
    }
   if(!mo){
     for(int i = 0; i<num-1; i++){
        v[i].lerp(mouseX+cos(mtheta[i])*(rdt[i]+r),mouseY+sin(mtheta[i])*(rdt[i]+r),0,easing[i]);
        fill(c[i]);
        ellipse(v[i].x,v[i].y,rdu,rdu);
    }
  }
}
  if(!mv){
    if(mo){
      for(int i = 0; i<num-1;i++){
        mtheta[i] += dtheta[i];
        v[i].lerp(mouseX+sin(mtheta[i])*rdt[i],mouseY+cos(mtheta[i])*rdt[i],0,easing[i]);
        fill(c[i]);
        ellipse(v[i].x,v[i].y,rdu,rdu);
      }
    }
  if(!mo){
      for(int i = 0; i<num-1;i++){
        v[i].lerp(mouseX+sin(mtheta[i])*rdt[i],mouseY+cos(mtheta[i])*rdt[i],0,easing[i]);
        fill(c[i]);
        ellipse(v[i].x,v[i].y,rdu,rdu);
      }
    }
  }
  
  popMatrix();
  fill(0);
  rect(0,0,width,15);
  fill(255);
  
}

void mousePressed(){
mv=!mv;
}

void keyPressed(){
if(key == 's'||key =='S'){
   mo=!mo;
  } 
 if(key == 'w'||key =='W'){
   
 }
}
