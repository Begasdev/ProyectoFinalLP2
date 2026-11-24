<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Cliente" %>
<%
    Cliente c = (Cliente) request.getAttribute("cliente");
    boolean esEdicion = (c != null);
%>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Cliente</title></head>
<body>
<h1><%= esEdicion ? "Editar" : "Nuevo" %> cliente</h1>
<form action="${pageContext.request.contextPath}/clientes" method="post">
    <% if (esEdicion) { %>
    <input type="hidden" name="idCliente" value="<%= c.getIdCliente() %>">
    <% } %>
    <label>Nombre: <input type="text" name="nombre" value="<%= esEdicion ? c.getNombre() : "" %>" required></label><br>
    <label>Apellido: <input type="text" name="apellido" value="<%= esEdicion ? c.getApellido() : "" %>"></label><br>
    <label>Teléfono: <input type="text" name="telefono" value="<%= esEdicion ? c.getTelefono() : "" %>"></label><br>
    <label>Email: <input type="email" name="email" value="<%= esEdicion ? c.getEmail() : "" %>"></label><br>
    <label>Dirección: <input type="text" name="direccion" value="<%= esEdicion ? c.getDireccion() : "" %>"></label><br>
    <label>Activo: <input type="checkbox" name="activo" <%= (esEdicion && c.isActivo()) || !esEdicion ? "checked" : "" %>></label><br>
    <button type="submit">Guardar</button>
    <a href="${pageContext.request.contextPath}/clientes">Cancelar</a>
</form>
</body>
</html>
