<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Producto" %>
<%@ page import="com.sysventas.proyectofinal.model.Categoria" %>
<%@ page import="java.util.List" %>
<%
    Producto p = (Producto) request.getAttribute("producto");
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
    boolean esEdicion = (p != null);
%>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Producto</title></head>
<body>
<h1><%= esEdicion ? "Editar" : "Nuevo" %> producto</h1>
<form action="${pageContext.request.contextPath}/productos" method="post">
    <% if (esEdicion) { %>
    <input type="hidden" name="idProducto" value="<%= p.getIdProducto() %>">
    <% } %>
    <label>Categoría:
        <select name="idCategoria" required>
            <% if (categorias != null) for (Categoria c : categorias) { %>
            <option value="<%= c.getIdCategoria() %>" <%= (esEdicion && p.getIdCategoria() == c.getIdCategoria()) ? "selected" : "" %>><%= c.getNombre() %></option>
            <% } %>
        </select>
    </label><br>
    <label>Código: <input type="text" name="codigo" value="<%= esEdicion ? p.getCodigo() : "" %>" required></label><br>
    <label>Descripción: <input type="text" name="descripcion" value="<%= esEdicion ? p.getDescripcion() : "" %>" required></label><br>
    <label>Precio compra: <input type="number" step="0.01" name="precioCompra" value="<%= esEdicion ? p.getPrecioCompra() : "" %>" required></label><br>
    <label>Precio venta: <input type="number" step="0.01" name="precioVenta" value="<%= esEdicion ? p.getPrecioVenta() : "" %>" required></label><br>
    <label>Cantidad: <input type="number" name="cantidad" value="<%= esEdicion ? p.getCantidad() : 0 %>" required></label><br>
    <label>Activo: <input type="checkbox" name="activo" <%= (esEdicion && p.isActivo()) || !esEdicion ? "checked" : "" %>></label><br>
    <button type="submit">Guardar</button>
    <a href="${pageContext.request.contextPath}/productos">Cancelar</a>
</form>
</body>
</html>
