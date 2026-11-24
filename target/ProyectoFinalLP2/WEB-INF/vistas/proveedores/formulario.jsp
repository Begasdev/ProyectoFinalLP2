<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Proveedor" %>
<%
    Proveedor p = (Proveedor) request.getAttribute("proveedor");
    boolean esEdicion = (p != null);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proveedor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark bg-primary mb-4"><div class="container"><a class="navbar-brand" href="${pageContext.request.contextPath}/inicio">ProyectoFinalLP2</a></div></nav>
<div class="container">
    <h2><%= esEdicion ? "Editar" : "Nuevo" %> proveedor</h2>
    <form action="${pageContext.request.contextPath}/proveedores" method="post" class="mt-3">
        <% if (esEdicion) { %>
        <input type="hidden" name="idProveedor" value="<%= p.getIdProveedor() %>">
        <% } %>
        <div class="mb-3">
            <label class="form-label">Empresa</label>
            <input type="text" name="nombreEmpresa" class="form-control" value="<%= esEdicion ? p.getNombreEmpresa() : "" %>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Contacto</label>
            <input type="text" name="contacto" class="form-control" value="<%= esEdicion ? p.getContacto() : "" %>">
        </div>
        <div class="mb-3">
            <label class="form-label">Teléfono</label>
            <input type="text" name="telefono" class="form-control" value="<%= esEdicion ? p.getTelefono() : "" %>">
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" value="<%= esEdicion ? p.getEmail() : "" %>">
        </div>
        <div class="mb-3">
            <label class="form-label">Dirección</label>
            <input type="text" name="direccion" class="form-control" value="<%= esEdicion ? p.getDireccion() : "" %>">
        </div>
        <div class="form-check mb-3">
            <input type="checkbox" name="activo" class="form-check-input" id="activo" <%= (esEdicion && p.isActivo()) || !esEdicion ? "checked" : "" %>>
            <label class="form-check-label" for="activo">Activo</label>
        </div>
        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="${pageContext.request.contextPath}/proveedores" class="btn btn-secondary">Cancelar</a>
    </form>
</div>
</body>
</html>
