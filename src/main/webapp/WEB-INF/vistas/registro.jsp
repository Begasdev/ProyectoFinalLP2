<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ProyectoFinalLP2 - Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body class="bg-apple d-flex align-items-center login-wrapper">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="text-center mb-4 fade-in">
                <i class="fa-solid fa-user-plus fa-3x text-primary"></i>
                <h2 class="fw-bold mt-2">Crear cuenta</h2>
                <p class="text-muted">Regístrate en ProyectoFinalLP2</p>
            </div>
            <div class="card apple-card p-4 fade-in">
                <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger"><i class="fa-solid fa-circle-exclamation me-2"></i><%= request.getAttribute("error") %></div>
                <% } %>
                <form action="${pageContext.request.contextPath}/registro" method="post" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label for="nombreCompleto" class="form-label fw-medium">Nombre completo</label>
                        <input type="text" id="nombreCompleto" name="nombreCompleto" class="form-control" required>
                        <div class="invalid-feedback">El nombre es obligatorio.</div>
                    </div>
                    <div class="mb-3">
                        <label for="nombreUsuario" class="form-label fw-medium">Usuario</label>
                        <input type="text" id="nombreUsuario" name="nombreUsuario" class="form-control" autocomplete="username" required>
                        <div class="invalid-feedback">El usuario es obligatorio.</div>
                    </div>
                    <div class="mb-3">
                        <label for="clave" class="form-label fw-medium">Contraseña</label>
                        <div class="input-group">
                            <input type="password" id="clave" name="clave" class="form-control" autocomplete="new-password" minlength="8" required>
                            <button type="button" class="btn btn-outline-secondary" onclick="togglePassword('clave', this)" aria-label="Mostrar contraseña">
                                <i class="fa-solid fa-eye"></i>
                            </button>
                        </div>
                        <div class="invalid-feedback">Mínimo 8 caracteres.</div>
                    </div>
                    <div class="mb-3">
                        <label for="confirmarClave" class="form-label fw-medium">Confirmar contraseña</label>
                        <div class="input-group">
                            <input type="password" id="confirmarClave" name="confirmarClave" class="form-control" autocomplete="new-password" required>
                            <button type="button" class="btn btn-outline-secondary" onclick="togglePassword('confirmarClave', this)" aria-label="Mostrar contraseña">
                                <i class="fa-solid fa-eye"></i>
                            </button>
                        </div>
                        <div class="invalid-feedback">Confirma tu contraseña.</div>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 py-2 mt-2" data-loading-text="Registrando...">
                        <i class="fa-solid fa-user-plus me-2"></i>Registrarse
                    </button>
                </form>
                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/login" class="small">¿Ya tienes cuenta? Inicia sesión</a>
                </div>
            </div>
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
