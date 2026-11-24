package com.sysventas.proyectofinal.controlador;

import com.sysventas.proyectofinal.dao.AutenticacionDAO;
import com.sysventas.proyectofinal.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cambioClave")
public class CambioClaveServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession(false);
        if (sesion == null || !(sesion.getAttribute("usuario") instanceof Usuario)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/vistas/cambioClave.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession sesion = request.getSession(false);
        if (sesion == null || !(sesion.getAttribute("usuario") instanceof Usuario)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Usuario u = (Usuario) sesion.getAttribute("usuario");
        String nueva = request.getParameter("nuevaClave");
        String confirma = request.getParameter("confirmarClave");
        if (nueva == null || nueva.isBlank() || confirma == null || confirma.isBlank()) {
            request.setAttribute("error", "Debes ingresar la nueva contraseña y su confirmación.");
            request.getRequestDispatcher("/WEB-INF/vistas/cambioClave.jsp").forward(request, response);
            return;
        }
        if (nueva.length() < 8) {
            request.setAttribute("error", "La contraseña debe tener al menos 8 caracteres.");
            request.getRequestDispatcher("/WEB-INF/vistas/cambioClave.jsp").forward(request, response);
            return;
        }
        if (!nueva.equals(confirma)) {
            request.setAttribute("error", "Las contraseñas no coinciden.");
            request.getRequestDispatcher("/WEB-INF/vistas/cambioClave.jsp").forward(request, response);
            return;
        }
        if (org.mindrot.jbcrypt.BCrypt.checkpw(nueva, u.getClave())) {
            request.setAttribute("error", "La nueva contraseña no puede ser igual a la anterior.");
            request.getRequestDispatcher("/WEB-INF/vistas/cambioClave.jsp").forward(request, response);
            return;
        }
        try {
            new AutenticacionDAO().actualizarClave(u.getIdUsuario(), nueva);
            u.setResetearClave(false);
            sesion.setAttribute("usuario", u);
            response.sendRedirect(request.getContextPath() + "/inicio");
        } catch (SQLException e) {
            getServletContext().log("Error al cambiar clave", e);
            request.setAttribute("error", "No se pudo cambiar la contraseña.");
            request.getRequestDispatcher("/WEB-INF/vistas/cambioClave.jsp").forward(request, response);
        }
    }
}
