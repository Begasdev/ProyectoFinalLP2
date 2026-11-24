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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-store");
        HttpSession sesion = request.getSession(false);
        if (sesion != null && sesion.getAttribute("usuario") instanceof Usuario) {
            response.sendRedirect(request.getContextPath() + "/inicio");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/vistas/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-store");

        String nombreUsuario = request.getParameter("nombreUsuario");
        String clave = request.getParameter("clave");

        if (nombreUsuario == null || nombreUsuario.isBlank() || clave == null || clave.isBlank()) {
            request.setAttribute("error", "Debes ingresar el usuario y la contraseña.");
            mostrarLogin(request, response);
            return;
        }

        try {
            AutenticacionDAO dao = new AutenticacionDAO();
            Usuario usuarioAutenticado = dao.autenticar(nombreUsuario.trim(), clave);
            if (usuarioAutenticado == null) {
                request.setAttribute("error", "Usuario o contraseña incorrectos, o cuenta inactiva.");
                mostrarLogin(request, response);
                return;
            }

            HttpSession sesionAnterior = request.getSession(false);
            if (sesionAnterior != null) sesionAnterior.invalidate();

            HttpSession sesion = request.getSession(true);
            sesion.setAttribute("usuario", usuarioAutenticado);

            if (usuarioAutenticado.isResetearClave()) {
                response.sendRedirect(request.getContextPath() + "/cambioClave");
            } else {
                response.sendRedirect(request.getContextPath() + "/inicio");
            }
        } catch (SQLException e) {
            getServletContext().log("Error de SQL Server durante la autenticación.", e);
            request.setAttribute("error", "No se pudo verificar el acceso. Inténtalo más tarde.");
            mostrarLogin(request, response);
        }
    }

    private void mostrarLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/vistas/login.jsp").forward(request, response);
    }
}
