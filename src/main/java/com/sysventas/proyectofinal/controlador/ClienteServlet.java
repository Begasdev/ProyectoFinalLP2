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

            String q = request.getParameter("q");
            int pagina = 1;
            try { pagina = Integer.parseInt(request.getParameter("pagina")); } catch (NumberFormatException ignored) { }
            if (pagina < 1) pagina = 1;
            int tamano = 10;

            List<Cliente> lista = dao.listar(q, pagina, tamano);
            int total = dao.contar(q);
            int totalPaginas = (int) Math.ceil((double) total / tamano);

            request.setAttribute("lista", lista);
            request.setAttribute("total", total);
            request.setAttribute("pagina", pagina);
            request.setAttribute("tamano", tamano);
            request.setAttribute("totalPaginas", totalPaginas);
            request.setAttribute("q", q);
            request.getRequestDispatcher("/WEB-INF/vistas/clientes/lista.jsp").forward(request, response);
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
                request.getSession().setAttribute("flashTexto", "Cliente desactivado correctamente.");
            } catch (SQLException e) {
                getServletContext().log("Error al eliminar cliente", e);
                request.getSession().setAttribute("flashTipo", "error");
                request.getSession().setAttribute("flashTexto", "No se pudo desactivar: el cliente tiene registros asociados.");
            }
            response.sendRedirect(request.getContextPath() + "/clientes");
            return;
        }
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
                request.getSession().setAttribute("flashTipo", "success");
                request.getSession().setAttribute("flashTexto", "Cliente creado correctamente.");
            } else {
                c.setIdCliente(Integer.parseInt(idStr));
                dao.actualizar(c);
                request.getSession().setAttribute("flashTipo", "success");
                request.getSession().setAttribute("flashTexto", "Cliente actualizado correctamente.");
            }
        } catch (SQLException e) {
            getServletContext().log("Error al guardar cliente", e);
            request.getSession().setAttribute("flashTipo", "error");
            request.getSession().setAttribute("flashTexto", "No se pudo guardar el cliente.");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("flashTipo", "error");
            request.getSession().setAttribute("flashTexto", "Datos inválidos.");
        }
        response.sendRedirect(request.getContextPath() + "/clientes");
    }
}
