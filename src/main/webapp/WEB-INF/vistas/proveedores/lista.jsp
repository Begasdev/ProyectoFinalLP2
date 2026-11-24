<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Proveedor" %>
<%@ page import="java.util.List" %>
<%
    List<Proveedor> lista = (List<Proveedor>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Proveedores</title></head>
<body>
<h1>Proveedores</h1>
<p><a href="${pageContext.request.contextPath}/proveedores?accion=nuevo">Nuevo proveedor</a> | <a href="${pageContext.request.contextPath}/inicio">Menú</a></p>
<table border="1" cellpadding="5">
    <tr><th>ID</th><th>Empresa</th><th>Contacto</th><th>Teléfono</th><th>Email</th><th>Dirección</th><th>Activo</th><th>Acciones</th></tr>
    <% if (lista != null) for (Proveedor p : lista) { %>
    <tr>
        <td><%= p.getIdProveedor() %></td>
        <td><%= p.getNombreEmpresa() %></td>
        <td><%= p.getContacto() %></td>
        <td><%= p.getTelefono() %></td>
        <td><%= p.getEmail() %></td>
        <td><%= p.getDireccion() %></td>
        <td><%= p.isActivo() %></td>
        <td>
            <a href="${pageContext.request.contextPath}/proveedores?accion=editar&id=<%= p.getIdProveedor() %>">Editar</a>
            <a href="${pageContext.request.contextPath}/proveedores?accion=eliminar&id=<%= p.getIdProveedor() %>" onclick="return confirm('¿Desactivar?')">Eliminar</a>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>
