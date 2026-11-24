<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.sysventas.proyectofinal.model.Producto" %>
<%@ page import="com.sysventas.proyectofinal.model.Categoria" %>
<%@ page import="java.util.List" %>
<%
    Producto p = (Producto) request.getAttribute("producto");
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
    boolean esEdicion = (p != null);
    pageContext.setAttribute("seccion", "productos");
    pageContext.setAttribute("breadcrumb", "Productos / " + (esEdicion ? "Editar" : "Nuevo"));
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
<%@ include file="/WEB-INF/fragmentos/navbar.jspf" %>
<div class="container py-4 fade-in">
    <%@ include file="/WEB-INF/fragmentos/breadcrumb.jspf" %>
    <h2 class="fw-bold mb-4"><i class="fa-solid fa-box me-2 text-warning"></i><%= esEdicion ? "Editar" : "Nuevo" %> producto</h2>
    <div class="card apple-card form-card-wide">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/productos" method="post" class="needs-validation" novalidate>
                <% if (esEdicion) { %>
                <input type="hidden" name="idProducto" value="<%= p.getIdProducto() %>">
                <% } %>
                <div class="mb-3">
                    <label for="idCategoria" class="form-label fw-medium">Categoría</label>
                    <select id="idCategoria" name="idCategoria" class="form-select" required>
                        <% if (categorias != null) for (Categoria c : categorias) { %>
                        <option value="<%= c.getIdCategoria() %>" <%= (esEdicion && p.getIdCategoria() == c.getIdCategoria()) ? "selected" : "" %>><%= c.getNombre() %></option>
                        <% } %>
                    </select>
                    <div class="invalid-feedback">Selecciona una categoría.</div>
                </div>
                <div class="mb-3">
                    <label for="codigo" class="form-label fw-medium">Código</label>
                    <input type="text" id="codigo" name="codigo" class="form-control" value="<%= esEdicion ? p.getCodigo() : "" %>" required>
                    <div class="invalid-feedback">El código es obligatorio.</div>
                </div>
                <div class="mb-3">
                    <label for="descripcion" class="form-label fw-medium">Descripción</label>
                    <input type="text" id="descripcion" name="descripcion" class="form-control" value="<%= esEdicion ? p.getDescripcion() : "" %>" required>
                    <div class="invalid-feedback">La descripción es obligatoria.</div>
                </div>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label for="precioCompra" class="form-label fw-medium">Precio compra</label>
                        <input type="number" step="0.01" id="precioCompra" name="precioCompra" class="form-control" value="<%= esEdicion ? p.getPrecioCompra() : "" %>" required min="0">
                        <div class="invalid-feedback">Ingresa un precio válido.</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="precioVenta" class="form-label fw-medium">Precio venta</label>
                        <input type="number" step="0.01" id="precioVenta" name="precioVenta" class="form-control" value="<%= esEdicion ? p.getPrecioVenta() : "" %>" required min="0">
                        <div class="invalid-feedback">Ingresa un precio válido.</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="cantidad" class="form-label fw-medium">Cantidad</label>
                        <input type="number" id="cantidad" name="cantidad" class="form-control" value="<%= esEdicion ? p.getCantidad() : 0 %>" required min="0">
                        <div class="invalid-feedback">Ingresa una cantidad válida.</div>
                    </div>
                </div>
                <div class="form-check mb-3">
                    <input type="checkbox" name="activo" class="form-check-input" id="activo" <%= (esEdicion && p.isActivo()) || !esEdicion ? "checked" : "" %>>
                    <label class="form-check-label" for="activo">Activo</label>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary" data-loading-text="Guardando..."><i class="fa-solid fa-floppy-disk me-2"></i>Guardar</button>
                    <a href="${pageContext.request.contextPath}/productos" class="btn btn-outline-secondary"><i class="fa-solid fa-xmark me-2"></i>Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/formularios.js"></script>
<script>
(function () {
    var forms = document.querySelectorAll('.needs-validation');
    Array.prototype.slice.call(forms).forEach(function (form) {
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
})();
</script>
</body>
</html>
