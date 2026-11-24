<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="com.sysventas.proyectofinal.model.Usuario" %>
<%@ page import="com.sysventas.proyectofinal.model.Producto" %>
<%@ page import="java.util.List" %>
<%
    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    String nombreCompleto = u.getNombreCompleto();
    String primerNombre = "";
    if (nombreCompleto != null && !nombreCompleto.trim().isEmpty()) {
        primerNombre = nombreCompleto.trim().split("\\s+")[0];
    }
    int nU = request.getAttribute("nUnidades") != null ? (Integer) request.getAttribute("nUnidades") : 0;
    int nC = request.getAttribute("nCategorias") != null ? (Integer) request.getAttribute("nCategorias") : 0;
    int nP = request.getAttribute("nProductos") != null ? (Integer) request.getAttribute("nProductos") : 0;
    int nCl = request.getAttribute("nClientes") != null ? (Integer) request.getAttribute("nClientes") : 0;
    int nPr = request.getAttribute("nProveedores") != null ? (Integer) request.getAttribute("nProveedores") : 0;
    int stockBajo = request.getAttribute("stockBajo") != null ? (Integer) request.getAttribute("stockBajo") : 0;
    int agotados = request.getAttribute("agotados") != null ? (Integer) request.getAttribute("agotados") : 0;
    double valorInv = request.getAttribute("valorInventario") != null ? (Double) request.getAttribute("valorInventario") : 0.0;
    List<Producto> menosStock = (List<Producto>) request.getAttribute("menosStock");
    pageContext.setAttribute("seccion", "inicio");
    pageContext.setAttribute("breadcrumb", "");
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
<%@ include file="/WEB-INF/fragmentos/navbar.jspf" %>

<div class="container py-4">
    <div class="mb-4 fade-in">
        <h1 class="fw-bold">Hola, <c:out value="<%= primerNombre %>" /> <i class="fa-solid fa-hand text-warning"></i></h1>
        <p class="text-muted">Bienvenido a tu panel de control.</p>
    </div>

    <!-- Fila 1: tarjetas por módulo -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-4 col-lg">
            <a href="${pageContext.request.contextPath}/unidades" class="text-decoration-none">
                <div class="card apple-card module-card p-3 text-center fade-in h-100">
                    <i class="fa-solid fa-ruler fa-2x text-primary mb-2"></i>
                    <h3 class="fw-bold mb-0"><%= nU %></h3>
                    <small class="text-muted">Unidades</small>
                </div>
            </a>
        </div>
        <div class="col-6 col-md-4 col-lg">
            <a href="${pageContext.request.contextPath}/categorias" class="text-decoration-none">
                <div class="card apple-card module-card p-3 text-center fade-in h-100">
                    <i class="fa-solid fa-tags fa-2x text-success mb-2"></i>
                    <h3 class="fw-bold mb-0"><%= nC %></h3>
                    <small class="text-muted">Categorías</small>
                </div>
            </a>
        </div>
        <div class="col-6 col-md-4 col-lg">
            <a href="${pageContext.request.contextPath}/productos" class="text-decoration-none">
                <div class="card apple-card module-card p-3 text-center fade-in h-100">
                    <i class="fa-solid fa-box fa-2x text-warning mb-2"></i>
                    <h3 class="fw-bold mb-0"><%= nP %></h3>
                    <small class="text-muted">Productos</small>
                </div>
            </a>
        </div>
        <div class="col-6 col-md-4 col-lg">
            <a href="${pageContext.request.contextPath}/clientes" class="text-decoration-none">
                <div class="card apple-card module-card p-3 text-center fade-in h-100">
                    <i class="fa-solid fa-users fa-2x text-info mb-2"></i>
                    <h3 class="fw-bold mb-0"><%= nCl %></h3>
                    <small class="text-muted">Clientes</small>
                </div>
            </a>
        </div>
        <div class="col-6 col-md-4 col-lg">
            <a href="${pageContext.request.contextPath}/proveedores" class="text-decoration-none">
                <div class="card apple-card module-card p-3 text-center fade-in h-100">
                    <i class="fa-solid fa-truck fa-2x text-danger mb-2"></i>
                    <h3 class="fw-bold mb-0"><%= nPr %></h3>
                    <small class="text-muted">Proveedores</small>
                </div>
            </a>
        </div>
    </div>

    <!-- Fila 2: indicadores de negocio -->
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/productos" class="text-decoration-none">
                <div class="card apple-card p-4 fade-in h-100 <%= stockBajo > 0 ? "border border-warning" : "" %>">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-triangle-exclamation fa-2x <%= stockBajo > 0 ? "text-warning" : "text-muted" %> me-3"></i>
                        <div>
                            <h3 class="fw-bold mb-0 <%= stockBajo > 0 ? "text-warning" : "" %>"><%= stockBajo %></h3>
                            <small class="text-muted">Productos con stock bajo</small>
                        </div>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <div class="card apple-card p-4 fade-in h-100">
                <div class="d-flex align-items-center">
                    <i class="fa-solid fa-coins fa-2x text-success me-3"></i>
                    <div>
                        <h3 class="fw-bold mb-0"><fmt:formatNumber value="<%= valorInv %>" type="currency" currencySymbol="$" minFractionDigits="2" maxFractionDigits="2" /></h3>
                        <small class="text-muted">Valor del inventario</small>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/productos" class="text-decoration-none">
                <div class="card apple-card p-4 fade-in h-100 <%= agotados > 0 ? "border border-danger" : "" %>">
                    <div class="d-flex align-items-center">
                        <i class="fa-solid fa-ban fa-2x <%= agotados > 0 ? "text-danger" : "text-muted" %> me-3"></i>
                        <div>
                            <h3 class="fw-bold mb-0 <%= agotados > 0 ? "text-danger" : "" %>"><%= agotados %></h3>
                            <small class="text-muted">Productos agotados</small>
                        </div>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <!-- Tabla: 5 productos con menos stock -->
    <h4 class="mb-3">Productos con menos stock</h4>
    <% if (menosStock == null || menosStock.isEmpty()) { %>
    <p class="text-muted">No hay productos registrados.</p>
    <% } else { %>
    <div class="card apple-card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead><tr><th>Código</th><th>Descripción</th><th class="text-end">Cantidad</th><th class="text-end">Acción</th></tr></thead>
                    <tbody>
                    <% for (Producto p : menosStock) { %>
                    <tr>
                        <td class="text-muted font-monospace"><%= p.getCodigo() %></td>
                        <td class="fw-medium"><c:out value="<%= p.getDescripcion() %>" /></td>
                        <td class="text-end">
                            <% if (p.getCantidad() == 0) { %>
                            <span class="badge bg-danger">Agotado</span>
                            <% } else if (p.getCantidad() <= com.sysventas.proyectofinal.controlador.ProductoServlet.STOCK_MINIMO) { %>
                            <span class="badge bg-warning text-dark"><%= p.getCantidad() %></span>
                            <% } else { %>
                            <%= p.getCantidad() %>
                            <% } %>
                        </td>
                        <td class="text-end">
                            <a href="${pageContext.request.contextPath}/productos?accion=editar&id=<%= p.getIdProducto() %>" class="btn btn-sm btn-outline-warning" title="Editar <%= p.getDescripcion() %>" aria-label="Editar <%= p.getDescripcion() %>"><i class="fa-solid fa-pen"></i></a>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
