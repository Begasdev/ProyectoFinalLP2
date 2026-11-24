package com.sysventas.proyectofinal.dao;

import com.sysventas.proyectofinal.config.ConexionDB;
import com.sysventas.proyectofinal.model.Categoria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {

    public List<Categoria> listar() throws SQLException {
        List<Categoria> lista = new ArrayList<>();
        String sql = "SELECT c.IdCategoria, c.IdUnidadMedida, u.Nombre AS NombreUnidad, c.Nombre, c.Descripcion, c.Activo " +
                     "FROM Categoria c INNER JOIN UnidadMedida u ON c.IdUnidadMedida = u.IdUnidadMedida ORDER BY c.IdCategoria";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Categoria c = new Categoria();
                c.setIdCategoria(rs.getInt("IdCategoria"));
                c.setIdUnidadMedida(rs.getInt("IdUnidadMedida"));
                c.setNombreUnidad(rs.getString("NombreUnidad"));
                c.setNombre(rs.getString("Nombre"));
                c.setDescripcion(rs.getString("Descripcion"));
                c.setActivo(rs.getBoolean("Activo"));
                lista.add(c);
            }
        }
        return lista;
    }

    public void insertar(Categoria c) throws SQLException {
        String sql = "INSERT INTO Categoria (IdUnidadMedida, Nombre, Descripcion, Activo) VALUES (?,?,?,?)";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, c.getIdUnidadMedida());
            ps.setString(2, c.getNombre());
            ps.setString(3, c.getDescripcion());
            ps.setBoolean(4, c.isActivo());
            ps.executeUpdate();
        }
    }

    public void actualizar(Categoria c) throws SQLException {
        String sql = "UPDATE Categoria SET IdUnidadMedida=?, Nombre=?, Descripcion=?, Activo=? WHERE IdCategoria=?";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, c.getIdUnidadMedida());
            ps.setString(2, c.getNombre());
            ps.setString(3, c.getDescripcion());
            ps.setBoolean(4, c.isActivo());
            ps.setInt(5, c.getIdCategoria());
            ps.executeUpdate();
        }
    }

    public void eliminar(int id) throws SQLException {
        String sql = "UPDATE Categoria SET Activo = 0 WHERE IdCategoria = ?";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
