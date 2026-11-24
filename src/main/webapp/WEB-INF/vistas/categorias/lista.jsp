<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Categoria" %>
<%@ page import="java.util.List" %>
<%
    List<Categoria> lista = (List<Categoria>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categorías</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body class="bg-apple">
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/inicio"><i class="fa-solid fa-cart-shopping me-2"></i>ProyectoFinalLP2</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/inicio"><i class="fa-solid fa-house me-1"></i>Inicio</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container py-4 fade-in">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold"><i class="fa-solid fa-tags me-2 text-success"></i>Categorías</h2>
        <a href="${pageContext.request.contextPath}/categorias?accion=nuevo" class="btn btn-primary"><i class="fa-solid fa-plus me-2"></i>Nueva</a>
    </div>
    <div class="card apple-card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead><tr><th>ID</th><th>Unidad</th><th>Nombre</th><th>Descripción</th><th>Activo</th><th class="text-end">Acciones</th></tr></thead>
                <tbody>
                <% if (lista != null) for (Categoria c : lista) { %>
                <tr>
                    <td><%= c.getIdCategoria() %></td>
                    <td><span class="badge bg-light text-dark"><%= c.getNombreUnidad() %></span></td>
                    <td class="fw-medium"><%= c.getNombre() %></td>
                    <td class="text-muted"><%= c.getDescripcion() %></td>
                    <td><%= c.isActivo() ? "<span class='badge bg-success'>Sí</span>" : "<span class='badge bg-secondary'>No</span>" %></td>
                    <td class="text-end">
                        <a href="${pageContext.request.contextPath}/categorias?accion=editar&id=<%= c.getIdCategoria() %>" class="btn btn-sm btn-outline-warning"><i class="fa-solid fa-pen"></i></a>
                        <a href="${pageContext.request.contextPath}/categorias?accion=eliminar&id=<%= c.getIdCategoria() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('¿Desactivar?')"><i class="fa-solid fa-trash"></i></a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/inicio" class="btn btn-outline-secondary"><i class="fa-solid fa-arrow-left me-2"></i>Menú</a>
    </div>
</div>
</body>
</html>
