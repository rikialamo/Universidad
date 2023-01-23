
package main;

public class Planta extends Guerrero{
    
    private Arma arma;

    public Planta(Arma arma, String nombre, int ataque, int defensa) {
        super(nombre, ataque, defensa);
        this.arma = arma;
    }

    public Arma getArma() {
        return arma;
    }

    @Override
    public String toString() {
        return "Planta: "+getNombre()+"\nNivel de ataque: "+getAtaque()+"\nNivel de defensa: "+getDefensa()+"\nNivel de vida: "+getNivelVida()+"\nArma: "+getArma();
    }

  
}
