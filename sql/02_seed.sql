/* ============================================================
   Proyecto Final LP2 - Datos de prueba
   ============================================================ */
USE ProyectoFinalLP2;
GO

/* ---------- Rol ---------- */
IF NOT EXISTS (SELECT 1 FROM dbo.Rol)
BEGIN
    INSERT INTO dbo.Rol (NombreRol, Descripcion) VALUES
        (N'Administrador', N'Acceso total al sistema'),
        (N'Empleado', N'Acceso a módulos operativos');
END
GO

/* ---------- Usuario ---------- */
-- Hashes BCrypt (cost 10). admin123 / empleado123
IF NOT EXISTS (SELECT 1 FROM dbo.Usuario)
BEGIN
    INSERT INTO dbo.Usuario (IdRol, NombreCompleto, NombreUsuario, Clave, ResetearClave, Activo) VALUES
        (1, N'Administrador del Sistema', N'admin',     N'$2b$10$WIfQuv4zCzWwIgA70IRyAurCEKP8/Mc1CDXxVzDk7D24aneF80Y.q', 0, 1),
        (2, N'Empleado de Prueba',       N'empleado', N'$2b$10$gDeEOC2c.Qv4itj1/ImNy.Boz.wGzB9AFb9QFahSdbw8EBUjNynb.', 1, 1);
END
GO

/* ---------- UnidadMedida ---------- */
IF NOT EXISTS (SELECT 1 FROM dbo.UnidadMedida)
BEGIN
    INSERT INTO dbo.UnidadMedida (Nombre, Abreviatura) VALUES
        (N'Unidad', N'und'),
        (N'Kilogramo', N'kg'),
        (N'Litro', N'L'),
        (N'Metro', N'm'),
        (N'Caja', N'cja'),
        (N'Paquete', N'pqt');
END
GO

/* ---------- Categoria ---------- */
IF NOT EXISTS (SELECT 1 FROM dbo.Categoria)
BEGIN
    INSERT INTO dbo.Categoria (IdUnidadMedida, Nombre, Descripcion) VALUES
        (1, N'Bebidas',   N'Bebidas en general'),
        (3, N'Lácteos',   N'Productos lácteos'),
        (1, N'Abarrotes', N'Productos de abarrotería'),
        (1, N'Limpieza',  N'Artículos de limpieza');
END
GO

/* ---------- Producto ---------- */
IF NOT EXISTS (SELECT 1 FROM dbo.Producto)
BEGIN
    INSERT INTO dbo.Producto (IdCategoria, Codigo, Descripcion, PrecioCompra, PrecioVenta, Cantidad) VALUES
        (1, N'BEB-001', N'Agua mineral 500ml',   0.30,  0.75, 100),
        (1, N'BEB-002', N'Gaseosa 2L',           0.90,  1.80,  60),
        (2, N'LAC-001', N'Leche entera 1L',      0.85,  1.40,  80),
        (2, N'LAC-002', N'Yogurt natural 1L',    1.10,  1.90,  40),
        (3, N'ABA-001', N'Arroz 5lb',            2.50,  3.75,  50),
        (3, N'ABA-002', N'Azúcar 2lb',           1.20,  1.90,  70),
        (4, N'LIM-001', N'Detergente 1L',        1.80,  3.00,  30),
        (4, N'LIM-002', N'Jabón de baño',        0.40,  0.90, 120);
END
GO

/* ---------- Cliente ---------- */
IF NOT EXISTS (SELECT 1 FROM dbo.Cliente)
BEGIN
    INSERT INTO dbo.Cliente (Nombre, Apellido, Telefono, Email, Direccion) VALUES
        (N'Juan',   N'Pérez',   N'6000-0001', N'juan.perez@example.com',   N'Calle 1, Ciudad de Panamá'),
        (N'María',  N'Gómez',   N'6000-0002', N'maria.gomez@example.com',  N'Calle 2, Ciudad de Panamá'),
        (N'Carlos', N'Rodríguez',N'6000-0003', N'carlos.rodriguez@example.com', N'Calle 3, Ciudad de Panamá');
END
GO

/* ---------- Proveedor ---------- */
IF NOT EXISTS (SELECT 1 FROM dbo.Proveedor)
BEGIN
    INSERT INTO dbo.Proveedor (NombreEmpresa, Contacto, Telefono, Email, Direccion) VALUES
        (N'Distribuidora El Sol',   N'Ana López',    N'2000-0001', N'ventas@elsol.com',   N'Zona Industrial'),
        (N'Alimentos del Istmo',   N'Pedro Díaz',   N'2000-0002', N'info@istmo.com',     N'Parque Logístico'),
        (N'Limpieza Total S.A.',   N'Luisa Chen',   N'2000-0003', N'contacto@limpieza.com', N'Centro Comercial');
END
GO
