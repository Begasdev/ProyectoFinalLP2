package com.sysventas.proyectofinal.controlador;

import com.sysventas.proyectofinal.dao.UnidadMedidaDAO;
import com.sysventas.proyectofinal.model.UnidadMedida;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/unidades")
public class UnidadMedidaServlet extends HttpServlet {

    private final UnidadMedidaDAO dao = new UnidadMedidaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        try {
            if ("nuevo".equals(accion)) {
                request.getRequestDispatcher("/WEB-INF/vistas/unidades/formulario.jsp").forward(request, response);
                return;
            }
            if ("editar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                UnidadMedida u = dao.listar().stream().filter(x -> x.getIdUnidadMedida() == id).findFirst().orElse(null);
                request.setAttribute("unidad", u);
                request.getRequestDispatcher("/WEB-INF/vistas/unidades/formulario.jsp").forward(request, response);
                return;
            }
            List<UnidadMedida> lista = dao.listar();
            request.setAttribute("lista", lista);
            request.getRequestDispatcher("/WEB-INF/vistas/unidades/lista.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                dao.eliminar(id);
                request.getSession().setAttribute("flashTipo", "success");
                request.getSession().setAttribute("flashTexto", "Unidad desactivada correctamente.");
            } catch (SQLException e) {
                getServletContext().log("Error al eliminar unidad", e);
                request.getSession().setAttribute("flashTipo", "error");
                request.getSession().setAttribute("flashTexto", "No se pudo desactivar: la unidad tiene registros asociados.");
            }
            response.sendRedirect(request.getContextPath() + "/unidades");
            return;
        }
        String idStr = request.getParameter("idUnidadMedida");
        try {
            UnidadMedida u = new UnidadMedida();
            u.setNombre(request.getParameter("nombre"));
            u.setAbreviatura(request.getParameter("abreviatura"));
            u.setActivo(request.getParameter("activo") != null);
            if (idStr == null || idStr.isBlank()) {
                dao.insertar(u);
                request.getSession().setAttribute("flashTipo", "success");
                request.getSession().setAttribute("flashTexto", "Unidad creada correctamente.");
            } else {
                u.setIdUnidadMedida(Integer.parseInt(idStr));
                dao.actualizar(u);
                request.getSession().setAttribute("flashTipo", "success");
                request.getSession().setAttribute("flashTexto", "Unidad actualizada correctamente.");
            }
        } catch (SQLException e) {
            getServletContext().log("Error al guardar unidad", e);
            request.getSession().setAttribute("flashTipo", "error");
            request.getSession().setAttribute("flashTexto", "No se pudo guardar la unidad.");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("flashTipo", "error");
            request.getSession().setAttribute("flashTexto", "Datos inválidos.");
        }
        response.sendRedirect(request.getContextPath() + "/unidades");
    }
}
