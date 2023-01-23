
package herencia;


public class coche {
    private int puertas;
    
    private int cv, ruedas;
    private int velocidad;
    
    //constructor
    public coche(int cv, int puertas){
        this.puertas = puertas;
        this.cv = cv;
        
        ruedas = 4;
        velocidad = 0;
    }
    
//gets
    public int getCv() {
        return cv;
    }

    public int getRuedas() {
        return ruedas;
    }

    public int getVelocidad() {
        return velocidad;
    }
    
    //metodos
    public void acelera(){
        velocidad += 10;
    }    
    public void frena(){
        velocidad += 0;
    }  
}
