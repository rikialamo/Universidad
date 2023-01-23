package main;

public class Entrenador extends Plantilla implements IEntrenador{
    
    private String idFederacion;

    public Entrenador(String idFederacion, String nombre, double sueldo) {
        super(nombre, sueldo);
        this.idFederacion = idFederacion;
    }

    public void setIdFederacion(String idFederacion) {
        this.idFederacion = idFederacion;
    }

    public String getIdFederacion() {
        return idFederacion;
    }

    @Override
    public void dirigirEquipo() {
        System.out.println("Soy entrenador, nuestra plantilla la conforman "+this.getNumPersonas()+" personas");
    }
    
    public void darEntrevista(){
        System.out.println("Soy el entrenador del equipo. Doy entrevistas después del partido.\n");
    }

    @Override
    public String toString() {
        return "ENTRENADOR: \n"+"nombre: "+this.getNombre()+"\nsueldo: "+this.getSueldo()+"\nfederación: "+this.getIdFederacion();
    }

    @Override
    public int getNumPersonas() {
        return 3;
    }

    
    
}
