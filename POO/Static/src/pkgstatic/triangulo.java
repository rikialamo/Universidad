
package pkgstatic;

public class triangulo {
    
    private int area;
    private static String nombre;
    
    //constructor
    public triangulo(int area, String nombre){
        this.area = area;
        this.nombre = nombre;
    }
    
    //set and get

    public int getArea() {
        return area;
    }

    public void setArea(int area) {
        this.area = area;
    }

    public static String getNombre() {
        return nombre;
    }

    public static void setNombre(String nombre) {
        triangulo.nombre = nombre;
    }

    
    
}
