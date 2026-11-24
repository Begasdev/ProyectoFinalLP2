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
    public static final int STOCK_MINIMO = 10;

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

            String q = request.getParameter("q");
            String catStr = request.getParameter("categoria");
            Integer categoriaId = (catStr != null && !catStr.isBlank()) ? Integer.parseInt(catStr) : null;
            int pagina = 1;
            try { pagina = Integer.parseInt(request.getParameter("pagina")); } catch (NumberFormatException ignored) { }
            if (pagina < 1) pagina = 1;
            int tamano = 10;

            List<Producto> lista = dao.listar(q, categoriaId, pagina, tamano);
            int total = dao.contar(q, categoriaId);
            int totalPaginas = (int) Math.ceil((double) total / tamano);

            request.setAttribute("lista", lista);
            request.setAttribute("total", total);
            request.setAttribute("pagina", pagina);
            request.setAttribute("tamano", tamano);
            request.setAttribute("totalPaginas", totalPaginas);
            request.setAttribute("q", q);
            request.setAttribute("categoria", catStr);
            request.setAttribute("categorias", categoriaDAO.listar());
            request.getRequestDispatcher("/WEB-INF/vistas/productos/lista.jsp").forward(request, response);
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
                request.getSession().setAttribute("flashTexto", "Producto desactivado correctamente.");
            } catch (SQLException e) {
                getServletContext().log("Error al eliminar producto", e);
                request.getSession().setAttribute("flashTipo", "error");
                request.getSession().setAttribute("flashTexto", "No se pudo desactivar: el producto tiene registros asociados.");
            }
            response.sendRedirect(request.getContextPath() + "/productos");
            return;
        }
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
                request.getSession().setAttribute("flashTipo", "success");
                request.getSession().setAttribute("flashTexto", "Producto creado correctamente.");
            } else {
                p.setIdProducto(Integer.parseInt(idStr));
                dao.actualizar(p);
                request.getSession().setAttribute("flashTipo", "success");
                request.getSession().setAttribute("flashTexto", "Producto actualizado correctamente.");
            }
            response.sendRedirect(request.getContextPath() + "/productos");
        } catch (SQLException e) {
            getServletContext().log("Error al guardar producto", e);
            request.getSession().setAttribute("flashTipo", "error");
            request.getSession().setAttribute("flashTexto", "No se pudo guardar el producto.");
            response.sendRedirect(request.getContextPath() + "/productos");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("flashTipo", "error");
            request.getSession().setAttribute("flashTexto", "Datos inválidos.");
            response.sendRedirect(request.getContextPath() + "/productos");
        }
    }
}
