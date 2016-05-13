import java.lang.Math;
import java.util.*;
public class pObj{
    double num=0;
    int priority;
    int opernum=0;  //1 +  2 -   3 * 4 /  5 ^  6 sin 7 cos 8 tan 9 log 10 sinh 11 cosh
    String oper="";
    int mode=0;  //0:numbers  1: operators(+,-)  2: paranthesis   3: scientific operator(sin cos)
    
    //constructor creates pObj of appropriate type and data fields
    public pObj(int i,String str){
      mode=i;
      //numbers
      if(mode==0){
         if(str.equals("e")){num=Math.E;}
         else if(str.equals("p")){num=Math.PI;}
         else{
         //System.out.println(str);
         num=Double.parseDouble(str);}
         priority=0;
      }
      
      //basic operaters
      if(mode==1){
          oper=str;
          if(str.equals("+")){
            priority=1;  opernum=1;
          }
          else if(str.equals("-")){
            priority=1;  opernum=2;
          }
          if(str.equals("*")){
            priority=2;  opernum=3;
          }
          if(str.equals("/")){
            priority=2;  opernum=4;
          }
          if(str.equals("^")){
            priority=3;  opernum=5;
          }
      }
      
      //parenthesis
      else if(mode==2){
          oper=str;
      }
      
      
      //advanced operaters
      else if(mode==3){
          oper=str;
          priority=4;
          if(oper.equals("sin")){opernum=6;}
          else if(oper.equals("cos")){opernum=7;}
          else if(oper.equals("tan")){opernum=8;}
          else if(oper.equals("log")){opernum=9;}
          else if(oper.equals("sinh")){opernum=10;}
          else if(oper.equals("cosh")){opernum=11;}
      }
      
    }
    
    
    //prints appropriate contents of pObj based on type.  For debugging use.
    public String toString(){
      if(mode==0){
       return(Double.toString(num));}
      if(mode==1){return(oper);}
      if(mode==2){return(oper);}
      if(mode==3){return(oper);}
      else{return("x");}
    }
    
}