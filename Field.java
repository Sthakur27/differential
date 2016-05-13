import java.util.*;
public class Field{
    private static String type1="E0123456789.ep";
    private static String vars="xyzuv";
    float xpos,ypos;
    float angle;
    Vector myvector=new Vector(0,0);
    static ArrayList<Field> wholeField=new ArrayList<Field>();
    Field(float x,float y){
        xpos=x;ypos=y;
        this.angle=(float)Vector.findAngle(myvector.xpos,myvector.ypos);
        wholeField.add(this);
    }
    
    public static void update(String xexp, String yexp){
          String[] strings={xexp,yexp};
           //put a "*" in front of variables that don't have operand in front of them.
          for(int j=0;j<strings.length;j++){
             if(strings[j].length()>1){
               for(int i=1;i<strings[j].length();i++){
                  //if before var there is a var or a number add a '*'
                  if((vars.indexOf(strings[j].substring(i-1,i))!=-1 || type1.indexOf(strings[j].substring(i-1,i))!=-1) && vars.indexOf(strings[j].substring(i,i+1))!=-1){
                      strings[j]=strings[j].substring(0,i)+"*"+strings[j].substring(i);
                  }
               }    
             }
          }
         for(Field f:wholeField){
               String str=xexp.replaceAll("x","("+Double.toString(f.xpos)+")");
               str=str.replaceAll("y","("+Double.toString(f.ypos)+")");
               f.myvector.xpos=(float)parse.interp(str);
               str=yexp.replaceAll("x","("+Double.toString(f.xpos)+")");
               str=str.replaceAll("y","("+Double.toString(f.ypos)+")");
               f.myvector.ypos=(float)parse.interp(str);
               f.myvector.scaleVector(15);
               f.angle=(float)Vector.findAngle(f.myvector.xpos,f.myvector.ypos);
               //System.out.println("x: "+f.xpos+"  y: "+f.ypos+"  "+ f.myvector);
         }
    }
  
}