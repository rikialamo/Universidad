
package pkgfinal.atributos;

public class libro {
    private final int ISBN;
    
    //constructor
    public libro(int ISBN){
        this.ISBN = ISBN;
    }
    
    //get and set

    public int getISBN() {
        return ISBN;
    }
    
    public void setISBN(int ISBN){//no puedes variar el valor de un final
        this.ISBN = ISBN;
    }
}
