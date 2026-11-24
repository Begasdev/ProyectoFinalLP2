package com.sysventas.proyectofinal.model;

public class UnidadMedida {
    private int idUnidadMedida;
    private String nombre;
    private String abreviatura;
    private boolean activo;

    public UnidadMedida() { }
    public UnidadMedida(int idUnidadMedida, String nombre, String abreviatura, boolean activo) {
        this.idUnidadMedida = idUnidadMedida;
        this.nombre = nombre;
        this.abreviatura = abreviatura;
        this.activo = activo;
    }

    public int getIdUnidadMedida() { return idUnidadMedida; }
    public void setIdUnidadMedida(int idUnidadMedida) { this.idUnidadMedida = idUnidadMedida; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getAbreviatura() { return abreviatura; }
    public void setAbreviatura(String abreviatura) { this.abreviatura = abreviatura; }
    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }
}
