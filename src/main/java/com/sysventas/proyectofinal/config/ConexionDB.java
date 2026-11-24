package com.sysventas.proyectofinal.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDB {

    private ConexionDB() { }

    public static Connection getConexion() throws SQLException {
        String url = System.getenv("DB_URL");
        String usr = System.getenv("DB_USER");
        String pwd = System.getenv("DB_PASSWORD");

        System.out.println("------------------------------------------");
        System.out.println(" VERIFICACION DE CONEXION SQL SERVER ");
        System.out.println("------------------------------------------");
        System.out.println("DB_URL: " + (url != null && !url.isBlank() ? "OK" : "FALTA"));
        System.out.println("DB_USER: " + (usr != null && !usr.isBlank() ? "OK" : "FALTA"));
        System.out.println("DB_PASSWORD: " + (pwd != null && !pwd.isBlank() ? "OK" : "FALTA"));

        if (url == null || url.isBlank()) throw new SQLException("ERROR: Falta configurar la variable DB_URL.");
        if (usr == null || usr.isBlank()) throw new SQLException("ERROR: Falta configurar la variable DB_USER.");
        if (pwd == null || pwd.isBlank()) throw new SQLException("ERROR: Falta configurar la variable DB_PASSWORD.");

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            System.out.println("CONTROLADOR JDBC SQL SERVER: CARGADO CORRECTAMENTE");
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se encontro el controlador JDBC de SQL Server.", e);
        }

        try {
            Connection conexion = DriverManager.getConnection(url, usr, pwd);
            System.out.println("CONEXION EXITOSA CON SQL SERVER.");
            return conexion;
        } catch (SQLException e) {
            System.err.println("ERROR AL CONECTAR CON SQL SERVER: " + e.getMessage());
            throw e;
        }
    }
}
