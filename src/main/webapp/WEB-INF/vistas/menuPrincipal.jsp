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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/inicio">ProyectoFinalLP2</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/unidades">Unidades</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/categorias">Categorías</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/productos">Productos</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/clientes">Clientes</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/proveedores">Proveedores</a></li>
            </ul>
            <span class="navbar-text me-3"><%= u.getNombreCompleto() %> (<%= u.getNombreRol() %>)</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">Salir</a>
        </div>
    </div>
</nav>
<div class="container mt-4">
    <h2>Bienvenido, <%= u.getNombreCompleto() %></h2>
    <p class="text-muted">Selecciona un módulo del menú superior.</p>
    <div class="row g-3">
        <div class="col-md-4"><div class="card"><div class="card-body"><h5 class="card-title">Unidades</h5><a href="${pageContext.request.contextPath}/unidades" class="btn btn-primary btn-sm">Ir</a></div></div></div>
        <div class="col-md-4"><div class="card"><div class="card-body"><h5 class="card-title">Categorías</h5><a href="${pageContext.request.contextPath}/categorias" class="btn btn-primary btn-sm">Ir</a></div></div></div>
        <div class="col-md-4"><div class="card"><div class="card-body"><h5 class="card-title">Productos</h5><a href="${pageContext.request.contextPath}/productos" class="btn btn-primary btn-sm">Ir</a></div></div></div>
        <div class="col-md-4"><div class="card"><div class="card-body"><h5 class="card-title">Clientes</h5><a href="${pageContext.request.contextPath}/clientes" class="btn btn-primary btn-sm">Ir</a></div></div></div>
        <div class="col-md-4"><div class="card"><div class="card-body"><h5 class="card-title">Proveedores</h5><a href="${pageContext.request.contextPath}/proveedores" class="btn btn-primary btn-sm">Ir</a></div></div></div>
    </div>
</div>
</body>
</html>
