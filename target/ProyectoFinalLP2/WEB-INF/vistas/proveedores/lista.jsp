<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Proveedor" %>
<%@ page import="java.util.List" %>
<%
    List<Proveedor> lista = (List<Proveedor>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proveedores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark bg-primary mb-4"><div class="container"><a class="navbar-brand" href="${pageContext.request.contextPath}/inicio">ProyectoFinalLP2</a></div></nav>
<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Proveedores</h2>
        <a href="${pageContext.request.contextPath}/proveedores?accion=nuevo" class="btn btn-success">Nuevo proveedor</a>
    </div>
    <table class="table table-striped table-hover">
        <thead class="table-primary"><tr><th>ID</th><th>Empresa</th><th>Contacto</th><th>Teléfono</th><th>Email</th><th>Dirección</th><th>Activo</th><th>Acciones</th></tr></thead>
        <tbody>
        <% if (lista != null) for (Proveedor p : lista) { %>
        <tr>
            <td><%= p.getIdProveedor() %></td>
            <td><%= p.getNombreEmpresa() %></td>
            <td><%= p.getContacto() %></td>
            <td><%= p.getTelefono() %></td>
            <td><%= p.getEmail() %></td>
            <td><%= p.getDireccion() %></td>
            <td><%= p.isActivo() ? "Sí" : "No" %></td>
            <td>
                <a href="${pageContext.request.contextPath}/proveedores?accion=editar&id=<%= p.getIdProveedor() %>" class="btn btn-sm btn-warning">Editar</a>
                <a href="${pageContext.request.contextPath}/proveedores?accion=eliminar&id=<%= p.getIdProveedor() %>" class="btn btn-sm btn-danger" onclick="return confirm('¿Desactivar?')">Eliminar</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/inicio" class="btn btn-secondary">Menú</a>
</div>
</body>
</html>
