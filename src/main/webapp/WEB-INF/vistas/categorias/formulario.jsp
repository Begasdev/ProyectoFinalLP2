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
<head><meta charset="UTF-8"><title>Categoría</title></head>
<body>
<h1><%= esEdicion ? "Editar" : "Nueva" %> categoría</h1>
<form action="${pageContext.request.contextPath}/categorias" method="post">
    <% if (esEdicion) { %>
    <input type="hidden" name="idCategoria" value="<%= c.getIdCategoria() %>">
    <% } %>
    <label>Unidad de medida:
        <select name="idUnidadMedida" required>
            <% if (unidades != null) for (UnidadMedida u : unidades) { %>
            <option value="<%= u.getIdUnidadMedida() %>" <%= (esEdicion && c.getIdUnidadMedida() == u.getIdUnidadMedida()) ? "selected" : "" %>><%= u.getNombre() %></option>
            <% } %>
        </select>
    </label><br>
    <label>Nombre: <input type="text" name="nombre" value="<%= esEdicion ? c.getNombre() : "" %>" required></label><br>
    <label>Descripción: <input type="text" name="descripcion" value="<%= esEdicion ? c.getDescripcion() : "" %>"></label><br>
    <label>Activo: <input type="checkbox" name="activo" <%= (esEdicion && c.isActivo()) || !esEdicion ? "checked" : "" %>></label><br>
    <button type="submit">Guardar</button>
    <a href="${pageContext.request.contextPath}/categorias">Cancelar</a>
</form>
</body>
</html>
