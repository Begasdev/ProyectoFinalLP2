<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Producto" %>
<%@ page import="java.util.List" %>
<%
    List<Producto> lista = (List<Producto>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Productos</title></head>
<body>
<h1>Productos</h1>
<p><a href="${pageContext.request.contextPath}/productos?accion=nuevo">Nuevo producto</a> | <a href="${pageContext.request.contextPath}/inicio">Menú</a></p>
<table border="1" cellpadding="5">
    <tr><th>ID</th><th>Categoría</th><th>Código</th><th>Descripción</th><th>P.Compra</th><th>P.Venta</th><th>Cantidad</th><th>Activo</th><th>Acciones</th></tr>
    <% if (lista != null) for (Producto p : lista) { %>
    <tr>
        <td><%= p.getIdProducto() %></td>
        <td><%= p.getNombreCategoria() %></td>
        <td><%= p.getCodigo() %></td>
        <td><%= p.getDescripcion() %></td>
        <td><%= p.getPrecioCompra() %></td>
        <td><%= p.getPrecioVenta() %></td>
        <td><%= p.getCantidad() %></td>
        <td><%= p.isActivo() %></td>
        <td>
            <a href="${pageContext.request.contextPath}/productos?accion=editar&id=<%= p.getIdProducto() %>">Editar</a>
            <a href="${pageContext.request.contextPath}/productos?accion=eliminar&id=<%= p.getIdProducto() %>" onclick="return confirm('¿Desactivar?')">Eliminar</a>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>
