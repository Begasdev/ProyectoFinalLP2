<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ProyectoFinalLP2 - Iniciar sesión</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<main>
    <section class="formulario">
        <header class="encabezado">
            <div class="marca-texto">
                <h1>ProyectoFinalLP2</h1>
                <p>Sistema de Gestión de Inventario</p>
            </div>
        </header>
        <% if (request.getAttribute("error") != null) { %>
        <div class="mensaje-error"><%= request.getAttribute("error") %></div>
        <% } %>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="grupo-campo">
                <input type="text" name="nombreUsuario" placeholder="Usuario" required>
            </div>
            <div class="grupo-campo">
                <input type="password" name="clave" placeholder="Contraseña" required>
            </div>
            <button type="submit">Ingresar</button>
        </form>
    </section>
</main>
</body>
</html>
