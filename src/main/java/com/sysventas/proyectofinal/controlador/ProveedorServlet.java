package com.sysventas.proyectofinal.controlador;

import com.sysventas.proyectofinal.dao.ProveedorDAO;
import com.sysventas.proyectofinal.model.Proveedor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/proveedores")
public class ProveedorServlet extends HttpServlet {

    private final ProveedorDAO dao = new ProveedorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        try {
            if ("nuevo".equals(accion)) {
                request.getRequestDispatcher("/WEB-INF/vistas/proveedores/formulario.jsp").forward(request, response);
                return;
            }
            if ("editar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Proveedor p = dao.listar().stream().filter(x -> x.getIdProveedor() == id).findFirst().orElse(null);
                request.setAttribute("proveedor", p);
                request.getRequestDispatcher("/WEB-INF/vistas/proveedores/formulario.jsp").forward(request, response);
                return;
            }

            String q = request.getParameter("q");
            int pagina = 1;
            try { pagina = Integer.parseInt(request.getParameter("pagina")); } catch (NumberFormatException ignored) { }
            if (pagina < 1) pagina = 1;
            int tamano = 10;

            List<Proveedor> lista = dao.listar(q, pagina, tamano);
            int total = dao.contar(q);
            int totalPaginas = (int) Math.ceil((double) total / tamano);

            request.setAttribute("lista", lista);
            request.setAttribute("total", total);
            request.setAttribute("pagina", pagina);
            request.setAttribute("tamano", tamano);
            request.setAttribute("totalPaginas", totalPaginas);
            request.setAttribute("q", q);
            request.getRequestDispatcher("/WEB-INF/vistas/proveedores/lista.jsp").forward(request, response);
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
                request.getSession().setAttribute("flashTexto", "Proveedor desactivado correctamente.");
            } catch (SQLException e) {
                getServletContext().log("Error al eliminar proveedor", e);
                request.getSession().setAttribute("flashTipo", "error");
                request.getSession().setAttribute("flashTexto", "No se pudo desactivar: el proveedor tiene registros asociados.");
            }
            response.sendRedirect(request.getContextPath() + "/proveedores");
            return;
        }
        String idStr = request.getParameter("idProveedor");
        try {
            Proveedor p = new Proveedor();
            p.setNombreEmpresa(request.getParameter("nombreEmpresa"));
            p.setContacto(request.getParameter("contacto"));
            p.setTelefono(request.getParameter("telefono"));
            p.setEmail(request.getParameter("email"));
            p.setDireccion(request.getParameter("direccion"));
            p.setActivo(request.getParameter("activo") != null);
            if (idStr == null || idStr.isBlank()) {
                dao.insertar(p);
                request.getSession().setAttribute("flashTipo", "success");
                request.getSession().setAttribute("flashTexto", "Proveedor creado correctamente.");
            } else {
                p.setIdProveedor(Integer.parseInt(idStr));
                dao.actualizar(p);
                request.getSession().setAttribute("flashTipo", "success");
                request.getSession().setAttribute("flashTexto", "Proveedor actualizado correctamente.");
            }
        } catch (SQLException e) {
            getServletContext().log("Error al guardar proveedor", e);
            request.getSession().setAttribute("flashTipo", "error");
            request.getSession().setAttribute("flashTexto", "No se pudo guardar el proveedor.");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("flashTipo", "error");
            request.getSession().setAttribute("flashTexto", "Datos inválidos.");
        }
        response.sendRedirect(request.getContextPath() + "/proveedores");
    }
}
