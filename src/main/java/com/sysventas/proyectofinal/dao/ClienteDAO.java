package com.sysventas.proyectofinal.dao;

import com.sysventas.proyectofinal.config.ConexionDB;
import com.sysventas.proyectofinal.model.Cliente;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    public List<Cliente> listar() throws SQLException {
        return listar(null, 1, Integer.MAX_VALUE);
    }

    public List<Cliente> listar(String q, int pagina, int tamanoPagina) throws SQLException {
        List<Cliente> lista = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT IdCliente, Nombre, Apellido, Telefono, Email, Direccion, Activo " +
            "FROM Cliente WHERE 1=1 ");
        if (q != null && !q.isBlank()) sql.append("AND (Nombre LIKE ? OR Apellido LIKE ? OR Email LIKE ?) ");
        sql.append("ORDER BY IdCliente OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (q != null && !q.isBlank()) {
                String like = "%" + q + "%";
                ps.setString(idx++, like);
                ps.setString(idx++, like);
                ps.setString(idx++, like);
            }
            int offset = (pagina - 1) * tamanoPagina;
            ps.setInt(idx++, offset);
            ps.setInt(idx++, tamanoPagina);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Cliente c = new Cliente();
                    c.setIdCliente(rs.getInt("IdCliente"));
                    c.setNombre(rs.getString("Nombre"));
                    c.setApellido(rs.getString("Apellido"));
                    c.setTelefono(rs.getString("Telefono"));
                    c.setEmail(rs.getString("Email"));
                    c.setDireccion(rs.getString("Direccion"));
                    c.setActivo(rs.getBoolean("Activo"));
                    lista.add(c);
                }
            }
        }
        return lista;
    }

    public int contar(String q) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Cliente WHERE 1=1 ");
        if (q != null && !q.isBlank()) sql.append("AND (Nombre LIKE ? OR Apellido LIKE ? OR Email LIKE ?) ");
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (q != null && !q.isBlank()) {
                String like = "%" + q + "%";
                ps.setString(idx++, like);
                ps.setString(idx++, like);
                ps.setString(idx++, like);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    public void insertar(Cliente c) throws SQLException {
        String sql = "INSERT INTO Cliente (Nombre, Apellido, Telefono, Email, Direccion, Activo) VALUES (?,?,?,?,?,?)";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getApellido());
            ps.setString(3, c.getTelefono());
            ps.setString(4, c.getEmail());
            ps.setString(5, c.getDireccion());
            ps.setBoolean(6, c.isActivo());
            ps.executeUpdate();
        }
    }

    public void actualizar(Cliente c) throws SQLException {
        String sql = "UPDATE Cliente SET Nombre=?, Apellido=?, Telefono=?, Email=?, Direccion=?, Activo=? WHERE IdCliente=?";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getApellido());
            ps.setString(3, c.getTelefono());
            ps.setString(4, c.getEmail());
            ps.setString(5, c.getDireccion());
            ps.setBoolean(6, c.isActivo());
            ps.setInt(7, c.getIdCliente());
            ps.executeUpdate();
        }
    }

    public void eliminar(int id) throws SQLException {
        String sql = "UPDATE Cliente SET Activo = 0 WHERE IdCliente = ?";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
