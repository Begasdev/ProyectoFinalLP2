package com.sysventas.proyectofinal.controlador;

import com.sysventas.proyectofinal.dao.CategoriaDAO;
import com.sysventas.proyectofinal.dao.ClienteDAO;
import com.sysventas.proyectofinal.dao.ProductoDAO;
import com.sysventas.proyectofinal.dao.ProveedorDAO;
import com.sysventas.proyectofinal.dao.UnidadMedidaDAO;
import com.sysventas.proyectofinal.model.Producto;
import com.sysventas.proyectofinal.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/inicio")
public class InicioServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession(false);
        if (sesion == null || !(sesion.getAttribute("usuario") instanceof Usuario)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        try {
            request.setAttribute("nUnidades", new UnidadMedidaDAO().listar().size());
            request.setAttribute("nCategorias", new CategoriaDAO().listar().size());
            request.setAttribute("nProductos", new ProductoDAO().listar().size());
            request.setAttribute("nClientes", new ClienteDAO().listar().size());
            request.setAttribute("nProveedores", new ProveedorDAO().listar().size());

            ProductoDAO pdao = new ProductoDAO();
            request.setAttribute("stockBajo", pdao.contarStockBajo(ProductoServlet.STOCK_MINIMO));
            request.setAttribute("agotados", pdao.contarAgotados());
            request.setAttribute("valorInventario", pdao.valorInventario());
            request.setAttribute("menosStock", pdao.listarMenosStock(5));
        } catch (SQLException e) {
            getServletContext().log("Error cargando métricas", e);
        }
        request.getRequestDispatcher("/WEB-INF/vistas/menuPrincipal.jsp").forward(request, response);
    }
}
