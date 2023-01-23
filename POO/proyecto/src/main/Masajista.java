package main;


public class Masajista extends Plantilla implements IMasajista{
    
    private String titulacion;

    public Masajista(String nombre, double sueldo, String titulacion) {
        super(nombre, sueldo);
        this.titulacion = titulacion;
    }

    public void setTitulacion(String titulacion) {
        this.titulacion = titulacion;
    }

    public String getTitulacion() {
        return titulacion;
    }

    @Override
    public void darMasaje() {
    }
    
    public void darEntrevista(){
        System.out.println("Soy el masajista del equipo. No concedo entrevistas.\n");
    }
    
    public String toString (){
        return "MASAJISTA: \n"+"nombre: "+this.getNombre()+"\nsueldo: "+this.getSueldo()+"\ntitulación: "+this.getTitulacion();
    }

    @Override
    public int getNumPersonas() {
        return 0;
    }
    
}
