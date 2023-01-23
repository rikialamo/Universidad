package main;

public class Zombi extends Guerrero{
    
    private String infeccion;
    
    private Habilidad habilidad;

    public Zombi(String infeccion, Habilidad habilidad, String nombre, int ataque, int defensa) {
        super(nombre, ataque, defensa);
        this.infeccion = infeccion;
        this.habilidad = habilidad;
    }

    public String toString(){
        return "Zombi: "+getNombre()+"\nNivel de ataque: "+getAtaque()+"\nNivel de defensa: "+getDefensa()+"\nNivel de vida: "+getNivelVida()+"\nInfeccion: "+getInfeccion()+"\nHabilidad";
    }

    public String getInfeccion() {
        return infeccion;
    }

    public Habilidad getHabilidad() {
        return habilidad;
    }    
    
}
