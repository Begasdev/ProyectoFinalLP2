/* ============================================================
   Proyecto Final LP2 - Sistema Web de Gestión de Inventario y Punto de Venta
   Script de creación de base de datos y tablas
   Base de datos: ProyectoFinalLP2
   Motor: Microsoft SQL Server
   ============================================================ */

IF DB_ID('ProyectoFinalLP2') IS NULL
BEGIN
    CREATE DATABASE ProyectoFinalLP2;
END
GO

USE ProyectoFinalLP2;
GO

/* ---------- Eliminar tablas existentes (para re-ejecución) ---------- */
-- Orden según claves foráneas: primero las dependientes.
DROP TABLE IF EXISTS dbo.Producto;
DROP TABLE IF EXISTS dbo.Categoria;
DROP TABLE IF EXISTS dbo.UnidadMedida;
DROP TABLE IF EXISTS dbo.Usuario;
DROP TABLE IF EXISTS dbo.Rol;
DROP TABLE IF EXISTS dbo.Cliente;
DROP TABLE IF EXISTS dbo.Proveedor;
GO

/* ---------- Rol ---------- */
IF OBJECT_ID('dbo.Rol', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Rol
    (
        IdRol        INT IDENTITY(1,1) PRIMARY KEY,
        NombreRol    NVARCHAR(50) NOT NULL UNIQUE,
        Descripcion  NVARCHAR(200) NULL,
        Activo       BIT NOT NULL DEFAULT 1
    );
END
GO

/* ---------- Usuario ---------- */
IF OBJECT_ID('dbo.Usuario', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Usuario
    (
        IdUsuario       INT IDENTITY(1,1) PRIMARY KEY,
        IdRol           INT NOT NULL,
        NombreCompleto  NVARCHAR(100) NOT NULL,
        NombreUsuario   NVARCHAR(50) NOT NULL UNIQUE,
        Clave           NVARCHAR(255) NOT NULL,
        ResetearClave   BIT NOT NULL DEFAULT 0,
        Activo          BIT NOT NULL DEFAULT 1,
        FechaCreacion   DATETIME2 NOT NULL DEFAULT GETDATE(),
        CONSTRAINT FK_Usuario_Rol FOREIGN KEY (IdRol) REFERENCES dbo.Rol(IdRol)
    );
END
GO

/* ---------- UnidadMedida ---------- */
IF OBJECT_ID('dbo.UnidadMedida', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.UnidadMedida
    (
        IdUnidadMedida INT IDENTITY(1,1) PRIMARY KEY,
        Nombre         NVARCHAR(50) NOT NULL,
        Abreviatura    NVARCHAR(10) NOT NULL,
        Activo         BIT NOT NULL DEFAULT 1
    );
END
GO

/* ---------- Categoria ---------- */
IF OBJECT_ID('dbo.Categoria', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Categoria
    (
        IdCategoria     INT IDENTITY(1,1) PRIMARY KEY,
        IdUnidadMedida  INT NOT NULL,
        Nombre          NVARCHAR(80) NOT NULL,
        Descripcion     NVARCHAR(200) NULL,
        Activo          BIT NOT NULL DEFAULT 1,
        CONSTRAINT FK_Categoria_UnidadMedida FOREIGN KEY (IdUnidadMedida)
            REFERENCES dbo.UnidadMedida(IdUnidadMedida)
    );
END
GO

/* ---------- Producto ---------- */
IF OBJECT_ID('dbo.Producto', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Producto
    (
        IdProducto     INT IDENTITY(1,1) PRIMARY KEY,
        IdCategoria    INT NOT NULL,
        Codigo         NVARCHAR(30) NOT NULL UNIQUE,
        Descripcion    NVARCHAR(150) NOT NULL,
        PrecioCompra   DECIMAL(10,2) NOT NULL DEFAULT 0,
        PrecioVenta    DECIMAL(10,2) NOT NULL DEFAULT 0,
        Cantidad       INT NOT NULL DEFAULT 0,
        Activo         BIT NOT NULL DEFAULT 1,
        FechaCreacion  DATETIME2 NOT NULL DEFAULT GETDATE(),
        CONSTRAINT FK_Producto_Categoria FOREIGN KEY (IdCategoria)
            REFERENCES dbo.Categoria(IdCategoria)
    );
END
GO

/* ---------- Cliente (módulo adicional) ---------- */
IF OBJECT_ID('dbo.Cliente', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Cliente
    (
        IdCliente      INT IDENTITY(1,1) PRIMARY KEY,
        Nombre         NVARCHAR(80) NOT NULL,
        Apellido       NVARCHAR(80) NULL,
        Telefono       NVARCHAR(20) NULL,
        Email          NVARCHAR(100) NULL,
        Direccion      NVARCHAR(200) NULL,
        Activo         BIT NOT NULL DEFAULT 1,
        FechaRegistro  DATETIME2 NOT NULL DEFAULT GETDATE()
    );
END
GO

/* ---------- Proveedor (módulo adicional) ---------- */
IF OBJECT_ID('dbo.Proveedor', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Proveedor
    (
        IdProveedor    INT IDENTITY(1,1) PRIMARY KEY,
        NombreEmpresa  NVARCHAR(120) NOT NULL,
        Contacto       NVARCHAR(80) NULL,
        Telefono       NVARCHAR(20) NULL,
        Email          NVARCHAR(100) NULL,
        Direccion      NVARCHAR(200) NULL,
        Activo         BIT NOT NULL DEFAULT 1,
        FechaRegistro  DATETIME2 NOT NULL DEFAULT GETDATE()
    );
END
GO
