import java.util.*;
public class Particle{
    static ArrayList<Particle> allParticles=new ArrayList<Particle>();
    ArrayList<Vector> trail=new ArrayList<Vector>();
    float xpos,ypos;
    int num;
    Vector velocity=new Vector(0,0);
    Particle(double x, double y){
       this((float)x,(float)y);
    }
    Particle(float x,float y){
        xpos=x;ypos=y;
        allParticles.add(this);
        num=allParticles.indexOf(this);
    }
    public void velocityUpdate(String xexp,String yexp){
         String str=xexp.replaceAll("x","("+Double.toString(xpos)+")");
         str=str.replaceAll("y","("+Double.toString(ypos)+")");
         velocity.xpos=(float)(parse.interp(str)/90);
         str=yexp.replaceAll("x","("+Double.toString(xpos)+")");
         str=str.replaceAll("y","("+Double.toString(ypos)+")");
         velocity.ypos=(float)(parse.interp(str)/90);
    }
    public void posUpdate(){
        this.xpos+=velocity.xpos;
        this.ypos+=velocity.ypos;
        if(trail.size()<300){
        trail.add(new Vector(xpos,ypos));}
        else{ trail.remove(0); trail.add(new Vector(xpos,ypos));}
    }
    /*public void update(){
       if (this.xpos>Dimensions.width||this.xpos<0||this.ypos>Dimensions.height||this.ypos<0){
           removeList.add(this);
       }
    }*/
}