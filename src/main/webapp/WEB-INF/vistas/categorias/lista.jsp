<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.sysventas.proyectofinal.model.Categoria" %>
<%@ page import="java.util.List" %>
<%
    List<Categoria> lista = (List<Categoria>) request.getAttribute("lista");
    pageContext.setAttribute("seccion", "categorias");
    pageContext.setAttribute("breadcrumb", "Categorías");
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
<%@ include file="/WEB-INF/fragmentos/navbar.jspf" %>
<div class="container py-4 fade-in">
    <%@ include file="/WEB-INF/fragmentos/breadcrumb.jspf" %>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold"><i class="fa-solid fa-tags me-2 text-success"></i>Categorías</h2>
        <a href="${pageContext.request.contextPath}/categorias?accion=nuevo" class="btn btn-primary"><i class="fa-solid fa-plus me-2"></i>Nueva</a>
    </div>
    <% if (lista == null || lista.isEmpty()) { %>
    <div class="text-center py-5">
        <i class="fa-solid fa-tags fa-3x text-muted mb-3"></i>
        <p class="text-muted">No hay categorías registradas.</p>
        <a href="${pageContext.request.contextPath}/categorias?accion=nuevo" class="btn btn-primary"><i class="fa-solid fa-plus me-2"></i>Crear la primera</a>
    </div>
    <% } else { %>
    <div class="card apple-card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead><tr><th>ID</th><th>Unidad</th><th>Nombre</th><th>Descripción</th><th>Activo</th><th class="text-end">Acciones</th></tr></thead>
                    <tbody>
                    <% for (Categoria c : lista) { %>
                    <tr>
                        <td class="text-muted small"><%= c.getIdCategoria() %></td>
                        <td><span class="badge bg-light text-dark"><%= c.getNombreUnidad() %></span></td>
                        <td class="fw-medium"><%= c.getNombre() %></td>
                        <td class="text-muted"><%= c.getDescripcion() %></td>
                        <td><%= c.isActivo() ? "<span class='badge bg-success'>Sí</span>" : "<span class='badge bg-secondary'>No</span>" %></td>
                        <td class="text-end">
                            <a href="${pageContext.request.contextPath}/categorias?accion=editar&id=<%= c.getIdCategoria() %>" class="btn btn-sm btn-outline-warning" title="Editar <%= c.getNombre() %>" aria-label="Editar <%= c.getNombre() %>"><i class="fa-solid fa-pen"></i></a>
                            <button type="button" class="btn btn-sm btn-outline-danger" title="Eliminar <%= c.getNombre() %>" aria-label="Eliminar <%= c.getNombre() %>" onclick="confirmarEliminar('${pageContext.request.contextPath}/categorias', <%= c.getIdCategoria() %>, '<%= c.getNombre().replace("'", "\\'") %>')"><i class="fa-solid fa-trash"></i></button>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <% } %>
</div>
<%@ include file="/WEB-INF/fragmentos/confirmarEliminar.jspf" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
