package com.sysventas.proyectofinal.dao;

import com.sysventas.proyectofinal.config.ConexionDB;
import com.sysventas.proyectofinal.model.Usuario;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AutenticacionDAO {

    public Usuario autenticar(String nombreUsuario, String clave) throws SQLException {
        String sql = "SELECT u.IdUsuario, u.IdRol, r.NombreRol, u.NombreCompleto, u.NombreUsuario, u.Clave, u.ResetearClave, u.Activo " +
                     "FROM Usuario u INNER JOIN Rol r ON u.IdRol = r.IdRol WHERE u.NombreUsuario = ? AND u.Activo = 1";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, nombreUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hash = rs.getString("Clave");
                    if (hash != null && BCrypt.checkpw(clave, hash)) {
                        Usuario u = new Usuario();
                        u.setIdUsuario(rs.getInt("IdUsuario"));
                        u.setIdRol(rs.getInt("IdRol"));
                        u.setNombreRol(rs.getString("NombreRol"));
                        u.setNombreCompleto(rs.getString("NombreCompleto"));
                        u.setNombreUsuario(rs.getString("NombreUsuario"));
                        u.setClave(hash);
                        u.setResetearClave(rs.getBoolean("ResetearClave"));
                        u.setActivo(rs.getBoolean("Activo"));
                        return u;
                    }
                }
            }
        }
        return null;
    }

    public void actualizarClave(int idUsuario, String nuevaClave) throws SQLException {
        String sql = "UPDATE Usuario SET Clave = ?, ResetearClave = 0 WHERE IdUsuario = ?";
        try (Connection cn = ConexionDB.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, BCrypt.hashpw(nuevaClave, BCrypt.gensalt(10)));
            ps.setInt(2, idUsuario);
            ps.executeUpdate();
        }
    }
}
