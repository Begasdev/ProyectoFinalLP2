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
            if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect(request.getContextPath() + "/proveedores");
                return;
            }
            List<Proveedor> lista = dao.listar();
            request.setAttribute("lista", lista);
            request.getRequestDispatcher("/WEB-INF/vistas/proveedores/lista.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
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
            } else {
                p.setIdProveedor(Integer.parseInt(idStr));
                dao.actualizar(p);
            }
            response.sendRedirect(request.getContextPath() + "/proveedores");
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }
}
