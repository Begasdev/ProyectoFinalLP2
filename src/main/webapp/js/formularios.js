// formularios.js - estado de carga reutilizable para formularios
(function () {
    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('form').forEach(function (form) {
            form.addEventListener('submit', function () {
                var btn = form.querySelector('button[type="submit"]');
                if (btn && !btn.disabled) {
                    btn.disabled = true;
                    var texto = btn.getAttribute('data-loading-text') || 'Procesando...';
                    btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>' + texto;
                }
            });
        });
    });
})();
