<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Proveedor" %>
<%
    Proveedor p = (Proveedor) request.getAttribute("proveedor");
    boolean esEdicion = (p != null);
%>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Proveedor</title></head>
<body>
<h1><%= esEdicion ? "Editar" : "Nuevo" %> proveedor</h1>
<form action="${pageContext.request.contextPath}/proveedores" method="post">
    <% if (esEdicion) { %>
    <input type="hidden" name="idProveedor" value="<%= p.getIdProveedor() %>">
    <% } %>
    <label>Empresa: <input type="text" name="nombreEmpresa" value="<%= esEdicion ? p.getNombreEmpresa() : "" %>" required></label><br>
    <label>Contacto: <input type="text" name="contacto" value="<%= esEdicion ? p.getContacto() : "" %>"></label><br>
    <label>Teléfono: <input type="text" name="telefono" value="<%= esEdicion ? p.getTelefono() : "" %>"></label><br>
    <label>Email: <input type="email" name="email" value="<%= esEdicion ? p.getEmail() : "" %>"></label><br>
    <label>Dirección: <input type="text" name="direccion" value="<%= esEdicion ? p.getDireccion() : "" %>"></label><br>
    <label>Activo: <input type="checkbox" name="activo" <%= (esEdicion && p.isActivo()) || !esEdicion ? "checked" : "" %>></label><br>
    <button type="submit">Guardar</button>
    <a href="${pageContext.request.contextPath}/proveedores">Cancelar</a>
</form>
</body>
</html>
