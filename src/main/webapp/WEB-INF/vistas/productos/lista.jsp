<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Producto" %>
<%@ page import="java.util.List" %>
<%
    List<Producto> lista = (List<Producto>) request.getAttribute("lista");
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
        <h2 class="fw-bold"><i class="fa-solid fa-box me-2 text-warning"></i>Productos</h2>
        <a href="${pageContext.request.contextPath}/productos?accion=nuevo" class="btn btn-primary"><i class="fa-solid fa-plus me-2"></i>Nuevo</a>
    </div>
    <div class="card apple-card">
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead><tr><th>ID</th><th>Categoría</th><th>Código</th><th>Descripción</th><th>P.Compra</th><th>P.Venta</th><th>Cantidad</th><th>Activo</th><th class="text-end">Acciones</th></tr></thead>
                <tbody>
                <% if (lista != null) for (Producto p : lista) { %>
                <tr>
                    <td><%= p.getIdProducto() %></td>
                    <td><span class="badge bg-light text-dark"><%= p.getNombreCategoria() %></span></td>
                    <td><code><%= p.getCodigo() %></code></td>
                    <td class="fw-medium"><%= p.getDescripcion() %></td>
                    <td>$<%= p.getPrecioCompra() %></td>
                    <td class="text-success fw-bold">$<%= p.getPrecioVenta() %></td>
                    <td><%= p.getCantidad() %></td>
                    <td><%= p.isActivo() ? "<span class='badge bg-success'>Sí</span>" : "<span class='badge bg-secondary'>No</span>" %></td>
                    <td class="text-end">
                        <a href="${pageContext.request.contextPath}/productos?accion=editar&id=<%= p.getIdProducto() %>" class="btn btn-sm btn-outline-warning"><i class="fa-solid fa-pen"></i></a>
                        <a href="${pageContext.request.contextPath}/productos?accion=eliminar&id=<%= p.getIdProducto() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('¿Desactivar?')"><i class="fa-solid fa-trash"></i></a>
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
