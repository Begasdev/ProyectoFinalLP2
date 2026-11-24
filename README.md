# POOpy

Proyecto web (HTML/CSS/JS) con conexión a base de datos, desplegable en Vercel.

## Estructura

- `index.html` — página principal
- `css/styles.css` — estilos
- `js/app.js` — lógica y conexión a la base de datos

## Base de datos

Configura las credenciales en `js/app.js` (Supabase recomendado para Vercel).
No subas claves secretas; usa variables de entorno cuando corresponda.

## Despliegue en Vercel

1. Sube el repositorio a GitHub.
2. Importa el proyecto en https://vercel.com.
3. Vercel detectará el sitio estático y lo publicará.
