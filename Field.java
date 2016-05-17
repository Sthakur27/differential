import java.util.*;
public class Field{
    boolean vectorexists=true;
    float xpos,ypos;
    float angle;
    Vector myvector=new Vector(0,0);
    static ArrayList<Field> wholeField=new ArrayList<Field>();
    Field(float x,float y){
        xpos=x;ypos=y;
        this.angle=(float)Vector.findAngle(myvector.xpos,-myvector.ypos);
        wholeField.add(this);
    }
    
    public static void update(String xexp, String yexp){
         //put a "*" in front of variables that don't have operand in front of them.
         xexp=parse.correctSyntax(xexp);
         yexp=parse.correctSyntax(yexp);
         //System.out.println("x="+xexp+"  y="+yexp);
         for(Field f:wholeField){
               String str=xexp.replaceAll("x","("+Double.toString(f.xpos)+")");
               str=str.replaceAll("y","("+Double.toString(f.ypos)+")");
               f.myvector.xpos=(float)parse.interp(str);
               str=yexp.replaceAll("x","("+Double.toString(f.xpos)+")");
               str=str.replaceAll("y","("+Double.toString(f.ypos)+")");
               f.myvector.ypos=(float)(parse.interp(str));
               if(f.myvector.xpos==0 && f.myvector.ypos==0){
                  f.vectorexists=false;
               }
               f.myvector.scaleVector(15);
               //System.out.println(f.myvector);
               f.angle=(float)Vector.findAngle(f.myvector.xpos,f.myvector.ypos);
               //System.out.println("x: "+f.xpos+"  y: "+f.ypos+"  "+ f.myvector);
         }
    }
    public String toString(){
       return(new String("x: "+this.xpos+"  y: "+this.ypos+"  "+ this.myvector));
    }
  
}