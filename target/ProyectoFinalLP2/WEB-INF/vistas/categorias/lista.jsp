<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Categoria" %>
<%@ page import="java.util.List" %>
<%
    List<Categoria> lista = (List<Categoria>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categorías</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark bg-primary mb-4"><div class="container"><a class="navbar-brand" href="${pageContext.request.contextPath}/inicio">ProyectoFinalLP2</a></div></nav>
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Categorías</h2>
        <a href="${pageContext.request.contextPath}/categorias?accion=nuevo" class="btn btn-success">Nueva categoría</a>
    </div>
    <table class="table table-striped table-hover">
        <thead class="table-primary"><tr><th>ID</th><th>Unidad</th><th>Nombre</th><th>Descripción</th><th>Activo</th><th>Acciones</th></tr></thead>
        <tbody>
        <% if (lista != null) for (Categoria c : lista) { %>
        <tr>
            <td><%= c.getIdCategoria() %></td>
            <td><%= c.getNombreUnidad() %></td>
            <td><%= c.getNombre() %></td>
            <td><%= c.getDescripcion() %></td>
            <td><%= c.isActivo() ? "Sí" : "No" %></td>
            <td>
                <a href="${pageContext.request.contextPath}/categorias?accion=editar&id=<%= c.getIdCategoria() %>" class="btn btn-sm btn-warning">Editar</a>
                <a href="${pageContext.request.contextPath}/categorias?accion=eliminar&id=<%= c.getIdCategoria() %>" class="btn btn-sm btn-danger" onclick="return confirm('¿Desactivar?')">Eliminar</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/inicio" class="btn btn-secondary">Menú</a>
</div>
</body>
</html>
