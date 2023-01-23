package ampliando.constructores;

import java.util.Random;

public class AmpliandoConstructores {
  
    public static void main(String[] args) {
        
        Random rand = new Random(System.nanoTime());
        int aux1, aux2;
        
        aux1=rand.nextInt(10);
        aux2=rand.nextInt(10);
         vertice a = new vertice(aux1, aux2);
                
        aux1=rand.nextInt(10);
        aux2=rand.nextInt(10);
        vertice b = new vertice(aux1, aux2);
        
        aux1=rand.nextInt(10);
        aux2=rand.nextInt(10);
        vertice c = new vertice(aux1, aux2);
        
        triangulo t1 = new triangulo(a, b, c); 
                
    }
    
}
