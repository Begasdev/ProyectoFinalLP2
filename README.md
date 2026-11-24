# ProyectoFinalLP2

Sistema Web de Gestión de Inventario y Punto de Venta.

- Java 21, Maven, Jakarta Servlet/JSP
- Apache Tomcat 10.1
- SQL Server (base de datos `ProyectoFinalLP2`)
- BCrypt para contraseñas

## Estructura

- `pom.xml` — dependencias Maven (Servlet, JSP, JDBC, jbcrypt)
- `src/main/java/com/sysventas/proyectofinal/` — config, model, dao, controlador
- `src/main/webapp/` — JSPs, CSS
- `sql/` — scripts de creación y datos de prueba

## Base de datos

Ejecutar en orden:
1. `sql/01_schema.sql`
2. `sql/02_seed.sql`

Usuarios de prueba:
- `admin` / `admin123` (Administrador)
- `empleado` / `empleado123` (Empleado, debe cambiar contraseña)

## Ejecución

1. Configurar variables de entorno en IntelliJ/Tomcat:
   - `DB_URL=jdbc:sqlserver://localhost:1433;databaseName=ProyectoFinalLP2;encrypt=true;trustServerCertificate=true`
   - `DB_USER=sa` (o tu usuario)
   - `DB_PASSWORD=tu_contraseña`
2. Ejecutar `ProbarConexion` para verificar conexión.
3. Desplegar en Tomcat con contexto `/ProyectoFinalLP2`.

## Módulos

Base: Rol, Usuario, UnidadMedida, Categoria, Producto.
Adicionales: Cliente, Proveedor.
