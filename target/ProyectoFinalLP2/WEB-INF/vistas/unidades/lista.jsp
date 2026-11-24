<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.UnidadMedida" %>
<%@ page import="java.util.List" %>
<%
    List<UnidadMedida> lista = (List<UnidadMedida>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unidades de medida</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark bg-primary mb-4"><div class="container"><a class="navbar-brand" href="${pageContext.request.contextPath}/inicio">ProyectoFinalLP2</a></div></nav>
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Unidades de medida</h2>
        <a href="${pageContext.request.contextPath}/unidades?accion=nuevo" class="btn btn-success">Nueva unidad</a>
    </div>
    <table class="table table-striped table-hover">
        <thead class="table-primary"><tr><th>ID</th><th>Nombre</th><th>Abreviatura</th><th>Activo</th><th>Acciones</th></tr></thead>
        <tbody>
        <% if (lista != null) for (UnidadMedida u : lista) { %>
        <tr>
            <td><%= u.getIdUnidadMedida() %></td>
            <td><%= u.getNombre() %></td>
            <td><%= u.getAbreviatura() %></td>
            <td><%= u.isActivo() ? "Sí" : "No" %></td>
            <td>
                <a href="${pageContext.request.contextPath}/unidades?accion=editar&id=<%= u.getIdUnidadMedida() %>" class="btn btn-sm btn-warning">Editar</a>
                <a href="${pageContext.request.contextPath}/unidades?accion=eliminar&id=<%= u.getIdUnidadMedida() %>" class="btn btn-sm btn-danger" onclick="return confirm('¿Desactivar?')">Eliminar</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/inicio" class="btn btn-secondary">Menú</a>
</div>
</body>
</html>
