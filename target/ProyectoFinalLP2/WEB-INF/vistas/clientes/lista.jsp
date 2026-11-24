<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Cliente" %>
<%@ page import="java.util.List" %>
<%
    List<Cliente> lista = (List<Cliente>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark bg-primary mb-4"><div class="container"><a class="navbar-brand" href="${pageContext.request.contextPath}/inicio">ProyectoFinalLP2</a></div></nav>
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Clientes</h2>
        <a href="${pageContext.request.contextPath}/clientes?accion=nuevo" class="btn btn-success">Nuevo cliente</a>
    </div>
    <table class="table table-striped table-hover">
        <thead class="table-primary"><tr><th>ID</th><th>Nombre</th><th>Apellido</th><th>Teléfono</th><th>Email</th><th>Dirección</th><th>Activo</th><th>Acciones</th></tr></thead>
        <tbody>
        <% if (lista != null) for (Cliente c : lista) { %>
        <tr>
            <td><%= c.getIdCliente() %></td>
            <td><%= c.getNombre() %></td>
            <td><%= c.getApellido() %></td>
            <td><%= c.getTelefono() %></td>
            <td><%= c.getEmail() %></td>
            <td><%= c.getDireccion() %></td>
            <td><%= c.isActivo() ? "Sí" : "No" %></td>
            <td>
                <a href="${pageContext.request.contextPath}/clientes?accion=editar&id=<%= c.getIdCliente() %>" class="btn btn-sm btn-warning">Editar</a>
                <a href="${pageContext.request.contextPath}/clientes?accion=eliminar&id=<%= c.getIdCliente() %>" class="btn btn-sm btn-danger" onclick="return confirm('¿Desactivar?')">Eliminar</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/inicio" class="btn btn-secondary">Menú</a>
</div>
</body>
</html>
