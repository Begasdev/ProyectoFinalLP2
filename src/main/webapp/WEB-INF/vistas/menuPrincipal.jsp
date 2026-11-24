<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Usuario" %>
<%
    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Menú principal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<h1>Bienvenido, <%= u.getNombreCompleto() %> (<%= u.getNombreRol() %>)</h1>
<ul>
    <li><a href="${pageContext.request.contextPath}/unidades">Unidades de medida</a></li>
    <li><a href="${pageContext.request.contextPath}/categorias">Categorías</a></li>
    <li><a href="${pageContext.request.contextPath}/productos">Productos</a></li>
    <li><a href="${pageContext.request.contextPath}/clientes">Clientes</a></li>
    <li><a href="${pageContext.request.contextPath}/proveedores">Proveedores</a></li>
    <li><a href="${pageContext.request.contextPath}/logout">Cerrar sesión</a></li>
</ul>
</body>
</html>
