<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cambio de contraseña</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark bg-primary mb-4"><div class="container"><a class="navbar-brand" href="${pageContext.request.contextPath}/inicio">ProyectoFinalLP2</a></div></nav>
<div class="container">
    <h2>Cambio de contraseña temporal</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger mt-3"><%= request.getAttribute("error") %></div>
    <% } %>
    <form action="${pageContext.request.contextPath}/cambioClave" method="post" class="mt-3" style="max-width:400px;">
        <div class="mb-3">
            <label class="form-label">Nueva contraseña</label>
            <input type="password" name="nuevaClave" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Confirmar</label>
            <input type="password" name="confirmarClave" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">Cambiar</button>
    </form>
</div>
</body>
</html>
