package main;

public class Jugador extends Plantilla implements IJugador{
    
    private int dorsal;

    
    public Jugador(int dorsal, String nombre, double sueldo) {
        super(nombre, sueldo);
        this.dorsal = dorsal;
    }

    public int getDorsal() {
        return dorsal;
    }

    public void setDorsal(int dorsal) {
        this.dorsal = dorsal;
    }

    @Override
    public void darEntrevista() {
        System.out.println("Soy jugador del equipo. Estoy encantado de dar entrevistas\n");
    }
    
    @Override
    public String toString() {
        return "JUGADOR: \n"+"nombre: "+this.getNombre()+"\nsueldo: "+this.getSueldo()+"\ndorsal: "+this.getDorsal();
    } 

    @Override
    public int getNumPersonas() {
        return 0;
    }
}
