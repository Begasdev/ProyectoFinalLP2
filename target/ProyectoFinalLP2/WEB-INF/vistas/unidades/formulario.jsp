<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.UnidadMedida" %>
<%
    UnidadMedida u = (UnidadMedida) request.getAttribute("unidad");
    boolean esEdicion = (u != null);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unidad de medida</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark bg-primary mb-4"><div class="container"><a class="navbar-brand" href="${pageContext.request.contextPath}/inicio">ProyectoFinalLP2</a></div></nav>
<div class="container">
    <h2><%= esEdicion ? "Editar" : "Nueva" %> unidad de medida</h2>
    <form action="${pageContext.request.contextPath}/unidades" method="post" class="mt-3">
        <% if (esEdicion) { %>
        <input type="hidden" name="idUnidadMedida" value="<%= u.getIdUnidadMedida() %>">
        <% } %>
        <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" name="nombre" class="form-control" value="<%= esEdicion ? u.getNombre() : "" %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Abreviatura</label>
            <input type="text" name="abreviatura" class="form-control" value="<%= esEdicion ? u.getAbreviatura() : "" %>" required>
        </div>
        <div class="form-check mb-3">
            <input type="checkbox" name="activo" class="form-check-input" id="activo" <%= (esEdicion && u.isActivo()) || !esEdicion ? "checked" : "" %>>
            <label class="form-check-label" for="activo">Activo</label>
        </div>
        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="${pageContext.request.contextPath}/unidades" class="btn btn-secondary">Cancelar</a>
    </form>
</div>
</body>
</html>
