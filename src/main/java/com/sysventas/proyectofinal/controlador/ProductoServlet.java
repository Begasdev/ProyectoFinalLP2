package com.sysventas.proyectofinal.controlador;

import com.sysventas.proyectofinal.dao.CategoriaDAO;
import com.sysventas.proyectofinal.dao.ProductoDAO;
import com.sysventas.proyectofinal.model.Categoria;
import com.sysventas.proyectofinal.model.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/productos")
public class ProductoServlet extends HttpServlet {

    private final ProductoDAO dao = new ProductoDAO();
    private final CategoriaDAO categoriaDAO = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        try {
            if ("nuevo".equals(accion)) {
                request.setAttribute("categorias", categoriaDAO.listar());
                request.getRequestDispatcher("/WEB-INF/vistas/productos/formulario.jsp").forward(request, response);
                return;
            }
            if ("editar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Producto p = dao.listar().stream().filter(x -> x.getIdProducto() == id).findFirst().orElse(null);
                request.setAttribute("producto", p);
                request.setAttribute("categorias", categoriaDAO.listar());
                request.getRequestDispatcher("/WEB-INF/vistas/productos/formulario.jsp").forward(request, response);
                return;
            }
            if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect(request.getContextPath() + "/productos");
                return;
            }
            List<Producto> lista = dao.listar();
            request.setAttribute("lista", lista);
            request.getRequestDispatcher("/WEB-INF/vistas/productos/lista.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String idStr = request.getParameter("idProducto");
        try {
            Producto p = new Producto();
            p.setIdCategoria(Integer.parseInt(request.getParameter("idCategoria")));
            p.setCodigo(request.getParameter("codigo"));
            p.setDescripcion(request.getParameter("descripcion"));
            p.setPrecioCompra(Double.parseDouble(request.getParameter("precioCompra")));
            p.setPrecioVenta(Double.parseDouble(request.getParameter("precioVenta")));
            p.setCantidad(Integer.parseInt(request.getParameter("cantidad")));
            p.setActivo(request.getParameter("activo") != null);
            if (idStr == null || idStr.isBlank()) {
                dao.insertar(p);
            } else {
                p.setIdProducto(Integer.parseInt(idStr));
                dao.actualizar(p);
            }
            response.sendRedirect(request.getContextPath() + "/productos");
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }
}
