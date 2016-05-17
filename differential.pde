//http://www.softmath.com/tutorials-3/algebra-formulas/articles_imgs/8907/matrix59.jpg
String xexp="2x-xy";
String tempxexp=xexp;
String yexp="xy-2y";
String tempyexp=yexp;
String xstart="-0.5";
String xend="4.5";
String ystart="-0.5";
String yend="4.5";
int numofsteps=30;
float starttime=millis();
float time=0;
float xshift=0;
float yshift=0;
int typing=0;
boolean clicktype=false;
boolean paused=false;
int displaynum=0;
double dxstart,dxend,dxstep,xscale,dystart,dyend,dystep,yscale;
void setup(){
  size(850,700);
  background(250);
  frameRate(60);
  generateField();
}

void draw(){
  background(255);
  fill(0);
  textSize(12);
  if(paused){
    text("Paused",730,300);
    starttime=millis()-time*1000;
  }
  
  if (typing==1){fill(#f42121);} else{fill(0);}
  text("dx/dt= "+tempxexp,730,60);
  if (typing==2){fill(#f42121);} else{fill(0);}
  text("dy/dt= "+tempyexp,730,90);
  if (typing==3){fill(#f42121);} else{fill(0);}
  text("x start= "+xstart,730,150);
  if (typing==4){fill(#f42121);} else{fill(0);}
  text("x end= "+xend,730,170);
  if (typing==5){fill(#f42121);} else{fill(0);}
  text("y start= "+ystart,730,190);
  if (typing==6){fill(#f42121);} else{fill(0);}
  text("y end= "+yend,730,210);
  text("Speed= "+Particle.speed,730,350);
  time=(millis()-starttime)/1000;
  text(time+"s",730,400);
  
   //draw display particle
  if (Particle.allParticles.size()>displaynum){
      text("Particle Info:",730,470);
      text("Particle #"+(displaynum+1),730,490);
      text("Position: ("+String.format("%.1f",Particle.allParticles.get(displaynum).xpos)+","+String.format("%.1f",Particle.allParticles.get(displaynum).ypos)+")",730,550);
      text("Velocity Vector:",730,570);
      float[] temp=Particle.allParticles.get(displaynum).instantaneousVelocity(xexp,yexp);
      text(String.format("%.2f",temp[0])+"i + "+ String.format("%.2f",temp[1])+"j",730,590);
      text("Speed= "+String.format("%.4f",pow(temp[1]*temp[1]+temp[0]*temp[0],0.5)),730,610);
      //draw the selected particle
      
      //draw the displayedparticle
          fill(Particle.allParticles.get(displaynum).r,Particle.allParticles.get(displaynum).g,Particle.allParticles.get(displaynum).b);
         ellipse(740,520,10,10);
   }
   
  line(715,0,715,700);
  scale(1, -1);
  translate(0, -height);
  translate((float)(-1*dxstart*xscale),(float)(-1*dystart*yscale));
  line(0,(float)(dystart*yscale),0,(float)(dyend*yscale));
  line((float)(dxstart*xscale),0,(float)(dxend*xscale),0);
  drawField();  
  drawParticles();
  

}
public void generateField(){
  Field.wholeField.clear();
   dxstart=parse.interp(xstart);   dxend=parse.interp(xend);   dxstep=(dxend-dxstart)/numofsteps;  
   dystart=parse.interp(ystart);   dyend=parse.interp(yend);   dystep=(dyend-dystart)/numofsteps;
   yscale=(700/(dyend-dystart));   xscale=(700/(dxend-dxstart));
  for (double i=dxstart;i<=dxend+(dxstep/2);i+=dxstep){
     for (double j=dystart;j<=dyend+(dystep/2);j+=dystep){
          new Field((float)i,(float)j);
     }
  }
  Field.update(xexp,yexp);
  scaleField();
}
public void scaleField(){
  for (Field f:Field.wholeField){
     f.xpos*=xscale;
     f.ypos*=yscale;    
  } 
}
public void drawField(){
  stroke(#cc00ff);
    strokeWeight(1);
    for (Field f:Field.wholeField){
        if(f.vectorexists){
          drawArrow(f.xpos,
          f.ypos,f.angle,f.myvector);
        }
    }
    stroke(#000000);
}
public void drawParticles(){
   for(Particle p:Particle.allParticles){
      if(!paused){
      p.velocityUpdate(xexp,yexp);
      p.posUpdate();}
      fill(p.r,p.g,p.b); 
      stroke(p.r,p.g,p.b);
      for(int i=1;i<p.trail.size();i++){
         line((float)(p.trail.get(i-1).xpos*xscale),(float)(p.trail.get(i-1).ypos*yscale),(float)(p.trail.get(i).xpos*xscale),(float)(p.trail.get(i).ypos*yscale));
      }
      stroke(0,0,0);
      ellipse((float)(p.xpos*xscale),(float)(p.ypos*yscale),10,10);
   }
}
public void drawArrow(float x, float y,float angle, Vector v){
    float x2=v.xpos+x;
    float y2=v.ypos+y;
    line(x,y,x2,y2);
    line(x2,y2,x2+5*cos(angle-(5*PI/6)),y2+5*sin(angle-(5*PI/6)));
    line(x2,y2,x2+5*cos(angle+(5*PI/6)),y2+5*sin(angle+(5*PI/6)));          
}
public void shift(float x,float y){
   double xwidth=(dxend-dxstart);
   xend=Double.toString(dxend+xwidth*x);
   xstart=Double.toString(dxstart+xwidth*x);
   double ywidth=(dyend-dystart);
   yend=Double.toString(dyend+ywidth*y);
   ystart=Double.toString(dystart+ywidth*y);
   generateField();
}
public void zoom(float amt){
   xend=Double.toString(dxend*amt);
   xstart=Double.toString(dxstart*amt);
   yend=Double.toString(dyend*amt);
   ystart=Double.toString(dystart*amt);
   generateField();
}
void keyPressed(){
   if(keyCode==ENTER){
       if(clicktype){typing=0; clicktype=false;}
       else{
           if(typing==0){typing++; tempxexp=""; 
           } 
           else if(typing==1){
           tempyexp=""; typing++;}
           else if(typing==2){ 
              typing=0; yexp=tempyexp;  xexp=tempxexp; Particle.allParticles.clear(); generateField();}
           else if(typing==3){ 
              typing=4; xend="";}
           else if(typing==4){
              typing=0;generateField();
           }
           else if(typing==5){ 
              typing=6; yend="";}
           else if(typing==6){
              typing=0;generateField();
           }
       }
   }
   if(typing!=0 && (keyCode!=SHIFT && keyCode!=ENTER && keyCode!=BACKSPACE && keyCode!=DELETE)){
     if(typing==1){
           tempxexp=tempxexp+Character.toString(key);
     }
     else if(typing==2){
           tempyexp=tempyexp+Character.toString(key);
     }
     else if(typing==3){
           xstart=xstart+Character.toString(key);
     }
     else if(typing==4){
           xend=xend+Character.toString(key);
     }
     else if(typing==5){
           ystart=ystart+Character.toString(key);
     }
     else if(typing==6){
           yend=yend+Character.toString(key);
     }
   }
   if(key=='c'||key=='C'){
      Particle.allParticles.clear();  Particle.num=-1;
   }
   if(typing==0){
       if(key=='x' || key=='X'){
           typing=3; xstart="";
       }
       if(key=='y' || key=='Y'){
           typing=5; ystart="";
       }
   }
   if((keyCode==DELETE||keyCode==BACKSPACE)){
      if(typing==1 && xexp.length()>0){
      tempxexp=tempxexp.substring(0,tempxexp.length()-1);}
      if (typing ==2 && yexp.length()>0){
        tempyexp=tempyexp.substring(0,tempyexp.length()-1);
      }
      if(typing==3 && xstart.length()>0){xstart=xstart.substring(0,xstart.length()-1);
      }
      if(typing==4 && xend.length()>0){xend=xend.substring(0,xend.length()-1);
      }
      if(typing==5 && ystart.length()>0){ystart=ystart.substring(0,ystart.length()-1);
      }
      if(typing==6 && yend.length()>0){yend=yend.substring(0,yend.length()-1);
      }
   }
   if(typing==0){
      if(key=='p' || key=='P' || keyCode==BACKSPACE){
         if(paused){paused=false;} else{paused=true;}
      }
   }
   if(key=='n'||key=='N'){
      if(displaynum>=Particle.allParticles.size()-1){displaynum=0;}
     else{displaynum++;}
   }
   if(key=='['){Particle.speed-=0.05;}
   if(key==']'){Particle.speed+=0.05;}
   if(key=='r'||key=='R'){xstart="-5";xend="5";ystart="-5";yend="5"; displaynum=0; Particle.num=-1;
      Particle.allParticles.clear(); generateField(); starttime=millis(); }
   if(keyCode==LEFT){shift(-0.1,0);}if(keyCode==RIGHT){shift(0.1,0);}
   if(keyCode==UP){shift(0,0.1);}if(keyCode==DOWN){shift(0,-0.1);}
}
void mouseWheel(MouseEvent event){
  int e=event.getCount();
  if(e<0){  zoom(0.95);  }
  else{ zoom(1/0.95);}
}
void mouseClicked(){
   float xvar=mouseX;
   float yvar=700-mouseY;
   Particle p=new Particle(((dxend-dxstart)*xvar/700)+dxstart,((dyend-dystart)*yvar/700)+dystart); 
   displaynum=Particle.allParticles.indexOf(p);
}