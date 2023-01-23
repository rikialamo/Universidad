
package pokemon;

import java.util.Scanner;


public class batalla {
    private entrenador yo;
	private Scanner s = new Scanner(System.in);
	
	private pikachu enemigo, mio;
	
	//Constructor
	public batalla(entrenador yo){
		this.yo = yo; //Llameis a un constructor de copia
	}
	
	//Batalla
	//Con este metodo se comienza la batalla y el se encarga de llamar al resto de metodos
	public void comienza(){		
		enemigo = new pikachu();		
		mio = elige();
		pelea();		
	}
	
	//Genera la pelea entre los dos pikachus, de modo que se puede elegir que ataque realiar
	public void pelea(){
		boolean disponible = true;
		int opcion;
		
		do{
			enemigo.mostrar("Enemigo");
			mio.mostrar("Mio");
			
			do{
				System.out.println("Elige que ataque realizar: ");
				System.out.println("1) Placaje. PM: "+mio.getPm1());
				System.out.println("2) Rayo. PM: "+mio.getPm2());
				System.out.println("3) Captura al Enemigo");
				
				System.out.println("Selecciona una opcion: ");
				opcion = s.nextInt();				
				
			}while(opcion < 0 || opcion > 3);
			
			switch(opcion){
				case 1:
					enemigo.daño_recibido(mio.placaje());
					break;
				case 2:
					enemigo.daño_recibido(mio.rayo());
					break;
				case 3:
					disponible = !(yo.captura(enemigo));
			}
			
		}while(mio.getVida() > 0 && enemigo.getVida() > 0 && disponible);
	}
	
	//Con este metodo se elege a que pikachu utilizar en la batalla
	public pikachu elige(){
		int opcion;
		
		System.out.println("Elige tu Pokemon: ");
		opcion = s.nextInt();
		
		return yo.elige(opcion);
        }
}
