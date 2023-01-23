package main;

public class PlantaRecolectora implements Personaje{
    
    private int nivelVida;

    public PlantaRecolectora() {
        this.nivelVida = MAX_NIVEL_VIDA;
    }

    

    @Override
    public String getNombre() {
        return "Las plantas recolectoras no tienen nombre";
    }

    @Override
    public int getAtaque() {
        return 0;
    }

    @Override
    public int getDefensa() {
        return 0;
    }

    @Override
    public int getNivelVida() {
        return nivelVida;
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
