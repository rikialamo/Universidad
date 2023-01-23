
package pkgstatic;

public class Static {

    
    public static void main(String[] args) {
    
        triangulo t1 = new triangulo(10, "t1");
        triangulo t2 = new triangulo(20, "t2");
        
        System.out.println("El valor del triangulo t1 es: "+t1.getArea()+(" el nombre es: "+t1.getNombre()));
        System.out.println("El valor del triangulo t2 es: "+t2.getArea()+(" el nombre es: "+t2.getNombre()));

    }
    
}
