package main;

public class Simulacion {

    public static void main(String[] args) {

        String[] disposicionTablero = {
                                            "Plantas:2",
                                            "Zombis:3",
                                            "Recolectores:6",
                                            "P;Repetidora;10;7;1",
                                            "Z;Zombistein;15;20;Polimórfico;1",
                                            "P;Iris;28;21;3",
                                            "Z;Zombot;18;25;Influenza;1",
                                            "Z;Zombidito;21;8;Adenovirus;0",
                                        };
        PartidaTipo2 p = new PartidaTipo2(disposicionTablero);
        p.jugar();

    }

}
