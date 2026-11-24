package com.sysventas.proyectofinal.dao;

import com.sysventas.proyectofinal.config.ConexionDB;
import com.sysventas.proyectofinal.model.Proveedor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProveedorDAO {

    public List<Proveedor> listar() throws SQLException {
        List<Proveedor> lista = new ArrayList<>();
        String sql = "SELECT IdProveedor, NombreEmpresa, Contacto, Telefono, Email, Direccion, Activo FROM Proveedor ORDER BY IdProveedor";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Proveedor p = new Proveedor();
                p.setIdProveedor(rs.getInt("IdProveedor"));
                p.setNombreEmpresa(rs.getString("NombreEmpresa"));
                p.setContacto(rs.getString("Contacto"));
                p.setTelefono(rs.getString("Telefono"));
                p.setEmail(rs.getString("Email"));
                p.setDireccion(rs.getString("Direccion"));
                p.setActivo(rs.getBoolean("Activo"));
                lista.add(p);
            }
        }
        return lista;
    }

    public void insertar(Proveedor p) throws SQLException {
        String sql = "INSERT INTO Proveedor (NombreEmpresa, Contacto, Telefono, Email, Direccion, Activo) VALUES (?,?,?,?,?,?)";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, p.getNombreEmpresa());
            ps.setString(2, p.getContacto());
            ps.setString(3, p.getTelefono());
            ps.setString(4, p.getEmail());
            ps.setString(5, p.getDireccion());
            ps.setBoolean(6, p.isActivo());
            ps.executeUpdate();
        }
    }

    public void actualizar(Proveedor p) throws SQLException {
        String sql = "UPDATE Proveedor SET NombreEmpresa=?, Contacto=?, Telefono=?, Email=?, Direccion=?, Activo=? WHERE IdProveedor=?";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, p.getNombreEmpresa());
            ps.setString(2, p.getContacto());
            ps.setString(3, p.getTelefono());
            ps.setString(4, p.getEmail());
            ps.setString(5, p.getDireccion());
            ps.setBoolean(6, p.isActivo());
            ps.setInt(7, p.getIdProveedor());
            ps.executeUpdate();
        }
    }

    public void eliminar(int id) throws SQLException {
        String sql = "UPDATE Proveedor SET Activo = 0 WHERE IdProveedor = ?";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
