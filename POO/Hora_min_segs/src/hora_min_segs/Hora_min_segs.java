
package hora_min_segs;

import java.util.Scanner;
public class Hora_min_segs {

    public static void main(String[] args) {
        
        double hora, min, seg;
        Scanner S=new Scanner(System.in);
        
        System.out.println("Introduce la hora");
        hora=S.nextDouble();
        System.out.println("Introduce los minutos");
        min=S.nextDouble();
        System.out.println("Introduce los segundos");
        seg=S.nextDouble();
        
        if(hora<24 && hora>0 && min<60 && min>0 && seg<60 && seg>0){
            
                    System.out.println("La hora es correcta");
                    seg+=1;
                   
                    
                    if(seg==60){
                        min+=1;
                        seg=0;
                    }
                    if(min==60){
                        hora+=1;
                        min=0;        
                    }
                    if(hora==24){
                        hora=0;
                    }
                    
                    System.out.println(+hora+" - "+min+" - "+seg);
               
        }
        else{
            System.out.println("la hora esta mal");
        }
        
    }
    
}
