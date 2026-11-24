<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.UnidadMedida" %>
<%
    UnidadMedida u = (UnidadMedida) request.getAttribute("unidad");
    boolean esEdicion = (u != null);
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
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/inicio"><i class="fa-solid fa-cart-shopping me-2"></i>ProyectoFinalLP2</a>
    </div>
</nav>
<div class="container py-4 fade-in">
    <h2 class="fw-bold mb-4"><i class="fa-solid fa-ruler me-2 text-primary"></i><%= esEdicion ? "Editar" : "Nueva" %> unidad de medida</h2>
    <div class="card apple-card" style="max-width:600px;">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/unidades" method="post">
                <% if (esEdicion) { %>
                <input type="hidden" name="idUnidadMedida" value="<%= u.getIdUnidadMedida() %>">
                <% } %>
                <div class="mb-3">
                    <label class="form-label fw-medium">Nombre</label>
                    <input type="text" name="nombre" class="form-control" value="<%= esEdicion ? u.getNombre() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-medium">Abreviatura</label>
                    <input type="text" name="abreviatura" class="form-control" value="<%= esEdicion ? u.getAbreviatura() : "" %>" required>
                </div>
                <div class="form-check mb-3">
                    <input type="checkbox" name="activo" class="form-check-input" id="activo" <%= (esEdicion && u.isActivo()) || !esEdicion ? "checked" : "" %>>
                    <label class="form-check-label" for="activo">Activo</label>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary"><i class="fa-solid fa-floppy-disk me-2"></i>Guardar</button>
                    <a href="${pageContext.request.contextPath}/unidades" class="btn btn-outline-secondary"><i class="fa-solid fa-xmark me-2"></i>Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
