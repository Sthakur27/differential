import java.lang.Math;
public class Vector{
  float xpos,ypos,angle;
  static double forceDegree=0.5;
  Vector(float x,float y){
     xpos=x;ypos=y;
  }
  Vector(double x,double y){
     this((float)x,(float)y);
  }
  public void add(Vector v){
      this.xpos+=v.xpos;
      this.ypos+=v.ypos;
  }
  public void scaleVector(float scale){
     float len=(float)length();
     this.xpos*=scale/len;
     this.ypos*=scale/len;
  }
  public Vector unitVector(){
       double len=length();
       return (new Vector(xpos/len,ypos/len));
  }

  public double length(){
     return(Math.pow( (xpos*xpos)+(ypos*ypos),0.5));
   }
 
  public float speed(){
    return((float)Math.pow((this.xpos*this.xpos)+(this.ypos+this.ypos),0.5));
  }
  static public double findAngle(float x,float y){
     return (Math.atan2(y,x));
  }
  static public double findAngle(Field f){
      return(Vector.findAngle(f.myvector.xpos,f.myvector.ypos));
  }
  static public double findAngle(float x1,float y1,float x2,float y2){
      return(Math.atan2(y2-y1,x2-x1));
  }
  
  public String toString(){
      return("x: "+this.xpos+"   y: "+this.ypos);
  }
  public void reset(){
    this.xpos=0;this.ypos=0;
  }
}