package com.sysventas.proyectofinal.model;

public class Usuario {
    private int idUsuario;
    private int idRol;
    private String nombreRol;
    private String nombreCompleto;
    private String nombreUsuario;
    private String clave;
    private boolean resetearClave;
    private boolean activo;

    public Usuario() { }

    public Usuario(int idUsuario, int idRol, String nombreRol, String nombreCompleto,
                   String nombreUsuario, String clave, boolean resetearClave, boolean activo) {
        this.idUsuario = idUsuario;
        this.idRol = idRol;
        this.nombreRol = nombreRol;
        this.nombreCompleto = nombreCompleto;
        this.nombreUsuario = nombreUsuario;
        this.clave = clave;
        this.resetearClave = resetearClave;
        this.activo = activo;
    }

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }
    public int getIdRol() { return idRol; }
    public void setIdRol(int idRol) { this.idRol = idRol; }
    public String getNombreRol() { return nombreRol; }
    public void setNombreRol(String nombreRol) { this.nombreRol = nombreRol; }
    public String getNombreCompleto() { return nombreCompleto; }
    public void setNombreCompleto(String nombreCompleto) { this.nombreCompleto = nombreCompleto; }
    public String getNombreUsuario() { return nombreUsuario; }
    public void setNombreUsuario(String nombreUsuario) { this.nombreUsuario = nombreUsuario; }
    public String getClave() { return clave; }
    public void setClave(String clave) { this.clave = clave; }
    public boolean isResetearClave() { return resetearClave; }
    public void setResetearClave(boolean resetearClave) { this.resetearClave = resetearClave; }
    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }
}
