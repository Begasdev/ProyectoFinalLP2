<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.sysventas.proyectofinal.model.Cliente" %>
<%
    Cliente c = (Cliente) request.getAttribute("cliente");
    boolean esEdicion = (c != null);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cliente</title>
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
    <h2 class="fw-bold mb-4"><i class="fa-solid fa-users me-2 text-info"></i><%= esEdicion ? "Editar" : "Nuevo" %> cliente</h2>
    <div class="card apple-card" style="max-width:600px;">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/clientes" method="post">
                <% if (esEdicion) { %>
                <input type="hidden" name="idCliente" value="<%= c.getIdCliente() %>">
                <% } %>
                <div class="mb-3">
                    <label class="form-label fw-medium">Nombre</label>
                    <input type="text" name="nombre" class="form-control" value="<%= esEdicion ? c.getNombre() : "" %>" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-medium">Apellido</label>
                    <input type="text" name="apellido" class="form-control" value="<%= esEdicion ? c.getApellido() : "" %>">
                </div>
                <div class="mb-3">
                    <label class="form-label fw-medium">Teléfono</label>
                    <input type="text" name="telefono" class="form-control" value="<%= esEdicion ? c.getTelefono() : "" %>">
                </div>
                <div class="mb-3">
                    <label class="form-label fw-medium">Email</label>
                    <input type="email" name="email" class="form-control" value="<%= esEdicion ? c.getEmail() : "" %>">
                </div>
                <div class="mb-3">
                    <label class="form-label fw-medium">Dirección</label>
                    <input type="text" name="direccion" class="form-control" value="<%= esEdicion ? c.getDireccion() : "" %>">
                </div>
                <div class="form-check mb-3">
                    <input type="checkbox" name="activo" class="form-check-input" id="activo" <%= (esEdicion && c.isActivo()) || !esEdicion ? "checked" : "" %>>
                    <label class="form-check-label" for="activo">Activo</label>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary"><i class="fa-solid fa-floppy-disk me-2"></i>Guardar</button>
                    <a href="${pageContext.request.contextPath}/clientes" class="btn btn-outline-secondary"><i class="fa-solid fa-xmark me-2"></i>Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
