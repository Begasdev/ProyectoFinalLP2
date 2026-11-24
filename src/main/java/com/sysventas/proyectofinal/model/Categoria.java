package com.sysventas.proyectofinal.model;

public class Categoria {
    private int idCategoria;
    private int idUnidadMedida;
    private String nombreUnidad;
    private String nombre;
    private String descripcion;
    private boolean activo;

    public Categoria() { }
    public Categoria(int idCategoria, int idUnidadMedida, String nombreUnidad, String nombre, String descripcion, boolean activo) {
        this.idCategoria = idCategoria;
        this.idUnidadMedida = idUnidadMedida;
        this.nombreUnidad = nombreUnidad;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.activo = activo;
    }

    public int getIdCategoria() { return idCategoria; }
    public void setIdCategoria(int idCategoria) { this.idCategoria = idCategoria; }
    public int getIdUnidadMedida() { return idUnidadMedida; }
    public void setIdUnidadMedida(int idUnidadMedida) { this.idUnidadMedida = idUnidadMedida; }
    public String getNombreUnidad() { return nombreUnidad; }
    public void setNombreUnidad(String nombreUnidad) { this.nombreUnidad = nombreUnidad; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }
}
