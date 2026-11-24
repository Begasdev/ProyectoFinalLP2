package com.sysventas.proyectofinal.dao;

import com.sysventas.proyectofinal.config.ConexionDB;
import com.sysventas.proyectofinal.model.UnidadMedida;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UnidadMedidaDAO {

    public List<UnidadMedida> listar() throws SQLException {
        List<UnidadMedida> lista = new ArrayList<>();
        String sql = "SELECT IdUnidadMedida, Nombre, Abreviatura, Activo FROM UnidadMedida ORDER BY IdUnidadMedida";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                UnidadMedida u = new UnidadMedida();
                u.setIdUnidadMedida(rs.getInt("IdUnidadMedida"));
                u.setNombre(rs.getString("Nombre"));
                u.setAbreviatura(rs.getString("Abreviatura"));
                u.setActivo(rs.getBoolean("Activo"));
                lista.add(u);
            }
        }
        return lista;
    }

    public void insertar(UnidadMedida u) throws SQLException {
        String sql = "INSERT INTO UnidadMedida (Nombre, Abreviatura, Activo) VALUES (?,?,?)";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getAbreviatura());
            ps.setBoolean(3, u.isActivo());
            ps.executeUpdate();
        }
    }

    public void actualizar(UnidadMedida u) throws SQLException {
        String sql = "UPDATE UnidadMedida SET Nombre=?, Abreviatura=?, Activo=? WHERE IdUnidadMedida=?";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getAbreviatura());
            ps.setBoolean(3, u.isActivo());
            ps.setInt(4, u.getIdUnidadMedida());
            ps.executeUpdate();
        }
    }

    public void eliminar(int id) throws SQLException {
        String sql = "UPDATE UnidadMedida SET Activo = 0 WHERE IdUnidadMedida = ?";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
