
package main;

public class Arma {
    
    private int tipo;
    private int potencia;
    
    public final int Sin_arma=0;
    public final int COROLA=1;
    public final int PISTILO = 2;
    public final int ESTAMBRE = 3;
    public final int CALIZ = 4;

    
    public Arma(int tipo) {
        
        if (tipo == COROLA){
            potencia = 5;
            
        }else if(tipo == PISTILO){
                potencia = 15;
        }else if (tipo == ESTAMBRE){
            potencia = 20;
        }
        else if(tipo == CALIZ){
            potencia = 30;
        }
        else{
            tipo = 0;
            potencia = 0;
        }
        this.tipo = tipo;
    }
    

    public int getTipo() {
        return tipo;
    }

    public int getPotencia() {
        return potencia;
    }

    @Override
    public String toString() {
        String arma;
        
        if (tipo == COROLA){
            arma = "corola";
            
        }else if(tipo == PISTILO){
            arma = "pistilo";
        }else if (tipo == ESTAMBRE){
            arma = "estambre";
        }
        else if(tipo == CALIZ){
            arma = "caliz";
        }
        else{
            arma = "sin arma";
        }
        
        return "arma "+arma+"("+getPotencia()+")";
    }
    
    
    
}
