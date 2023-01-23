
package main;


public abstract class Partida {
    
    protected Planta plantasGuerreras[];
    
    protected Zombi zombis[];
    
    protected PlantaRecolectora plantasRecolectoras[];
    
    protected int plantasGuerreras_vivas;
    
    protected int zombis_vivos;
    
    protected int plantasRecolectoras_vivas;
    
    protected int num_combates;

    public Partida(String[] disposicionTablero) {
        
        num_combates = 0;
        
        int i, j, k;
        
        plantasGuerreras_vivas = Integer.parseInt(disposicionTablero[0].substring(disposicionTablero[0].indexOf(":")+1));
        
        zombis_vivos = Integer.parseInt(disposicionTablero[1].substring(disposicionTablero[1].indexOf(":")+1));
        
        plantasRecolectoras_vivas = Integer.parseInt(disposicionTablero[2].substring(disposicionTablero[2].indexOf(":")+1));
        
        this.plantasGuerreras = new Planta[plantasGuerreras_vivas];
        this.plantasRecolectoras = new PlantaRecolectora[plantasRecolectoras_vivas];
        this.zombis = new Zombi[zombis_vivos];
        
        for(i = 3,j = 0,k = 0; i < disposicionTablero.length;i++){

            if(disposicionTablero[i].startsWith("P")){
                plantasGuerreras[j] = (Planta)trataLinea(disposicionTablero[i]);
                j++;
            }else{
                zombis[k] = (Zombi)trataLinea(disposicionTablero[i]);
                k++;
            }
        }
        for(i = 0; i < plantasRecolectoras_vivas; i++){
            plantasRecolectoras[i] = new PlantaRecolectora();
        }
        num_combates = 0;
        
    }
    
    private Guerrero trataLinea(String l){
        String nombre; 
        int ataque;
        int defensa; 
        Arma arma;
        String infeccion;
        Habilidad habilidad;
        
        nombre = l.substring(2, l.indexOf(";", 2));
        ataque = Integer.parseInt(l.substring(l.indexOf(";", 2)+1, l.indexOf(";", l.indexOf(";", 2)+1)));
        defensa = Integer.parseInt(l.substring(l.indexOf(";", l.indexOf(";", 2)+1)+1, l.indexOf(";", l.indexOf(";", l.indexOf(";", 2)+1)+1)));
        
        if(l.startsWith("P")){

            arma = new Arma(Integer.parseInt(l.substring(l.length()-1)));
            return new Planta(arma, nombre, ataque, defensa);
        }else{
            infeccion = l.substring(l.indexOf(";",l.indexOf(";",l.indexOf(";", 2)+1)+1)+1, l.indexOf(";",l.indexOf(";",l.indexOf(";",l.indexOf(";", 2)+1)+1)+1));
            habilidad = new Habilidad(Integer.parseInt(l.substring(l.length()-1)));

            return new Zombi(infeccion, habilidad, nombre, ataque, defensa);
        }
        
    }    
    
    public void imprimeEstadoPartida(){
        System.out.println("******** ESTADO GLOBAL DE LA PARTIDA ********\n"
                           +" - PLANTAS GUERRERAS:"+
                           "\n   - Número inicial de planta de tipo guerrera: "+plantasGuerreras.length+
                           "\n   - Número de planta de tipo guerrera vivas: "+plantasGuerreras_vivas+
                           "\n   - Número de planta de tipo guerrera muertas: "+(plantasGuerreras.length-plantasGuerreras_vivas)+
                           "\n - ZOMBIS:"+
                           "\n   - Número inicial de zombi: "+zombis.length+
                           "\n   - Número de Zombis vivos: "+zombis_vivos+
                           "\n   - Número de Zombis muertas: "+(zombis.length-zombis_vivos)+
                           "\n - RECOLECTORAS:"+
                           "\n   - Número inicial de planta de tipo recolectoras: "+plantasRecolectoras.length+
                           "\n   - Número de planta de tipo recolectora vivas: "+plantasRecolectoras_vivas+
                           "\n   - Número de planta de tipo recolectora muertas: "+(plantasRecolectoras.length-plantasRecolectoras_vivas)+"\n"
                            );
        
        if(plantasGuerreras_vivas != 0 && zombis_vivos != 0){
            System.out.println("--> PARTIDA EN JUEGO: ");
            if(plantasGuerreras_vivas < zombis_vivos){
                System.out.println("Los Zombis van ganando.");
            }else if(plantasGuerreras_vivas > zombis_vivos){
                System.out.println("Las Plantas van ganando");
            }else{
                System.out.println("Las Plantas y los Zombis están empatados.");
            }
        }else {
            System.out.println("--> PARTIDA FINALIZADA: ");
            if(plantasGuerreras_vivas != 0 && zombis_vivos == 0){
                System.out.println("Las Plantas han ganado.");
            }else if(plantasGuerreras_vivas == 0 && zombis_vivos != 0){
                System.out.println("Los Zombis han ganado");
            }else if(plantasGuerreras_vivas == 0 && zombis_vivos == 0){
                System.out.println("Las Plantas y los Zombis han empatado");
            }
        }
        System.out.println(" --> Combates hasta el momento: "+num_combates);
    }
    
    protected int combate(Personaje p1, Personaje p2){
        
        int n;
        if (!p1.isVivo() || !p2.isVivo()|| p1.equals(p2)){
            n = -1;
        }else if(p1.getDefensa() == 0){
            System.out.println("Una planta de tipo recolectora ha muerto");
            p1.setNivelVida(0);
            plantasRecolectoras_vivas -= 1;
            n = 2;
        }else{
            System.out.print("COMBATE: "+p1.getNombre()+" Vs "+p2.getNombre()+"\n======== GANADOR: ");
            if(p1.getDefensa() < p2.getAtaque()+((Zombi)p2).getHabilidad().getPotencia())
                p1.setNivelVida(p1.getNivelVida()-(p2.getAtaque()+((Zombi)p2).getHabilidad().getPotencia()-p1.getDefensa()));
            if(p2.getDefensa() < p1.getAtaque()+((Planta)p1).getArma().getPotencia())
                p2.setNivelVida(p2.getNivelVida()-(p1.getAtaque()+((Planta)p1).getArma().getPotencia()-p2.getDefensa()));
            if(p1.getNivelVida() < p2.getNivelVida()){
                System.out.println(p2.getNombre());
                n = 2;
            }else if(p1.getNivelVida() > p2.getNivelVida()){
                System.out.println(p1.getNombre());
                n = 1;
            }else{
                System.out.println("Ninguno");
                n = 0;
            }
            if(p1.isVivo())
                System.out.println("******** "+p1.getNombre()+" sigue viva");
            else{
                System.out.println("******** "+p1.getNombre()+" ha muerto");
                plantasGuerreras_vivas -= 1;
            }if(p2.isVivo())
                System.out.println("******** "+p2.getNombre()+" sigue vivo");
            else{
                System.out.println("******** "+p2.getNombre()+" ha muerto");
                zombis_vivos -= 1;
            }
        }
        num_combates++;
        return n;
    }
    
    public void imprimePlantasGuerrerasVivas(){
        
        int n;
        
        System.out.println(" --> PLANTAS GUERRERAS VIVAS: ");
        
        for (n = 0; n < plantasGuerreras.length ; n++){
            if(plantasGuerreras[n].isVivo()){
                System.out.println("\n"+ n +": "+ plantasGuerreras[n].toString());
            }
        }
        
    }
    
    public void imprimeZombisVivos(){
        int n;
        
        System.out.println(" --> ZOMBIS VIVOS: ");
        
        for (n = 0; n < zombis.length ; n++){
            if(zombis[n].isVivo()){
                System.out.println("\n"+ n +": "+ zombis[n].toString());
            }
        }
    }
    
    public abstract void jugar();
    
}
