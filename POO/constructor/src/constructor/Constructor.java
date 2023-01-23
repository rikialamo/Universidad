
package constructor;

public class Constructor {

    public static void main(String[] args) {
        
        coche toyota= new coche(0,0,"Prius"); //en el parentesis estan los valores del constructor
        
        System.out.println("el nombre de mi coche es: "+toyota.getNombre()+" y tiene una velocidad de: "+toyota.getVelocidad());
        
    }
    
}
