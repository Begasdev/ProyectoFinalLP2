<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Cambio de contraseña</title></head>
<body>
<h1>Cambio de contraseña temporal</h1>
<% if (request.getAttribute("error") != null) { %>
<p style="color:red"><%= request.getAttribute("error") %></p>
<% } %>
<form action="${pageContext.request.contextPath}/cambioClave" method="post">
    <label>Nueva contraseña: <input type="password" name="nuevaClave" required></label><br>
    <label>Confirmar: <input type="password" name="confirmarClave" required></label><br>
    <button type="submit">Cambiar</button>
</form>
</body>
</html>
