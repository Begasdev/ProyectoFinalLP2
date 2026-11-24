package com.sysventas.proyectofinal.controlador;

import com.sysventas.proyectofinal.dao.ClienteDAO;
import com.sysventas.proyectofinal.model.Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/clientes")
public class ClienteServlet extends HttpServlet {

    private final ClienteDAO dao = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        try {
            if ("nuevo".equals(accion)) {
                request.getRequestDispatcher("/WEB-INF/vistas/clientes/formulario.jsp").forward(request, response);
                return;
            }
            if ("editar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Cliente c = dao.listar().stream().filter(x -> x.getIdCliente() == id).findFirst().orElse(null);
                request.setAttribute("cliente", c);
                request.getRequestDispatcher("/WEB-INF/vistas/clientes/formulario.jsp").forward(request, response);
                return;
            }
            if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect(request.getContextPath() + "/clientes");
                return;
            }
            List<Cliente> lista = dao.listar();
            request.setAttribute("lista", lista);
            request.getRequestDispatcher("/WEB-INF/vistas/clientes/lista.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String idStr = request.getParameter("idCliente");
        try {
            Cliente c = new Cliente();
            c.setNombre(request.getParameter("nombre"));
            c.setApellido(request.getParameter("apellido"));
            c.setTelefono(request.getParameter("telefono"));
            c.setEmail(request.getParameter("email"));
            c.setDireccion(request.getParameter("direccion"));
            c.setActivo(request.getParameter("activo") != null);
            if (idStr == null || idStr.isBlank()) {
                dao.insertar(c);
            } else {
                c.setIdCliente(Integer.parseInt(idStr));
                dao.actualizar(c);
            }
            response.sendRedirect(request.getContextPath() + "/clientes");
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }
}
