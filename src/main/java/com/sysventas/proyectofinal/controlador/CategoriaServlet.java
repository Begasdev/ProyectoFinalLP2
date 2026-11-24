package com.sysventas.proyectofinal.controlador;

import com.sysventas.proyectofinal.dao.CategoriaDAO;
import com.sysventas.proyectofinal.dao.UnidadMedidaDAO;
import com.sysventas.proyectofinal.model.Categoria;
import com.sysventas.proyectofinal.model.UnidadMedida;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/categorias")
public class CategoriaServlet extends HttpServlet {

    private final CategoriaDAO dao = new CategoriaDAO();
    private final UnidadMedidaDAO unidadDAO = new UnidadMedidaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        try {
            if ("nuevo".equals(accion)) {
                request.setAttribute("unidades", unidadDAO.listar());
                request.getRequestDispatcher("/WEB-INF/vistas/categorias/formulario.jsp").forward(request, response);
                return;
            }
            if ("editar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Categoria c = dao.listar().stream().filter(x -> x.getIdCategoria() == id).findFirst().orElse(null);
                request.setAttribute("categoria", c);
                request.setAttribute("unidades", unidadDAO.listar());
                request.getRequestDispatcher("/WEB-INF/vistas/categorias/formulario.jsp").forward(request, response);
                return;
            }
            if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect(request.getContextPath() + "/categorias");
                return;
            }
            List<Categoria> lista = dao.listar();
            request.setAttribute("lista", lista);
            request.getRequestDispatcher("/WEB-INF/vistas/categorias/lista.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String idStr = request.getParameter("idCategoria");
        try {
            Categoria c = new Categoria();
            c.setIdUnidadMedida(Integer.parseInt(request.getParameter("idUnidadMedida")));
            c.setNombre(request.getParameter("nombre"));
            c.setDescripcion(request.getParameter("descripcion"));
            c.setActivo(request.getParameter("activo") != null);
            if (idStr == null || idStr.isBlank()) {
                dao.insertar(c);
            } else {
                c.setIdCategoria(Integer.parseInt(idStr));
                dao.actualizar(c);
            }
            response.sendRedirect(request.getContextPath() + "/categorias");
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }
}
