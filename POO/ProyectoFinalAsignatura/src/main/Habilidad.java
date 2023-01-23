
package main;

class Habilidad {
    
    private int tipo;
    private int potencia;
    
    public final int SIN_HABILIDAD = 0;
    public final int SALTARIN = 1;
    public final int ESQUIVADOR = 2;
    public final int HIPNOTIZADOR = 3;

    public Habilidad(int tipo) {
        
        this.tipo = tipo;
        
        if (tipo == SALTARIN){
            potencia = 10;
        }else if (tipo == ESQUIVADOR){
            potencia = 25;
        }else if(tipo == HIPNOTIZADOR){
            potencia = 40;
        }else{
            potencia = 0;
        }  
    }

    public int getPotencia() {
        return potencia;
    }

    public int getTipo() {
        return tipo;
    }

    @Override
    public String toString() {
        String aby;
        
        if (tipo == SALTARIN){
            aby="saltarín";
        }else if (tipo == ESQUIVADOR){
            aby="esquivador";
        }else if(tipo == HIPNOTIZADOR){
            aby="hipnotizador";
        }else{
            aby="sin arma";
        }
        
        return "Habilidad "+aby+"("+getPotencia()+")";
    }
    
    
    
}
