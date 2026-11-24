<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Cliente" %>
<%
    Cliente c = (Cliente) request.getAttribute("cliente");
    boolean esEdicion = (c != null);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cliente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark bg-primary mb-4"><div class="container"><a class="navbar-brand" href="${pageContext.request.contextPath}/inicio">ProyectoFinalLP2</a></div></nav>
<div class="container">
    <h2><%= esEdicion ? "Editar" : "Nuevo" %> cliente</h2>
    <form action="${pageContext.request.contextPath}/clientes" method="post" class="mt-3">
        <% if (esEdicion) { %>
        <input type="hidden" name="idCliente" value="<%= c.getIdCliente() %>">
        <% } %>
        <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" name="nombre" class="form-control" value="<%= esEdicion ? c.getNombre() : "" %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Apellido</label>
            <input type="text" name="apellido" class="form-control" value="<%= esEdicion ? c.getApellido() : "" %>">
        </div>
        <div class="mb-3">
            <label class="form-label">Teléfono</label>
            <input type="text" name="telefono" class="form-control" value="<%= esEdicion ? c.getTelefono() : "" %>">
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" value="<%= esEdicion ? c.getEmail() : "" %>">
        </div>
        <div class="mb-3">
            <label class="form-label">Dirección</label>
            <input type="text" name="direccion" class="form-control" value="<%= esEdicion ? c.getDireccion() : "" %>">
        </div>
        <div class="form-check mb-3">
            <input type="checkbox" name="activo" class="form-check-input" id="activo" <%= (esEdicion && c.isActivo()) || !esEdicion ? "checked" : "" %>>
            <label class="form-check-label" for="activo">Activo</label>
        </div>
        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="${pageContext.request.contextPath}/clientes" class="btn btn-secondary">Cancelar</a>
    </form>
</div>
</body>
</html>
