<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Producto" %>
<%@ page import="com.sysventas.proyectofinal.model.Categoria" %>
<%@ page import="java.util.List" %>
<%
    Producto p = (Producto) request.getAttribute("producto");
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
    boolean esEdicion = (p != null);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body class="bg-apple">
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/inicio"><i class="fa-solid fa-cart-shopping me-2"></i>ProyectoFinalLP2</a>
    </div>
</nav>
<div class="container py-4 fade-in">
    <h2 class="fw-bold mb-4"><i class="fa-solid fa-box me-2 text-warning"></i><%= esEdicion ? "Editar" : "Nuevo" %> producto</h2>
    <div class="card apple-card" style="max-width:700px;">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/productos" method="post">
                <% if (esEdicion) { %>
                <input type="hidden" name="idProducto" value="<%= p.getIdProducto() %>">
                <% } %>
                <div class="mb-3">
                    <label class="form-label fw-medium">Categoría</label>
                    <select name="idCategoria" class="form-select" required>
                        <% if (categorias != null) for (Categoria c : categorias) { %>
                        <option value="<%= c.getIdCategoria() %>" <%= (esEdicion && p.getIdCategoria() == c.getIdCategoria()) ? "selected" : "" %>><%= c.getNombre() %></option>
                        <% } %>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-medium">Código</label>
                    <input type="text" name="codigo" class="form-control" value="<%= esEdicion ? p.getCodigo() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-medium">Descripción</label>
                    <input type="text" name="descripcion" class="form-control" value="<%= esEdicion ? p.getDescripcion() : "" %>" required>
                </div>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label fw-medium">Precio compra</label>
                        <input type="number" step="0.01" name="precioCompra" class="form-control" value="<%= esEdicion ? p.getPrecioCompra() : "" %>" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label fw-medium">Precio venta</label>
                        <input type="number" step="0.01" name="precioVenta" class="form-control" value="<%= esEdicion ? p.getPrecioVenta() : "" %>" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label fw-medium">Cantidad</label>
                        <input type="number" name="cantidad" class="form-control" value="<%= esEdicion ? p.getCantidad() : 0 %>" required>
                    </div>
                </div>
                <div class="form-check mb-3">
                    <input type="checkbox" name="activo" class="form-check-input" id="activo" <%= (esEdicion && p.isActivo()) || !esEdicion ? "checked" : "" %>>
                    <label class="form-check-label" for="activo">Activo</label>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary"><i class="fa-solid fa-floppy-disk me-2"></i>Guardar</button>
                    <a href="${pageContext.request.contextPath}/productos" class="btn btn-outline-secondary"><i class="fa-solid fa-xmark me-2"></i>Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
