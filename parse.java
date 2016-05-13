import java.lang.Math;
import java.util.*;
public class parse{ 
    static boolean pointexists=true;
    static boolean invalid=false;
    static String exp;
    private static String type1="E0123456789.ep";
    private static String type2="+-*/^";
    private static String type3="()";
    private static String type4="cossintanlogcoshsinh"; //cos  sin tan log
    private static String all="E0123456789.ep+-*/^cossintanlogcoshsinhuv()xyz";
    private static ArrayList<pObj> pobs=new ArrayList<>();
    static ArrayList<Double> xreturnlist=new ArrayList<>();
    static ArrayList<Double> yreturnlist=new ArrayList<>();
    static String xstring;
    static String ystring;

    
    
    //interprets and parses a string with no variables.  ex "4-3^0.02"
    public static double interp(String str){
        if(str.equals("")){return(0);}
        exp=str;
        classify();
        fulleval();
        double temp=pobs.get(0).num;
        pobs.clear();
        return(temp);
    }
    
    
    
    //classifies a the string exp into an arraylist of pObj's to use for evaluation
    public static void classify(){
        try{
            int numlength=0;
            for(int i=0;i<exp.length();i++){
                if (type1.indexOf(exp.substring(i,i+1))!=-1){
                   numlength=i;
                   while(numlength+1<exp.length() && type1.indexOf(exp.substring(numlength+1,numlength+2))!=-1){   
                       if(exp.substring(numlength+1,numlength+2).equals("E")){numlength+=1;}
                       numlength+=1;
                   }
                   pobs.add(new pObj(0,exp.substring(i,numlength+1)));
                   i=numlength;
                }
                else if(type2.indexOf(exp.substring(i,i+1))!=-1){
                   pobs.add(new pObj(1,exp.substring(i,i+1)));
                }
                else if(type3.indexOf(exp.substring(i,i+1))!=-1){
                   pobs.add(new pObj(2,exp.substring(i,i+1)));
                }
                //sinh cosh
                else if(type4.indexOf(exp.substring(i,i+4))!=-1){
                   pobs.add(new pObj(3,exp.substring(i,i+4)));
                   i+=3;
                }
                //sin tan cos log
                else if(type4.indexOf(exp.substring(i,i+3))!=-1){
                   pobs.add(new pObj(3,exp.substring(i,i+3)));
                   i+=2;
                }
                else if(exp.substring(i,i+1).equals("E")){
                   //System.out.println("ok");
                   pobs.add(new pObj(2,"*"));pobs.add(new pObj(1,"10")); pobs.add(new pObj(2,"^"));
                }
                else{pobs.add(new pObj(0,"0.0"));}
            }
        }
        catch(StringIndexOutOfBoundsException e){
           invalid=true;
           pobs.add(new pObj(0,"0.0")); 
        }
    }
    
    
    
    
    //check if parenthesis exists
    public static boolean paren(){
        for (pObj a:pobs){
            if (a.mode==2){return true;}
        }
        return false;
    }
    
    
    
    
    //evaluates the full pObj list
    public static boolean fulleval(){
      pointexists=true;
        int left=0;
        while(paren()){
            for (int j=0;j<pobs.size();j++){
                if (pobs.get(j).oper.equals("(")){
                    left=j;
                }
                if(pobs.get(j).oper.equals(")")){
                    eval(left+1,j-1);
                    pobs.remove(left+2);
                    pobs.remove(left);
                    break;
                }
            }
        }   
        //now the parenthesis are all gone
        eval(0,pobs.size()-1);
        if(!pointexists){pobs.get(0).num=0;}
        return(pointexists);
    }
    
    
    
    
    //submethod of fulleval which can evaluate a sublist of pObj's which doesn't contain paranethesis
    //startpos is  after (  and endpos is before )
    public static void eval(int startpos,int endpos){
      for(int prior=4;prior>=1;prior=prior-1){
         for(int i=startpos;i<endpos;i++){
            if(pobs.get(i).priority==prior){
              int numofremovals=operate(pobs,i);              
              for (int j=0;j<numofremovals;j++){                
                  pobs.remove(i);
              }
              i-=1; endpos-=numofremovals;             
            }              
         }
      }
    }
    
    
    
    
    //operates pObj list for different functions ex.('-', 'sin', 'cos', etc)
    public static int operate(ArrayList<pObj> list, int i){
        try{
              if(pobs.get(i).mode==1){
                 if(list.get(i).opernum==1){list.get(i-1).num=list.get(i-1).num+list.get(i+1).num;      }
                 else if(list.get(i).opernum==2){
                       if(i==0||list.get(i-1).mode!=0){
                           list.get(i+1).num*=-1; return(1);
                       }
                       else{list.get(i-1).num=list.get(i-1).num-list.get(i+1).num; }}
                 else if(list.get(i).opernum==3){list.get(i-1).num=list.get(i-1).num*list.get(i+1).num;  }
                 else if(list.get(i).opernum==4){list.get(i-1).num=list.get(i-1).num/list.get(i+1).num;  }
                 else if(list.get(i).opernum==5){list.get(i-1).num=Math.pow(list.get(i-1).num,list.get(i+1).num);  }
                 return(2);
              }
              else if(pobs.get(i).mode==3){
                 if(list.get(i).opernum==6){list.get(i+1).num=Math.sin(list.get(i+1).num); }
                 else if(list.get(i).opernum==7){list.get(i+1).num=Math.cos(list.get(i+1).num); }
                 else if(list.get(i).opernum==8){list.get(i+1).num=Math.tan(list.get(i+1).num); }
                 //check for logs<=0
                 else if(list.get(i).opernum==9){
                     if(list.get(i+1).num>0){
                     list.get(i+1).num=Math.log(list.get(i+1).num); }
                     else{list.get(i+1).num=0; pointexists=false;}
                 }
                 else if(list.get(i).opernum==10){list.get(i+1).num=Math.sinh(list.get(i+1).num); }
                 else if(list.get(i).opernum==11){list.get(i+1).num=Math.cosh(list.get(i+1).num); }
                 return(1);
              }
              return(0);
        }
        catch(Error e){
           invalid=true;
           return(0);
        }
    }
    
    
    
    
    //prints the contents of the pObj list. Only for debugging use.
    public static void print(){
       for (int i=0;i<pobs.size();i++){
          System.out.print("["+i+"]"+"   "+pobs.get(i)+", ");
       }
       System.out.println("");
    }
}