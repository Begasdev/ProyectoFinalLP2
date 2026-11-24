<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Usuario" %>
<%
    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    int nU = request.getAttribute("nUnidades") != null ? (Integer) request.getAttribute("nUnidades") : 0;
    int nC = request.getAttribute("nCategorias") != null ? (Integer) request.getAttribute("nCategorias") : 0;
    int nP = request.getAttribute("nProductos") != null ? (Integer) request.getAttribute("nProductos") : 0;
    int nCl = request.getAttribute("nClientes") != null ? (Integer) request.getAttribute("nClientes") : 0;
    int nPr = request.getAttribute("nProveedores") != null ? (Integer) request.getAttribute("nProveedores") : 0;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ProyectoFinalLP2</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body class="bg-apple">
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/inicio">
            <i class="fa-solid fa-cart-shopping me-2"></i>ProyectoFinalLP2
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="nav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/unidades"><i class="fa-solid fa-ruler me-1"></i>Unidades</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/categorias"><i class="fa-solid fa-tags me-1"></i>Categorías</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/productos"><i class="fa-solid fa-box me-1"></i>Productos</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/clientes"><i class="fa-solid fa-users me-1"></i>Clientes</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/proveedores"><i class="fa-solid fa-truck me-1"></i>Proveedores</a></li>
                <li class="nav-item ms-3">
                    <span class="text-muted small"><i class="fa-solid fa-user me-1"></i><%= u.getNombreCompleto() %></span>
                </li>
                <li class="nav-item ms-2">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm"><i class="fa-solid fa-right-from-bracket"></i></a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container py-4">
    <div class="mb-4 fade-in">
        <h1 class="fw-bold">Hola, <%= u.getNombreCompleto().split(" ")[0] %> <i class="fa-solid fa-hand-wave text-warning"></i></h1>
        <p class="text-muted">Bienvenido a tu panel de control.</p>
    </div>

    <div class="row g-4 mb-4">
        <div class="col-md-4 col-lg-2">
            <div class="card apple-card text-center p-3 fade-in">
                <i class="fa-solid fa-ruler fa-2x text-primary mb-2"></i>
                <h3 class="fw-bold mb-0"><%= nU %></h3>
                <small class="text-muted">Unidades</small>
            </div>
        </div>
        <div class="col-md-4 col-lg-2">
            <div class="card apple-card text-center p-3 fade-in">
                <i class="fa-solid fa-tags fa-2x text-success mb-2"></i>
                <h3 class="fw-bold mb-0"><%= nC %></h3>
                <small class="text-muted">Categorías</small>
            </div>
        </div>
        <div class="col-md-4 col-lg-2">
            <div class="card apple-card text-center p-3 fade-in">
                <i class="fa-solid fa-box fa-2x text-warning mb-2"></i>
                <h3 class="fw-bold mb-0"><%= nP %></h3>
                <small class="text-muted">Productos</small>
            </div>
        </div>
        <div class="col-md-4 col-lg-2">
            <div class="card apple-card text-center p-3 fade-in">
                <i class="fa-solid fa-users fa-2x text-info mb-2"></i>
                <h3 class="fw-bold mb-0"><%= nCl %></h3>
                <small class="text-muted">Clientes</small>
            </div>
        </div>
        <div class="col-md-4 col-lg-2">
            <div class="card apple-card text-center p-3 fade-in">
                <i class="fa-solid fa-truck fa-2x text-danger mb-2"></i>
                <h3 class="fw-bold mb-0"><%= nPr %></h3>
                <small class="text-muted">Proveedores</small>
            </div>
        </div>
    </div>

    <h4 class="mb-3">Módulos</h4>
    <div class="row g-3">
        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/unidades" class="text-decoration-none">
                <div class="card apple-card module-card p-4 fade-in">
                    <i class="fa-solid fa-ruler fa-2x text-primary mb-2"></i>
                    <h5 class="fw-bold">Unidades de medida</h5>
                    <p class="text-muted small mb-0">Gestiona las unidades de medida de los productos.</p>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/categorias" class="text-decoration-none">
                <div class="card apple-card module-card p-4 fade-in">
                    <i class="fa-solid fa-tags fa-2x text-success mb-2"></i>
                    <h5 class="fw-bold">Categorías</h5>
                    <p class="text-muted small mb-0">Organiza los productos por categorías.</p>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/productos" class="text-decoration-none">
                <div class="card apple-card module-card p-4 fade-in">
                    <i class="fa-solid fa-box fa-2x text-warning mb-2"></i>
                    <h5 class="fw-bold">Productos</h5>
                    <p class="text-muted small mb-0">Inventario y precios de productos.</p>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/clientes" class="text-decoration-none">
                <div class="card apple-card module-card p-4 fade-in">
                    <i class="fa-solid fa-users fa-2x text-info mb-2"></i>
                    <h5 class="fw-bold">Clientes</h5>
                    <p class="text-muted small mb-0">Administración de clientes.</p>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/proveedores" class="text-decoration-none">
                <div class="card apple-card module-card p-4 fade-in">
                    <i class="fa-solid fa-truck fa-2x text-danger mb-2"></i>
                    <h5 class="fw-bold">Proveedores</h5>
                    <p class="text-muted small mb-0">Administración de proveedores.</p>
                </div>
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
