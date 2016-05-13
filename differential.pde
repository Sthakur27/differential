String xexp="3x+2y";
String yexp="x-3y";
String xstart="-10";
String xend="10";
String ystart="-10";
String yend="10";
int numofsteps=10;
void setup(){
  size(950,700);
  background(250);
  frameRate(60);
  generateField();
  //println(Field.wholeField.size());
}

void draw(){
   background(255);
   translate(400,height/2);
   drawField();  
}
public void generateField(){
  Field.wholeField.clear();
  double dxstart=parse.interp(xstart);
  double dxend=parse.interp(xend);
  double dxstep=(dxend-dxstart)/numofsteps;
  double dystart=parse.interp(ystart);
  double dyend=parse.interp(yend);
  double dystep=(dyend-dystart)/numofsteps;
  //println(dxstart+"  "+dxend+"  "+dxstep);
  //println(dystart+"  "+dyend+"  "+dystep);
  for (double i=dxstart;i<=dxend+(dxstep/2);i+=dxstep){
     for (double j=dystart;j<=dyend+(dystep/2);j+=dystep){
          new Field((float)i,(float)j);
     }
  }
  Field.update(xexp,yexp);
}
public void drawField(){
    strokeWeight(1);
    Field.update(xexp,yexp);
    for (Field f:Field.wholeField){
        drawArrow(f.xpos*40,f.ypos*40,f.angle,f.myvector);
    }
}
public void drawArrow(float x, float y,float angle, Vector v){
    float x2=v.xpos+x;
    float y2=v.ypos+y;
    line(x,y, x2,y2);
    line(x2,y2,x2+5*cos(angle-(5*PI/6)),y2+5*sin(angle-(5*PI/6)));
    line(x2,y2,x2+5*cos(angle+(5*PI/6)),y2+5*sin(angle+(5*PI/6)));          
}