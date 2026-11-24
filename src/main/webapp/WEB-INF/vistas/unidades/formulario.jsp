<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.UnidadMedida" %>
<%
    UnidadMedida u = (UnidadMedida) request.getAttribute("unidad");
    boolean esEdicion = (u != null);
%>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Unidad de medida</title></head>
<body>
<h1><%= esEdicion ? "Editar" : "Nueva" %> unidad de medida</h1>
<form action="${pageContext.request.contextPath}/unidades" method="post">
    <% if (esEdicion) { %>
    <input type="hidden" name="idUnidadMedida" value="<%= u.getIdUnidadMedida() %>">
    <% } %>
    <label>Nombre: <input type="text" name="nombre" value="<%= esEdicion ? u.getNombre() : "" %>" required></label><br>
    <label>Abreviatura: <input type="text" name="abreviatura" value="<%= esEdicion ? u.getAbreviatura() : "" %>" required></label><br>
    <label>Activo: <input type="checkbox" name="activo" <%= (esEdicion && u.isActivo()) || !esEdicion ? "checked" : "" %>></label><br>
    <button type="submit">Guardar</button>
    <a href="${pageContext.request.contextPath}/unidades">Cancelar</a>
</form>
</body>
</html>
