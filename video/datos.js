// datos.js - textos editables del video promocional
window.DATOS = {
  titulo: "ProyectoFinalLP2",
  subtitulo: "Sistema web de inventario y punto de venta",
  equipo: "Equipo ProyectoFinalLP2",
  fraseFinal: "Gestiona tu inventario con control, seguridad y estilo.",
  escenas: {
    s1: { titulo: "ProyectoFinalLP2", frase: "Sistema web de inventario y punto de venta" },
    s2: {
      ideas: [
        "Controla productos, categorías y unidades de medida.",
        "Gestiona clientes y proveedores en un solo lugar.",
        "Acceso por roles con seguridad BCrypt."
      ]
    },
    s3: {
      titulo: "Acceso seguro",
      puntos: [
        "Roles: Administrador y Empleado.",
        "Contraseñas protegidas con BCrypt.",
        "Cambio de clave temporal al primer ingreso."
      ]
    },
    s4: {
      titulo: "Dashboard",
      indicadores: ["Stock bajo", "Valor del inventario", "Productos agotados"]
    },
    s5: {
      titulo: "Módulo de Productos",
      funciones: ["Búsqueda y filtros", "Paginación", "Control de stock", "Confirmación al eliminar"]
    },
    s6: {
      titulo: "Tecnología",
      techs: ["Java 21", "Servlet y JSP", "Tomcat 10.1", "SQL Server", "Maven"],
      capas: ["model", "dao", "controlador"]
    },
    s7: { frase: "Gestiona tu inventario con control, seguridad y estilo." }
  },
  categorias: ["Bebidas", "Lácteos", "Abarrotes", "Limpieza"],
  productos: [
    { codigo: "BEB-001", desc: "Agua mineral 500ml", precio: "0.75", cantidad: 100 },
    { codigo: "BEB-002", desc: "Gaseosa 2L", precio: "1.80", cantidad: 60 },
    { codigo: "LAC-001", desc: "Leche entera 1L", precio: "1.40", cantidad: 80 },
    { codigo: "ABA-001", desc: "Arroz 5lb", precio: "3.75", cantidad: 50 }
  ]
};
