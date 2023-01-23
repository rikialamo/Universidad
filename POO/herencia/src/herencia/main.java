
package herencia;


public class main {
    
    public static void main(String[] args) {
        coche c = new coche(100, 4);
        //moto m = new moto(200, false);
        
        System.out.println("la velocidad del coche es de: "+c.getVelocidad());
        //system.out.println("la velocidad de la moto es de: "+c.getVelocidad());
        
        c.acelera();
        //m.acelera();
        
        System.out.println("la velocidad del coche es de: "+c.getVelocidad());
        //system.out.println("la velocidad de la moto es de: "+c.getVelocidad());
    }
}

