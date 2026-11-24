package com.sysventas.proyectofinal.config;

import java.sql.Connection;
import java.sql.SQLException;

public class ProbarConexion {
    public static void main(String[] args) {
        System.out.println("Probando conexion con SQL Server...");
        try (Connection cn = ConexionDB.getConexion()) {
            if (cn != null && !cn.isClosed()) {
                System.out.println("Conexion Exitosa...!");
                System.out.println("Base de Datos: " + cn.getCatalog());
                System.out.println("Servidor: " + cn.getMetaData().getDatabaseProductName());
            }
        } catch (Exception e) {
            System.err.println("Error al conectarse con SQL Server!");
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
    }
}
