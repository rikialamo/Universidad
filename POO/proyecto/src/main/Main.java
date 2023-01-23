
package main;


public class Main {

    
    public static void main(String[] args) {
        
        Jugador jug  = new Jugador(3, "Miguel López Frías", 60000.0);
        Masajista mas  = new Masajista("Juan Martín Lozano", 20000.0, "Grado en Fisioterapia");
        Entrenador ent  = new Entrenador("Real Federación Española", "Federico García Ayuso", 20000.0);
        
        System.out.println(jug.toString());
        jug.darEntrevista();
        
        System.out.println(mas.toString());
        mas.darEntrevista();
        
        System.out.println(ent.toString());
        ent.darEntrevista();
        
        ent.dirigirEquipo();
    }
    
}
