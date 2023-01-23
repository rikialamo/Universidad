package ampliando.constructores;

public class triangulo {
    
    private vertice a, b, c;

    public triangulo(vertice a, vertice b, vertice c){
        this.a = a;
        this.b = b;
        this.c = c;
    }
    // sets and get
    public vertice getA() {
        return a;
    }

    public void setA(vertice a) {
        this.a = a;
    }

    public vertice getB() {
        return b;
    }

    public void setB(vertice b) {
        this.b = b;
    }

    public vertice getC() {
        return c;
    }

    public void setC(vertice c) {
        this.c = c;
    }
}
