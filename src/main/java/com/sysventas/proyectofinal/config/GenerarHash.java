package com.sysventas.proyectofinal.config;

import org.mindrot.jbcrypt.BCrypt;

public class GenerarHash {
    public static void main(String[] args) {
        String[] claves = { "admin123", "empleado123" };
        for (String c : claves) {
            System.out.println(c + " -> " + BCrypt.hashpw(c, BCrypt.gensalt(10)));
        }
    }
}
