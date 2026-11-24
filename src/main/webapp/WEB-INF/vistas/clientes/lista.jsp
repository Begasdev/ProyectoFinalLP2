<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Cliente" %>
<%@ page import="java.util.List" %>
<%
    List<Cliente> lista = (List<Cliente>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Clientes</title></head>
<body>
<h1>Clientes</h1>
<p><a href="${pageContext.request.contextPath}/clientes?accion=nuevo">Nuevo cliente</a> | <a href="${pageContext.request.contextPath}/inicio">Menú</a></p>
<table border="1" cellpadding="5">
    <tr><th>ID</th><th>Nombre</th><th>Apellido</th><th>Teléfono</th><th>Email</th><th>Dirección</th><th>Activo</th><th>Acciones</th></tr>
    <% if (lista != null) for (Cliente c : lista) { %>
    <tr>
        <td><%= c.getIdCliente() %></td>
        <td><%= c.getNombre() %></td>
        <td><%= c.getApellido() %></td>
        <td><%= c.getTelefono() %></td>
        <td><%= c.getEmail() %></td>
        <td><%= c.getDireccion() %></td>
        <td><%= c.isActivo() %></td>
        <td>
            <a href="${pageContext.request.contextPath}/clientes?accion=editar&id=<%= c.getIdCliente() %>">Editar</a>
            <a href="${pageContext.request.contextPath}/clientes?accion=eliminar&id=<%= c.getIdCliente() %>" onclick="return confirm('¿Desactivar?')">Eliminar</a>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>
