package com.sysventas.proyectofinal.model;

public class Producto {
    private int idProducto;
    private int idCategoria;
    private String nombreCategoria;
    private String codigo;
    private String descripcion;
    private double precioCompra;
    private double precioVenta;
    private int cantidad;
    private boolean activo;

    public Producto() { }
    public Producto(int idProducto, int idCategoria, String nombreCategoria, String codigo, String descripcion,
                    double precioCompra, double precioVenta, int cantidad, boolean activo) {
        this.idProducto = idProducto;
        this.idCategoria = idCategoria;
        this.nombreCategoria = nombreCategoria;
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.precioCompra = precioCompra;
        this.precioVenta = precioVenta;
        this.cantidad = cantidad;
        this.activo = activo;
    }

    public int getIdProducto() { return idProducto; }
    public void setIdProducto(int idProducto) { this.idProducto = idProducto; }
    public int getIdCategoria() { return idCategoria; }
    public void setIdCategoria(int idCategoria) { this.idCategoria = idCategoria; }
    public String getNombreCategoria() { return nombreCategoria; }
    public void setNombreCategoria(String nombreCategoria) { this.nombreCategoria = nombreCategoria; }
    public String getCodigo() { return codigo; }
    public void setCodigo(String codigo) { this.codigo = codigo; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public double getPrecioCompra() { return precioCompra; }
    public void setPrecioCompra(double precioCompra) { this.precioCompra = precioCompra; }
    public double getPrecioVenta() { return precioVenta; }
    public void setPrecioVenta(double precioVenta) { this.precioVenta = precioVenta; }
    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }
    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }
}
