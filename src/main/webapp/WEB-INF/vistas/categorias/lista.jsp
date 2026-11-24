<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Categoria" %>
<%@ page import="java.util.List" %>
<%
    List<Categoria> lista = (List<Categoria>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Categorías</title></head>
<body>
<h1>Categorías</h1>
<p><a href="${pageContext.request.contextPath}/categorias?accion=nuevo">Nueva categoría</a> | <a href="${pageContext.request.contextPath}/inicio">Menú</a></p>
<table border="1" cellpadding="5">
    <tr><th>ID</th><th>Unidad</th><th>Nombre</th><th>Descripción</th><th>Activo</th><th>Acciones</th></tr>
    <% if (lista != null) for (Categoria c : lista) { %>
    <tr>
        <td><%= c.getIdCategoria() %></td>
        <td><%= c.getNombreUnidad() %></td>
        <td><%= c.getNombre() %></td>
        <td><%= c.getDescripcion() %></td>
        <td><%= c.isActivo() %></td>
        <td>
            <a href="${pageContext.request.contextPath}/categorias?accion=editar&id=<%= c.getIdCategoria() %>">Editar</a>
            <a href="${pageContext.request.contextPath}/categorias?accion=eliminar&id=<%= c.getIdCategoria() %>" onclick="return confirm('¿Desactivar?')">Eliminar</a>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>
