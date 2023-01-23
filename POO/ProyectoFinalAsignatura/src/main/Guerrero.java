package main;

public class Guerrero implements Personaje{
    
    private String nombre;
    
    private int ataque;
    
    public final int MAX_ATAQUE = 100;
    
    public final int MAX_DEFENSA = 100;
    
    private int defensa;
    
    private int nivelVida;

    public Guerrero(String nombre, int ataque, int defensa) {
        
        if(ataque < 0){
            ataque = 0;
        }else if(ataque > MAX_ATAQUE){
            ataque = MAX_ATAQUE;
        }
        if(defensa < 0){
            defensa  = 0;
        }else if(defensa > MAX_DEFENSA){
            defensa = MAX_DEFENSA;
        }
        
        this.nombre = nombre;
        this.ataque = ataque;
        this.defensa = defensa;
        this.nivelVida = MAX_NIVEL_VIDA;
    }
    
    @Override
    public String toString(){
        return getNombre()+"\nNivel de ataque: "+getAtaque()+"\nNivel de defensa: "+getDefensa()+"\nNivel de vida: "+getNivelVida();
    }
    
    @Override
    public int getAtaque() {
        return ataque;
    }

    @Override
    public int getDefensa() {
        return defensa;
    }

    @Override
    public int getNivelVida() {
        return nivelVida;
    }

    @Override
    public String getNombre() {
        return nombre;
    }

    public void setAtaque(int ataque) {
        this.ataque = ataque;
    }

    public void setDefensa(int defensa) {
        this.defensa = defensa;
    }
    
    @Override
    public void setNivelVida(int n) {
        if(n <= 0){
            n = 0;
        }else if (n > MAX_NIVEL_VIDA){
            n = MAX_NIVEL_VIDA;
        }
        this.nivelVida = n;
    }

    @Override
    public boolean isVivo() {
        return nivelVida>0;
    }
    
    
    
    
}
