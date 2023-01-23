
package pokemon;


public class entrenador {
    private String nombre;
	private int cont = 0, tam = 2;
	
	private pikachu[] mochila = new pikachu[tam];
	
	
	//Constructor
	public entrenador(String nombre){
		this.nombre = nombre;
		
		mochila[cont] = new pikachu();
		cont++; //cont = 1
	}
	
	//Getter	
	public String getNombre(){
		return nombre;
	}
	
	//metodos
	//Se elige a un pikachu de la mochila en funcion del indice recibido (i) y se devuelve,
	//si el indice no se encuentra en el vector se devuelve null
	public pikachu elige(int i){
		if(i < cont){ //Cont es el lugar donde a partir de ahi esta vacio el vector
			return mochila[i];
		}
		else{
			return null;
		}
	}
	
	//Metodo que se llama cuando un entrenador trata de capturar a un pikachu, devuelve
	//un booleano confirmando si lo ha capturado o no y solo lo capturara si existe
	//hueco en la mochila
	public boolean captura(pikachu enemigo){
		boolean capturado = false;
		
		if(enemigo.getVida() <= 20){
			mochila[cont] = enemigo; //Constructor de copia
			capturado = true;
			cont++;
				
			System.out.println("Has capturado un nuevo Pikachu!");
		}
		else{
			System.out.println("Imposible de capturar.");
		}
		
		return capturado;		
	}
	
	//Metodo que muestra los pikachus que tenemos en la mochila junto con sus caracteristicas
	public void mostrar_mochila(){
		System.out.println("Tienes: "+cont+" Pikachus");
		
		for(int i = 0; i < cont; i++){
			System.out.println("Nº: "+i+" Nivel: "+mochila[i].getNivel()+" Vida: "+mochila[i].getVida());
		}
        }
}
