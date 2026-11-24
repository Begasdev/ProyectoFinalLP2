<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="com.sysventas.proyectofinal.model.Producto" %>
<%@ page import="com.sysventas.proyectofinal.model.Categoria" %>
<%@ page import="java.util.List" %>
<%
    List<Producto> lista = (List<Producto>) request.getAttribute("lista");
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
    int total = request.getAttribute("total") != null ? (Integer) request.getAttribute("total") : 0;
    int pagina = request.getAttribute("pagina") != null ? (Integer) request.getAttribute("pagina") : 1;
    int tamano = request.getAttribute("tamano") != null ? (Integer) request.getAttribute("tamano") : 10;
    int totalPaginas = request.getAttribute("totalPaginas") != null ? (Integer) request.getAttribute("totalPaginas") : 1;
    String q = (String) request.getAttribute("q");
    String catStr = (String) request.getAttribute("categoria");
    pageContext.setAttribute("seccion", "productos");
    pageContext.setAttribute("breadcrumb", "Productos");
    int desde = total == 0 ? 0 : (pagina - 1) * tamano + 1;
    int hasta = Math.min(pagina * tamano, total);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body class="bg-apple">
<%@ include file="/WEB-INF/fragmentos/navbar.jspf" %>
<div class="container py-4 fade-in">
    <%@ include file="/WEB-INF/fragmentos/breadcrumb.jspf" %>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="fw-bold"><i class="fa-solid fa-box me-2 text-warning"></i>Productos</h2>
        <a href="${pageContext.request.contextPath}/productos?accion=nuevo" class="btn btn-primary"><i class="fa-solid fa-plus me-2"></i>Nuevo</a>
    </div>

    <!-- Filtros -->
    <form method="get" action="${pageContext.request.contextPath}/productos" class="row g-2 mb-3">
        <div class="col-md-5">
            <div class="input-group">
                <span class="input-group-text bg-white"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                <input type="text" name="q" class="form-control" placeholder="Buscar por código o descripción" value="<c:out value="<%= q != null ? q : \"\" %>" />">
            </div>
        </div>
        <div class="col-md-4">
            <select name="categoria" class="form-select">
                <option value="">Todas las categorías</option>
                <% if (categorias != null) for (Categoria cat : categorias) { %>
                <option value="<%= cat.getIdCategoria() %>" <%= (catStr != null && catStr.equals(String.valueOf(cat.getIdCategoria()))) ? "selected" : "" %>><%= cat.getNombre() %></option>
                <% } %>
            </select>
        </div>
        <div class="col-md-3 d-flex gap-2">
            <button type="submit" class="btn btn-primary flex-fill"><i class="fa-solid fa-filter me-1"></i>Filtrar</button>
            <a href="${pageContext.request.contextPath}/productos" class="btn btn-outline-secondary"><i class="fa-solid fa-rotate-left"></i></a>
        </div>
    </form>

    <% if (lista == null || lista.isEmpty()) { %>
    <div class="text-center py-5">
        <i class="fa-solid fa-box-open fa-3x text-muted mb-3"></i>
        <p class="text-muted">No se encontraron productos.</p>
        <% if ((q == null || q.isBlank()) && (catStr == null || catStr.isBlank())) { %>
        <a href="${pageContext.request.contextPath}/productos?accion=nuevo" class="btn btn-primary"><i class="fa-solid fa-plus me-2"></i>Crear el primero</a>
        <% } else { %>
        <a href="${pageContext.request.contextPath}/productos" class="btn btn-outline-secondary"><i class="fa-solid fa-filter-circle-xmark me-2"></i>Limpiar filtros</a>
        <% } %>
    </div>
    <% } else { %>
    <div class="card apple-card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead>
                        <tr>
                            <th class="text-muted small">ID</th>
                            <th>Categoría</th>
                            <th>Código</th>
                            <th>Descripción</th>
                            <th class="text-end">P.Compra</th>
                            <th class="text-end">P.Venta</th>
                            <th class="text-end">Cantidad</th>
                            <th>Activo</th>
                            <th class="text-end">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% for (Producto p : lista) { %>
                    <tr>
                        <td class="text-muted small"><%= p.getIdProducto() %></td>
                        <td><span class="badge bg-light text-dark"><%= p.getNombreCategoria() %></span></td>
                        <td class="text-muted font-monospace"><%= p.getCodigo() %></td>
                        <td class="fw-medium"><c:out value="<%= p.getDescripcion() %>" /></td>
                        <c:set var="pc" value="<%= p.getPrecioCompra() %>" />
                        <c:set var="pv" value="<%= p.getPrecioVenta() %>" />
                        <td class="text-end"><fmt:formatNumber value="${pc}" type="currency" currencySymbol="$" minFractionDigits="2" maxFractionDigits="2" /></td>
                        <td class="text-end text-success fw-bold"><fmt:formatNumber value="${pv}" type="currency" currencySymbol="$" minFractionDigits="2" maxFractionDigits="2" /></td>
                        <td class="text-end">
                            <% if (p.getCantidad() == 0) { %>
                            <span class="badge bg-danger">Agotado</span>
                            <% } else if (p.getCantidad() <= com.sysventas.proyectofinal.controlador.ProductoServlet.STOCK_MINIMO) { %>
                            <span class="badge bg-warning text-dark"><%= p.getCantidad() %></span>
                            <% } else { %>
                            <%= p.getCantidad() %>
                            <% } %>
                        </td>
                        <td><%= p.isActivo() ? "<span class='badge bg-success'>Sí</span>" : "<span class='badge bg-secondary'>No</span>" %></td>
                        <td class="text-end">
                            <a href="${pageContext.request.contextPath}/productos?accion=editar&id=<%= p.getIdProducto() %>" class="btn btn-sm btn-outline-warning" title="Editar <%= p.getDescripcion() %>" aria-label="Editar <%= p.getDescripcion() %>"><i class="fa-solid fa-pen"></i></a>
                            <button type="button" class="btn btn-sm btn-outline-danger" title="Eliminar <%= p.getDescripcion() %>" aria-label="Eliminar <%= p.getDescripcion() %>" onclick="confirmarEliminar('${pageContext.request.contextPath}/productos', <%= p.getIdProducto() %>, '<%= p.getDescripcion().replace("'", "\\'") %>')"><i class="fa-solid fa-trash"></i></button>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Paginación -->
    <div class="d-flex justify-content-between align-items-center mt-3">
        <small class="text-muted">Mostrando <%= desde %> a <%= hasta %> de <%= total %> productos</small>
        <nav>
            <ul class="pagination mb-0">
                <li class="page-item <%= pagina <= 1 ? "disabled" : "" %>">
                    <a class="page-link" href="${pageContext.request.contextPath}/productos?pagina=<%= pagina-1 %>&q=<%= q != null ? q : "" %>&categoria=<%= catStr != null ? catStr : "" %>">Anterior</a>
                </li>
                <% for (int i = 1; i <= totalPaginas; i++) { %>
                <li class="page-item <%= i == pagina ? "active" : "" %>">
                    <a class="page-link" href="${pageContext.request.contextPath}/productos?pagina=<%= i %>&q=<%= q != null ? q : "" %>&categoria=<%= catStr != null ? catStr : "" %>"><%= i %></a>
                </li>
                <% } %>
                <li class="page-item <%= pagina >= totalPaginas ? "disabled" : "" %>">
                    <a class="page-link" href="${pageContext.request.contextPath}/productos?pagina=<%= pagina+1 %>&q=<%= q != null ? q : "" %>&categoria=<%= catStr != null ? catStr : "" %>">Siguiente</a>
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
