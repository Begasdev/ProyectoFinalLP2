<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Categoria" %>
<%@ page import="com.sysventas.proyectofinal.model.UnidadMedida" %>
<%@ page import="java.util.List" %>
<%
    Categoria c = (Categoria) request.getAttribute("categoria");
    List<UnidadMedida> unidades = (List<UnidadMedida>) request.getAttribute("unidades");
    boolean esEdicion = (c != null);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categoría</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark bg-primary mb-4"><div class="container"><a class="navbar-brand" href="${pageContext.request.contextPath}/inicio">ProyectoFinalLP2</a></div></nav>
<div class="container">
    <h2><%= esEdicion ? "Editar" : "Nueva" %> categoría</h2>
    <form action="${pageContext.request.contextPath}/categorias" method="post" class="mt-3">
        <% if (esEdicion) { %>
        <input type="hidden" name="idCategoria" value="<%= c.getIdCategoria() %>">
        <% } %>
        <div class="mb-3">
            <label class="form-label">Unidad de medida</label>
            <select name="idUnidadMedida" class="form-select" required>
                <% if (unidades != null) for (UnidadMedida u : unidades) { %>
                <option value="<%= u.getIdUnidadMedida() %>" <%= (esEdicion && c.getIdUnidadMedida() == u.getIdUnidadMedida()) ? "selected" : "" %>><%= u.getNombre() %></option>
                <% } %>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" name="nombre" class="form-control" value="<%= esEdicion ? c.getNombre() : "" %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Descripción</label>
            <input type="text" name="descripcion" class="form-control" value="<%= esEdicion ? c.getDescripcion() : "" %>">
        </div>
        <div class="form-check mb-3">
            <input type="checkbox" name="activo" class="form-check-input" id="activo" <%= (esEdicion && c.isActivo()) || !esEdicion ? "checked" : "" %>>
            <label class="form-check-label" for="activo">Activo</label>
        </div>
        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="${pageContext.request.contextPath}/categorias" class="btn btn-secondary">Cancelar</a>
    </form>
</div>
</body>
</html>
