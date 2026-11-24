<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.UnidadMedida" %>
<%@ page import="java.util.List" %>
<%
    List<UnidadMedida> lista = (List<UnidadMedida>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Unidades de medida</title></head>
<body>
<h1>Unidades de medida</h1>
<p><a href="${pageContext.request.contextPath}/unidades?accion=nuevo">Nueva unidad</a> | <a href="${pageContext.request.contextPath}/inicio">Menú</a></p>
<table border="1" cellpadding="5">
    <tr><th>ID</th><th>Nombre</th><th>Abreviatura</th><th>Activo</th><th>Acciones</th></tr>
    <% if (lista != null) for (UnidadMedida u : lista) { %>
    <tr>
        <td><%= u.getIdUnidadMedida() %></td>
        <td><%= u.getNombre() %></td>
        <td><%= u.getAbreviatura() %></td>
        <td><%= u.isActivo() %></td>
        <td>
            <a href="${pageContext.request.contextPath}/unidades?accion=editar&id=<%= u.getIdUnidadMedida() %>">Editar</a>
            <a href="${pageContext.request.contextPath}/unidades?accion=eliminar&id=<%= u.getIdUnidadMedida() %>" onclick="return confirm('¿Desactivar?')">Eliminar</a>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>
