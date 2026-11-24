<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cambio de contraseña</title>
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
    <h2 class="fw-bold mb-4"><i class="fa-solid fa-key me-2 text-warning"></i>Cambio de contraseña temporal</h2>
    <div class="card apple-card" style="max-width:400px;">
        <div class="card-body">
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("error") %></div>
            <% } %>
            <form action="${pageContext.request.contextPath}/cambioClave" method="post">
                <div class="mb-3">
                    <label class="form-label fw-medium">Nueva contraseña</label>
                    <input type="password" name="nuevaClave" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-medium">Confirmar</label>
                    <input type="password" name="confirmarClave" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary"><i class="fa-solid fa-check me-2"></i>Cambiar</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
