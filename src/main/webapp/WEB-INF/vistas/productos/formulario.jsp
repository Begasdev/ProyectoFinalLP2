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
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark bg-primary mb-4"><div class="container"><a class="navbar-brand" href="${pageContext.request.contextPath}/inicio">ProyectoFinalLP2</a></div></nav>
<div class="container">
    <h2><%= esEdicion ? "Editar" : "Nuevo" %> producto</h2>
    <form action="${pageContext.request.contextPath}/productos" method="post" class="mt-3">
        <% if (esEdicion) { %>
        <input type="hidden" name="idProducto" value="<%= p.getIdProducto() %>">
        <% } %>
        <div class="mb-3">
            <label class="form-label">Categoría</label>
            <select name="idCategoria" class="form-select" required>
                <% if (categorias != null) for (Categoria c : categorias) { %>
                <option value="<%= c.getIdCategoria() %>" <%= (esEdicion && p.getIdCategoria() == c.getIdCategoria()) ? "selected" : "" %>><%= c.getNombre() %></option>
                <% } %>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Código</label>
            <input type="text" name="codigo" class="form-control" value="<%= esEdicion ? p.getCodigo() : "" %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Descripción</label>
            <input type="text" name="descripcion" class="form-control" value="<%= esEdicion ? p.getDescripcion() : "" %>" required>
        </div>
        <div class="row">
            <div class="col-md-4 mb-3">
                <label class="form-label">Precio compra</label>
                <input type="number" step="0.01" name="precioCompra" class="form-control" value="<%= esEdicion ? p.getPrecioCompra() : "" %>" required>
            </div>
            <div class="col-md-4 mb-3">
                <label class="form-label">Precio venta</label>
                <input type="number" step="0.01" name="precioVenta" class="form-control" value="<%= esEdicion ? p.getPrecioVenta() : "" %>" required>
            </div>
            <div class="col-md-4 mb-3">
                <label class="form-label">Cantidad</label>
                <input type="number" name="cantidad" class="form-control" value="<%= esEdicion ? p.getCantidad() : 0 %>" required>
            </div>
        </div>
        <div class="form-check mb-3">
            <input type="checkbox" name="activo" class="form-check-input" id="activo" <%= (esEdicion && p.isActivo()) || !esEdicion ? "checked" : "" %>>
            <label class="form-check-label" for="activo">Activo</label>
        </div>
        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="${pageContext.request.contextPath}/productos" class="btn btn-secondary">Cancelar</a>
    </form>
</div>
</body>
</html>
