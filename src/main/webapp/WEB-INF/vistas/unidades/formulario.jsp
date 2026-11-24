<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.sysventas.proyectofinal.model.UnidadMedida" %>
<%
    UnidadMedida u = (UnidadMedida) request.getAttribute("unidad");
    boolean esEdicion = (u != null);
    pageContext.setAttribute("seccion", "unidades");
    pageContext.setAttribute("breadcrumb", "Unidades de medida / " + (esEdicion ? "Editar" : "Nueva"));
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unidad de medida</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body class="bg-apple">
<%@ include file="/WEB-INF/fragmentos/navbar.jspf" %>
<div class="container py-4 fade-in">
    <%@ include file="/WEB-INF/fragmentos/breadcrumb.jspf" %>
    <h2 class="fw-bold mb-4"><i class="fa-solid fa-ruler me-2 text-primary"></i><%= esEdicion ? "Editar" : "Nueva" %> unidad de medida</h2>
    <div class="card apple-card form-card">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/unidades" method="post" class="needs-validation" novalidate>
                <% if (esEdicion) { %>
                <input type="hidden" name="idUnidadMedida" value="<%= u.getIdUnidadMedida() %>">
                <% } %>
                <div class="mb-3">
                    <label for="nombre" class="form-label fw-medium">Nombre</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" value="<%= esEdicion ? u.getNombre() : "" %>" required>
                    <div class="invalid-feedback">El nombre es obligatorio.</div>
                </div>
                <div class="mb-3">
                    <label for="abreviatura" class="form-label fw-medium">Abreviatura</label>
                    <input type="text" id="abreviatura" name="abreviatura" class="form-control" value="<%= esEdicion ? u.getAbreviatura() : "" %>" required>
                    <div class="invalid-feedback">La abreviatura es obligatoria.</div>
                </div>
                <div class="form-check mb-3">
                    <input type="checkbox" name="activo" class="form-check-input" id="activo" <%= (esEdicion && u.isActivo()) || !esEdicion ? "checked" : "" %>>
                    <label class="form-check-label" for="activo">Activo</label>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary" data-loading-text="Guardando..."><i class="fa-solid fa-floppy-disk me-2"></i>Guardar</button>
                    <a href="${pageContext.request.contextPath}/unidades" class="btn btn-outline-secondary"><i class="fa-solid fa-xmark me-2"></i>Cancelar</a>
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
