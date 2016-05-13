String xexp="3*x-x*y";
String tempxexp=xexp;
String yexp="x*y-3*y";
String tempyexp=yexp;
String xstart="-1";
String xend="5";
String ystart="-1";
String yend="5";
int numofsteps=30;
float xshift=0;
float yshift=0;
int typing=0;
boolean clicktype=false;
boolean paused=false;
double dxstart,dxend,dxstep,xscale,dystart,dyend,dystep,yscale;
void setup(){
  size(950,700);
  background(250);
  frameRate(60);
  generateField();
  //scale(1, -1);
  //translate(0, -height);
  //println(Field.wholeField.get(0));
}

void draw(){
  background(255);
  fill(0);
  textSize(12);
  if(paused){
    text("Paused",830,300);
  }
  if (typing==1){fill(#f42121);} else{fill(0);}
  text("dx/dt= "+tempxexp,830,60);
  if (typing==2){fill(#f42121);} else{fill(0);}
  text("dy/dt= "+tempyexp,830,90);
  if (typing==3){fill(#f42121);} else{fill(0);}
  text("x start= "+xstart,830,150);
  if (typing==4){fill(#f42121);} else{fill(0);}
  text("x end= "+xend,830,170);
  if (typing==5){fill(#f42121);} else{fill(0);}
  text("y start= "+ystart,830,190);
  if (typing==6){fill(#f42121);} else{fill(0);}
  text("y end= "+yend,830,210);
  line(815,0,815,700);
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
   dxstart=parse.interp(xstart);
   dxend=parse.interp(xend);
   dxstep=(dxend-dxstart)/numofsteps;
   dystart=parse.interp(ystart);
   dyend=parse.interp(yend);
   dystep=(dyend-dystart)/numofsteps;
   yscale=(700/(dyend-dystart));
   xscale=(800/(dxend-dxstart));
  for (double i=dxstart;i<=dxend+(dxstep/2);i+=dxstep){
     for (double j=dystart;j<=dyend+(dystep/2);j+=dystep){
          new Field((float)i,(float)j);
     }
  }
 // new Field(3,5);
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
  stroke(#147efb);
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
      fill(#ff0000);      
      for(int i=1;i<p.trail.size();i++){
         line((float)(p.trail.get(i-1).xpos*xscale),(float)(p.trail.get(i-1).ypos*yscale),(float)(p.trail.get(i).xpos*xscale),(float)(p.trail.get(i).ypos*yscale));
      }
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
void keyPressed(){
   if(keyCode==ENTER){
       if(clicktype){typing=0; clicktype=false;}
       else{
           if(typing==0){typing++; tempxexp=""; 
           } 
           else if(typing==1){
           tempyexp=""; typing++;}
           else if(typing==2){ 
              typing=0; yexp=tempyexp;  xexp=tempxexp; generateField();}
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
      Particle.allParticles.clear();
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
      if(key=='p' || key=='P'){
         if(paused){paused=false;} else{paused=true;}
      }
   }
}
void mouseClicked(){
   float xvar=mouseX;
   float yvar=700-mouseY;
   new Particle(((dxend-dxstart)*xvar/800)+dxstart,((dyend-dystart)*yvar/700)+dystart);  
   //System.out.println(((dxend-dxstart)*xvar/800)+dxstart);
   //System.out.println(((dyend-dystart)*yvar/700)+dystart);
}