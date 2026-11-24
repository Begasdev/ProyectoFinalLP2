package com.sysventas.proyectofinal.dao;

import com.sysventas.proyectofinal.config.ConexionDB;
import com.sysventas.proyectofinal.model.Producto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    public List<Producto> listar() throws SQLException {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT p.IdProducto, p.IdCategoria, c.Nombre AS NombreCategoria, p.Codigo, p.Descripcion, p.PrecioCompra, p.PrecioVenta, p.Cantidad, p.Activo " +
                     "FROM Producto p INNER JOIN Categoria c ON p.IdCategoria = c.IdCategoria ORDER BY p.IdProducto";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Producto p = new Producto();
                p.setIdProducto(rs.getInt("IdProducto"));
                p.setIdCategoria(rs.getInt("IdCategoria"));
                p.setNombreCategoria(rs.getString("NombreCategoria"));
                p.setCodigo(rs.getString("Codigo"));
                p.setDescripcion(rs.getString("Descripcion"));
                p.setPrecioCompra(rs.getDouble("PrecioCompra"));
                p.setPrecioVenta(rs.getDouble("PrecioVenta"));
                p.setCantidad(rs.getInt("Cantidad"));
                p.setActivo(rs.getBoolean("Activo"));
                lista.add(p);
            }
        }
        return lista;
    }

    public void insertar(Producto p) throws SQLException {
        String sql = "INSERT INTO Producto (IdCategoria, Codigo, Descripcion, PrecioCompra, PrecioVenta, Cantidad, Activo) VALUES (?,?,?,?,?,?,?)";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, p.getIdCategoria());
            ps.setString(2, p.getCodigo());
            ps.setString(3, p.getDescripcion());
            ps.setDouble(4, p.getPrecioCompra());
            ps.setDouble(5, p.getPrecioVenta());
            ps.setInt(6, p.getCantidad());
            ps.setBoolean(7, p.isActivo());
            ps.executeUpdate();
        }
    }

    public void actualizar(Producto p) throws SQLException {
        String sql = "UPDATE Producto SET IdCategoria=?, Codigo=?, Descripcion=?, PrecioCompra=?, PrecioVenta=?, Cantidad=?, Activo=? WHERE IdProducto=?";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, p.getIdCategoria());
            ps.setString(2, p.getCodigo());
            ps.setString(3, p.getDescripcion());
            ps.setDouble(4, p.getPrecioCompra());
            ps.setDouble(5, p.getPrecioVenta());
            ps.setInt(6, p.getCantidad());
            ps.setBoolean(7, p.isActivo());
            ps.setInt(8, p.getIdProducto());
            ps.executeUpdate();
        }
    }

    public void eliminar(int id) throws SQLException {
        String sql = "UPDATE Producto SET Activo = 0 WHERE IdProducto = ?";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
