
package constructor;

public class coche {
    
    private int velocidad, aceleracion;
    private String nombre;
    
    //constructor
    public coche(int velocidad, int aceleracion, String nombre){
        this.velocidad = velocidad;
        this.aceleracion = aceleracion;
        this.nombre = nombre;
    }
    
    //set and get
    public int getVelocidad() {
        return velocidad;
    }

    public void setVelocidad(int velocidad) {
        this.velocidad = velocidad;
    }

    public int getAceleracion() {
        return aceleracion;
    }

    public void setAceleracion(int aceleracion) {
        this.aceleracion = aceleracion;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public void acelerar(int aceleracion){
        this.aceleracion = aceleracion;
        velocidad += this.aceleracion;
    }
    
    public void frenar(){
        velocidad = 0;
    }
    
}
