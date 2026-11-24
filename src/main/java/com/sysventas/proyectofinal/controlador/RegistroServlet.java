package com.sysventas.proyectofinal.controlador;

import com.sysventas.proyectofinal.dao.AutenticacionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {

    private final AutenticacionDAO dao = new AutenticacionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/vistas/registro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String nombreCompleto = request.getParameter("nombreCompleto");
        String nombreUsuario = request.getParameter("nombreUsuario");
        String clave = request.getParameter("clave");
        String confirma = request.getParameter("confirmarClave");

        if (nombreCompleto == null || nombreCompleto.isBlank() ||
            nombreUsuario == null || nombreUsuario.isBlank() ||
            clave == null || clave.isBlank() || confirma == null || confirma.isBlank()) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("/WEB-INF/vistas/registro.jsp").forward(request, response);
            return;
        }
        if (clave.length() < 8) {
            request.setAttribute("error", "La contraseña debe tener al menos 8 caracteres.");
            request.getRequestDispatcher("/WEB-INF/vistas/registro.jsp").forward(request, response);
            return;
        }
        if (!clave.equals(confirma)) {
            request.setAttribute("error", "Las contraseñas no coinciden.");
            request.getRequestDispatcher("/WEB-INF/vistas/registro.jsp").forward(request, response);
            return;
        }
        try {
            if (dao.existeUsuario(nombreUsuario.trim())) {
                request.setAttribute("error", "El nombre de usuario ya existe.");
                request.getRequestDispatcher("/WEB-INF/vistas/registro.jsp").forward(request, response);
                return;
            }
            dao.registrar(nombreCompleto.trim(), nombreUsuario.trim(), clave);
            request.getSession().setAttribute("flashTipo", "success");
            request.getSession().setAttribute("flashTexto", "Cuenta creada correctamente. Inicia sesión.");
            response.sendRedirect(request.getContextPath() + "/login");
        } catch (SQLException e) {
            getServletContext().log("Error al registrar usuario", e);
            request.setAttribute("error", "No se pudo crear la cuenta. Inténtalo más tarde.");
            request.getRequestDispatcher("/WEB-INF/vistas/registro.jsp").forward(request, response);
        }
    }
}
