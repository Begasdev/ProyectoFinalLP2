<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Producto" %>
<%@ page import="java.util.List" %>
<%
    List<Producto> lista = (List<Producto>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark bg-primary mb-4"><div class="container"><a class="navbar-brand" href="${pageContext.request.contextPath}/inicio">ProyectoFinalLP2</a></div></nav>
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Productos</h2>
        <a href="${pageContext.request.contextPath}/productos?accion=nuevo" class="btn btn-success">Nuevo producto</a>
    </div>
    <table class="table table-striped table-hover">
        <thead class="table-primary"><tr><th>ID</th><th>Categoría</th><th>Código</th><th>Descripción</th><th>P.Compra</th><th>P.Venta</th><th>Cantidad</th><th>Activo</th><th>Acciones</th></tr></thead>
        <tbody>
        <% if (lista != null) for (Producto p : lista) { %>
        <tr>
            <td><%= p.getIdProducto() %></td>
            <td><%= p.getNombreCategoria() %></td>
            <td><%= p.getCodigo() %></td>
            <td><%= p.getDescripcion() %></td>
            <td><%= p.getPrecioCompra() %></td>
            <td><%= p.getPrecioVenta() %></td>
            <td><%= p.getCantidad() %></td>
            <td><%= p.isActivo() ? "Sí" : "No" %></td>
            <td>
                <a href="${pageContext.request.contextPath}/productos?accion=editar&id=<%= p.getIdProducto() %>" class="btn btn-sm btn-warning">Editar</a>
                <a href="${pageContext.request.contextPath}/productos?accion=eliminar&id=<%= p.getIdProducto() %>" class="btn btn-sm btn-danger" onclick="return confirm('¿Desactivar?')">Eliminar</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/inicio" class="btn btn-secondary">Menú</a>
</div>
</body>
</html>
