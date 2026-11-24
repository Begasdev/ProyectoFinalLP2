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
        return listar(null, null, 1, Integer.MAX_VALUE);
    }

    public List<Producto> listar(String q, Integer categoriaId, int pagina, int tamanoPagina) throws SQLException {
        List<Producto> lista = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.IdProducto, p.IdCategoria, c.Nombre AS NombreCategoria, p.Codigo, p.Descripcion, " +
            "p.PrecioCompra, p.PrecioVenta, p.Cantidad, p.Activo " +
            "FROM Producto p INNER JOIN Categoria c ON p.IdCategoria = c.IdCategoria " +
            "WHERE 1=1 ");
        if (q != null && !q.isBlank()) sql.append("AND (p.Codigo LIKE ? OR p.Descripcion LIKE ?) ");
        if (categoriaId != null) sql.append("AND p.IdCategoria = ? ");
        sql.append("ORDER BY p.IdProducto OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (q != null && !q.isBlank()) {
                String like = "%" + q + "%";
                ps.setString(idx++, like);
                ps.setString(idx++, like);
            }
            if (categoriaId != null) ps.setInt(idx++, categoriaId);
            int offset = (pagina - 1) * tamanoPagina;
            ps.setInt(idx++, offset);
            ps.setInt(idx++, tamanoPagina);
            try (ResultSet rs = ps.executeQuery()) {
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
        }
        return lista;
    }

    public int contar(String q, Integer categoriaId) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Producto p WHERE 1=1 ");
        if (q != null && !q.isBlank()) sql.append("AND (p.Codigo LIKE ? OR p.Descripcion LIKE ?) ");
        if (categoriaId != null) sql.append("AND p.IdCategoria = ? ");
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (q != null && !q.isBlank()) {
                String like = "%" + q + "%";
                ps.setString(idx++, like);
                ps.setString(idx++, like);
            }
            if (categoriaId != null) ps.setInt(idx++, categoriaId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
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

    public int contarStockBajo(int umbral) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Producto WHERE Activo = 1 AND Cantidad > 0 AND Cantidad <= ?";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, umbral);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    public int contarAgotados() throws SQLException {
        String sql = "SELECT COUNT(*) FROM Producto WHERE Activo = 1 AND Cantidad = 0";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public double valorInventario() throws SQLException {
        String sql = "SELECT COALESCE(SUM(PrecioCompra * Cantidad), 0) FROM Producto WHERE Activo = 1";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        }
        return 0.0;
    }

    public List<Producto> listarMenosStock(int limite) throws SQLException {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT TOP (?) IdProducto, Codigo, Descripcion, Cantidad " +
                     "FROM Producto WHERE Activo = 1 ORDER BY Cantidad ASC, IdProducto ASC";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, limite);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Producto p = new Producto();
                    p.setIdProducto(rs.getInt("IdProducto"));
                    p.setCodigo(rs.getString("Codigo"));
                    p.setDescripcion(rs.getString("Descripcion"));
                    p.setCantidad(rs.getInt("Cantidad"));
                    lista.add(p);
                }
            }
        }
        return lista;
    }
}
