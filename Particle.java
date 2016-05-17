import java.util.*;
public class Particle{
    static float speed=1;
    static ArrayList<Particle> allParticles=new ArrayList<Particle>();
    ArrayList<Vector> trail=new ArrayList<Vector>();
    float xpos,ypos;
    static int num=-1;
    int r,g,b;
    static int[] redcolorlist={255,0,0,255,255};
    static int[] greencolorlist={0,255,0,153,0};
    static int[] bluecolorlist={0,0,255,0,255};
    Vector velocity=new Vector(0,0);
    Particle(double x, double y){
       this((float)x,(float)y);
    }
    Particle(float x,float y){
        xpos=x;ypos=y;
        num++;
        if(num>4){
          num=0;
        }
        if(allParticles.size()<5){
          allParticles.add(this);
        }
        else{
          allParticles.set(num,this);
        }
        this.r=redcolorlist[num];
        this.g=greencolorlist[num];
        this.b=bluecolorlist[num];
    }
    public void velocityUpdate(String xexp,String yexp){
         xexp=parse.correctSyntax(xexp);
         yexp=parse.correctSyntax(yexp);
         String str=xexp.replaceAll("x","("+Double.toString(xpos)+")");
         str=str.replaceAll("y","("+Double.toString(ypos)+")");
         velocity.xpos=(float)(parse.interp(str)*speed/270);
         str=yexp.replaceAll("x","("+Double.toString(xpos)+")");
         str=str.replaceAll("y","("+Double.toString(ypos)+")");
         velocity.ypos=(float)(parse.interp(str)*speed/270);
         //overcompensation measure for not being instantaneous
         xexp=parse.correctSyntax(xexp);
         yexp=parse.correctSyntax(yexp);
         str=xexp.replaceAll("x","("+Double.toString(xpos+velocity.xpos)+")");
         str=str.replaceAll("y","("+Double.toString(ypos+velocity.ypos)+")");
         velocity.xpos+=(float)(parse.interp(str)*speed/30);
         str=yexp.replaceAll("x","("+Double.toString(xpos+velocity.xpos)+")");
         str=str.replaceAll("y","("+Double.toString(ypos+velocity.ypos)+")");
         velocity.ypos+=(float)(parse.interp(str)*speed/30);
    }
    public void posUpdate(){
        this.xpos+=velocity.xpos;
        this.ypos+=velocity.ypos;
        if(trail.size()<500){
        trail.add(new Vector(xpos,ypos));}
        else{ trail.remove(0); trail.add(new Vector(xpos,ypos));}
    }
    /*public void update(){
       if (this.xpos>Dimensions.width||this.xpos<0||this.ypos>Dimensions.height||this.ypos<0){
           removeList.add(this);
       }
    }*/
}