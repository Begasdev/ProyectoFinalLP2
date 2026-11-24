<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    pageContext.setAttribute("navbarMinimo", Boolean.TRUE);
    pageContext.setAttribute("seccion", "");
    pageContext.setAttribute("breadcrumb", "Cambio de contraseña");
%>
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
<%@ include file="/WEB-INF/fragmentos/navbar.jspf" %>
<div class="container py-4 fade-in">
    <%@ include file="/WEB-INF/fragmentos/breadcrumb.jspf" %>
    <h2 class="fw-bold mb-4"><i class="fa-solid fa-key me-2 text-warning"></i>Cambio de contraseña temporal</h2>
    <div class="card apple-card" style="max-width:420px;">
        <div class="card-body">
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("error") %></div>
            <% } %>
            <form action="${pageContext.request.contextPath}/cambioClave" method="post" id="formCambioClave">
                <div class="mb-3">
                    <label for="nuevaClave" class="form-label fw-medium">Nueva contraseña</label>
                    <div class="input-group">
                        <input type="password" id="nuevaClave" name="nuevaClave" class="form-control" autocomplete="new-password" required>
                        <button type="button" class="btn btn-outline-secondary" onclick="togglePassword('nuevaClave', this)" aria-label="Mostrar contraseña">
                            <i class="fa-solid fa-eye"></i>
                        </button>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="confirmarClave" class="form-label fw-medium">Confirmar contraseña</label>
                    <div class="input-group">
                        <input type="password" id="confirmarClave" name="confirmarClave" class="form-control" autocomplete="new-password" required>
                        <button type="button" class="btn btn-outline-secondary" onclick="togglePassword('confirmarClave', this)" aria-label="Mostrar contraseña">
                            <i class="fa-solid fa-eye"></i>
                        </button>
                    </div>
                </div>
                <ul class="list-unstyled small mb-3" id="requisitos">
                    <li id="req-longitud"><i class="fa-solid fa-circle-xmark text-danger me-1"></i>Al menos 8 caracteres</li>
                    <li id="req-igual"><i class="fa-solid fa-circle-xmark text-danger me-1"></i>No igual a la anterior</li>
                    <li id="req-coincide"><i class="fa-solid fa-circle-xmark text-danger me-1"></i>Las contraseñas coinciden</li>
                </ul>
                <button type="submit" class="btn btn-primary" id="btnCambiar" disabled data-loading-text="Cambiando...">
                    <i class="fa-solid fa-check me-2"></i>Cambiar
                </button>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/formularios.js"></script>
<script>
function togglePassword(inputId, btn) {
    var input = document.getElementById(inputId);
    var icon = btn.querySelector('i');
    if (input.type === 'password') {
        input.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
        btn.setAttribute('aria-label', 'Ocultar contraseña');
    } else {
        input.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
        btn.setAttribute('aria-label', 'Mostrar contraseña');
    }
}
(function () {
    var nueva = document.getElementById('nuevaClave');
    var confirma = document.getElementById('confirmarClave');
    var btn = document.getElementById('btnCambiar');
    var reqLong = document.getElementById('req-longitud');
    var reqIgual = document.getElementById('req-igual');
    var reqCoincide = document.getElementById('req-coincide');

    function validar() {
        var v = nueva.value;
        var c = confirma.value;
        var okLong = v.length >= 8;
        var okIgual = v.length > 0; // la verificación "no igual a la anterior" se hace en servidor; aquí solo marcamos neutro
        var okCoincide = v.length > 0 && v === c;

        reqLong.querySelector('i').className = okLong ? 'fa-solid fa-circle-check text-success me-1' : 'fa-solid fa-circle-xmark text-danger me-1';
        reqCoincide.querySelector('i').className = okCoincide ? 'fa-solid fa-circle-check text-success me-1' : 'fa-solid fa-circle-xmark text-danger me-1';

        btn.disabled = !(okLong && okCoincide);
    }
    nueva.addEventListener('input', validar);
    confirma.addEventListener('input', validar);
})();
</script>
</body>
</html>
