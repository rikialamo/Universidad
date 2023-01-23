/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main;

/**
 *
 * @author eps
 */
public abstract class Plantilla implements IPlantilla{
    
    private String nombre;
    
    private double sueldo;
    
    private static int numPersonas;

    public Plantilla(String nombre, double sueldo) {
        this.nombre = nombre;
        this.sueldo = sueldo;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setSueldo(double sueldo) {
        this.sueldo = sueldo;
    }

    public String getNombre() {
        return nombre;
    }

    public double getSueldo() {
        return sueldo;
    }
    
    public int getNumPersonas() {
        return numPersonas;
    }
    
    public void darEntrevista() {
        
    }
    
    public String toString(){
        return "nombre: "+this.getNombre()+"\nsueldo: "+this.getSueldo();
    }

    
    
    
    

    

    
    
}
