<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.sysventas.proyectofinal.model.UnidadMedida" %>
<%@ page import="java.util.List" %>
<%
    List<UnidadMedida> lista = (List<UnidadMedida>) request.getAttribute("lista");
    pageContext.setAttribute("seccion", "unidades");
    pageContext.setAttribute("breadcrumb", "Unidades de medida");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unidades de medida</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body class="bg-apple">
<%@ include file="/WEB-INF/fragmentos/navbar.jspf" %>
<div class="container py-4 fade-in">
    <%@ include file="/WEB-INF/fragmentos/breadcrumb.jspf" %>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold"><i class="fa-solid fa-ruler me-2 text-primary"></i>Unidades de medida</h2>
        <a href="${pageContext.request.contextPath}/unidades?accion=nuevo" class="btn btn-primary"><i class="fa-solid fa-plus me-2"></i>Nueva</a>
    </div>
    <% if (lista == null || lista.isEmpty()) { %>
    <div class="text-center py-5">
        <i class="fa-solid fa-ruler fa-3x text-muted mb-3"></i>
        <p class="text-muted">No hay unidades registradas.</p>
        <a href="${pageContext.request.contextPath}/unidades?accion=nuevo" class="btn btn-primary"><i class="fa-solid fa-plus me-2"></i>Crear la primera</a>
    </div>
    <% } else { %>
    <div class="card apple-card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead><tr><th>ID</th><th>Nombre</th><th>Abreviatura</th><th>Activo</th><th class="text-end">Acciones</th></tr></thead>
                    <tbody>
                    <% for (UnidadMedida u : lista) { %>
                    <tr>
                        <td class="text-muted small"><%= u.getIdUnidadMedida() %></td>
                        <td class="fw-medium"><%= u.getNombre() %></td>
                        <td><span class="badge bg-light text-dark"><%= u.getAbreviatura() %></span></td>
                        <td><%= u.isActivo() ? "<span class='badge bg-success'>Sí</span>" : "<span class='badge bg-secondary'>No</span>" %></td>
                        <td class="text-end">
                            <a href="${pageContext.request.contextPath}/unidades?accion=editar&id=<%= u.getIdUnidadMedida() %>" class="btn btn-sm btn-outline-warning" title="Editar <%= u.getNombre() %>" aria-label="Editar <%= u.getNombre() %>"><i class="fa-solid fa-pen"></i></a>
                            <button type="button" class="btn btn-sm btn-outline-danger" title="Eliminar <%= u.getNombre() %>" aria-label="Eliminar <%= u.getNombre() %>" onclick="confirmarEliminar('${pageContext.request.contextPath}/unidades', <%= u.getIdUnidadMedida() %>, '<%= u.getNombre().replace("'", "\\'") %>')"><i class="fa-solid fa-trash"></i></button>
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
