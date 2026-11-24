<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.sysventas.proyectofinal.model.Proveedor" %>
<%@ page import="java.util.List" %>
<%
    List<Proveedor> lista = (List<Proveedor>) request.getAttribute("lista");
    int total = request.getAttribute("total") != null ? (Integer) request.getAttribute("total") : 0;
    int pagina = request.getAttribute("pagina") != null ? (Integer) request.getAttribute("pagina") : 1;
    int tamano = request.getAttribute("tamano") != null ? (Integer) request.getAttribute("tamano") : 10;
    int totalPaginas = request.getAttribute("totalPaginas") != null ? (Integer) request.getAttribute("totalPaginas") : 1;
    String q = (String) request.getAttribute("q");
    pageContext.setAttribute("seccion", "proveedores");
    pageContext.setAttribute("breadcrumb", "Proveedores");
    int desde = total == 0 ? 0 : (pagina - 1) * tamano + 1;
    int hasta = Math.min(pagina * tamano, total);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Proveedores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body class="bg-apple">
<%@ include file="/WEB-INF/fragmentos/navbar.jspf" %>
<div class="container py-4 fade-in">
    <%@ include file="/WEB-INF/fragmentos/breadcrumb.jspf" %>
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="fw-bold"><i class="fa-solid fa-truck me-2 text-danger"></i>Proveedores</h2>
        <a href="${pageContext.request.contextPath}/proveedores?accion=nuevo" class="btn btn-primary"><i class="fa-solid fa-plus me-2"></i>Nuevo</a>
    </div>
    <form method="get" action="${pageContext.request.contextPath}/proveedores" class="row g-2 mb-3">
        <div class="col-md-9">
            <div class="input-group">
                <span class="input-group-text bg-white"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                <input type="text" name="q" class="form-control" placeholder="Buscar por empresa, contacto o email" value="<c:out value="<%= q != null ? q : \"\" %>" />">
            </div>
        </div>
        <div class="col-md-3 d-flex gap-2">
            <button type="submit" class="btn btn-primary flex-fill"><i class="fa-solid fa-filter me-1"></i>Filtrar</button>
            <a href="${pageContext.request.contextPath}/proveedores" class="btn btn-outline-secondary"><i class="fa-solid fa-rotate-left"></i></a>
        </div>
    </form>
    <% if (lista == null || lista.isEmpty()) { %>
    <div class="text-center py-5">
        <i class="fa-solid fa-truck fa-3x text-muted mb-3"></i>
        <p class="text-muted">No se encontraron proveedores.</p>
        <% if (q == null || q.isBlank()) { %>
        <a href="${pageContext.request.contextPath}/proveedores?accion=nuevo" class="btn btn-primary"><i class="fa-solid fa-plus me-2"></i>Crear el primero</a>
        <% } else { %>
        <a href="${pageContext.request.contextPath}/proveedores" class="btn btn-outline-secondary"><i class="fa-solid fa-filter-circle-xmark me-2"></i>Limpiar filtros</a>
        <% } %>
    </div>
    <% } else { %>
    <div class="card apple-card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead><tr><th>ID</th><th>Empresa</th><th>Contacto</th><th>Teléfono</th><th>Email</th><th>Dirección</th><th>Activo</th><th class="text-end">Acciones</th></tr></thead>
                    <tbody>
                    <% for (Proveedor p : lista) { %>
                    <tr>
                        <td class="text-muted small"><%= p.getIdProveedor() %></td>
                        <td class="fw-medium"><%= p.getNombreEmpresa() %></td>
                        <td><%= p.getContacto() %></td>
                        <td><i class="fa-solid fa-phone text-muted me-1"></i><%= p.getTelefono() %></td>
                        <td><i class="fa-solid fa-envelope text-muted me-1"></i><%= p.getEmail() %></td>
                        <td class="text-muted small"><%= p.getDireccion() %></td>
                        <td><%= p.isActivo() ? "<span class='badge bg-success'>Sí</span>" : "<span class='badge bg-secondary'>No</span>" %></td>
                        <td class="text-end">
                            <a href="${pageContext.request.contextPath}/proveedores?accion=editar&id=<%= p.getIdProveedor() %>" class="btn btn-sm btn-outline-warning" title="Editar <%= p.getNombreEmpresa() %>" aria-label="Editar <%= p.getNombreEmpresa() %>"><i class="fa-solid fa-pen"></i></a>
                            <button type="button" class="btn btn-sm btn-outline-danger" title="Eliminar <%= p.getNombreEmpresa() %>" aria-label="Eliminar <%= p.getNombreEmpresa() %>" onclick="confirmarEliminar('${pageContext.request.contextPath}/proveedores', <%= p.getIdProveedor() %>, '<%= p.getNombreEmpresa().replace("'", "\\'") %>')"><i class="fa-solid fa-trash"></i></button>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="d-flex justify-content-between align-items-center mt-3">
        <small class="text-muted">Mostrando <%= desde %> a <%= hasta %> de <%= total %> proveedores</small>
        <nav>
            <ul class="pagination mb-0">
                <li class="page-item <%= pagina <= 1 ? "disabled" : "" %>">
                    <a class="page-link" href="${pageContext.request.contextPath}/proveedores?pagina=<%= pagina-1 %>&q=<%= q != null ? q : "" %>">Anterior</a>
                </li>
                <% for (int i = 1; i <= totalPaginas; i++) { %>
                <li class="page-item <%= i == pagina ? "active" : "" %>">
                    <a class="page-link" href="${pageContext.request.contextPath}/proveedores?pagina=<%= i %>&q=<%= q != null ? q : "" %>"><%= i %></a>
                </li>
                <% } %>
                <li class="page-item <%= pagina >= totalPaginas ? "disabled" : "" %>">
                    <a class="page-link" href="${pageContext.request.contextPath}/proveedores?pagina=<%= pagina+1 %>&q=<%= q != null ? q : "" %>">Siguiente</a>
                </li>
            </ul>
        </nav>
    </div>
    <% } %>
</div>
<%@ include file="/WEB-INF/fragmentos/confirmarEliminar.jspf" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
