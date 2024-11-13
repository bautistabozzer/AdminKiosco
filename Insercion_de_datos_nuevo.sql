-- *******************************************************
-- Script para la inserción de datos en la base de datos
-- Sistema de Gestión para Kiosco (AdminKiosco)
-- Bautista Bozzer
-- *******************************************************

-- Base de datos
USE Kiosco;

-- *******************************************************
-- INSERCIÓN DE DATOS
-- *******************************************************

-- 1. Tabla: Categoria
INSERT INTO Categoria (Nombre_Categoria) VALUES
('Bebidas'),
('Snacks'),
('Dulces'),
('Lácteos'),
('Higiene Personal');

-- 2. Tabla: Proveedor
INSERT INTO Proveedor (Nombre, Contacto, Telefono) VALUES
('Distribuidora Central', 'María Pérez', '1112345678'),
('Alimentos del Norte', 'Carlos Gómez', '1123456789'),
('Bebidas Nacionales', 'Ana López', '1134567890'),
('Confitería Sur', 'Juan Ramírez', '1145678901'),
('Higiene y Salud', 'Laura Fernández', '1156789012');

-- 3. Tabla: Puesto
INSERT INTO Puesto (Nombre_Puesto, Salario) VALUES
('Cajero', 30000.00),
('Gerente', 50000.00),
('Repositor', 28000.00);

-- 4. Tabla: Empleado
INSERT INTO Empleado (Nombre, Apellido, ID_Puesto) VALUES
('Carlos', 'García', 1),
('Ana', 'Martínez', 1),
('Luis', 'Fernández', 3),
('Sofía', 'Gómez', 2);

-- 5. Tabla: Metodo_Pago
INSERT INTO Metodo_Pago (Descripcion) VALUES
('Efectivo'),
('Tarjeta de Crédito'),
('Tarjeta de Débito');

-- 6. Tabla: Cliente
INSERT INTO Cliente (Nombre, Apellido, Email, Telefono) VALUES
('Lucía', 'Herrera', 'lucia.herrera@example.com', '1167890123'),
('Diego', 'Martínez', 'diego.martinez@example.com', '1178901234'),
('Valentina', 'Sánchez', 'valentina.sanchez@example.com', '1189012345'),
('Javier', 'Díaz', 'javier.diaz@example.com', '1190123456'),
('Camila', 'Pérez', 'camila.perez@example.com', '1101234567'),
('Martín', 'González', 'martin.gonzalez@example.com', '1112345678'),
('Florencia', 'López', 'florencia.lopez@example.com', '1123456789'),
('Mateo', 'Gómez', 'mateo.gomez@example.com', '1134567890'),
('Sofía', 'Rodríguez', 'sofia.rodriguez@example.com', '1145678901'),
('Tomás', 'Fernández', 'tomas.fernandez@example.com', '1156789012');

-- 7. Tabla: Producto (usando procedimiento almacenado)
CALL AgregarProducto('Coca-Cola 500ml', 1.50, 100, 1, 3);
CALL AgregarProducto('Pepsi 500ml', 1.40, 80, 1, 3);
CALL AgregarProducto('Agua Mineral 500ml', 1.00, 120, 1, 3);
CALL AgregarProducto('Jugo de Naranja 1L', 2.00, 50, 1, 2);
CALL AgregarProducto('Papas Fritas Clásicas', 0.99, 60, 2, 1);
CALL AgregarProducto('Galletas de Chocolate', 1.20, 70, 2, 1);
CALL AgregarProducto('Barra de Cereal', 0.80, 90, 2, 1);
CALL AgregarProducto('Caramelos Masticables', 0.05, 500, 3, 4);
CALL AgregarProducto('Chocolatina', 0.50, 200, 3, 4);
CALL AgregarProducto('Chicle de Menta', 0.10, 300, 3, 4);
CALL AgregarProducto('Yogur Natural', 1.00, 40, 4, 2);
CALL AgregarProducto('Leche Entera 1L', 1.20, 60, 4, 2);
CALL AgregarProducto('Queso Cremoso 200g', 2.50, 30, 4, 2);
CALL AgregarProducto('Desodorante Corporal', 3.00, 25, 5, 5);
CALL AgregarProducto('Shampoo 500ml', 2.80, 35, 5, 5);
CALL AgregarProducto('Pasta Dental', 1.50, 45, 5, 5);
CALL AgregarProducto('Bebida Energizante 500ml', 2.00, 40, 1, 3);
CALL AgregarProducto('Gaseosa de Lima 500ml', 1.50, 70, 1, 3);
CALL AgregarProducto('Galletas Saladas', 0.90, 80, 2, 1);
CALL AgregarProducto('Helado en Vasito', 1.50, 50, 2, 1);

-- 8. Tabla: Promocion
INSERT INTO Promocion (Descripcion, Fecha_Inicio, Fecha_Fin, Descuento) VALUES
('Descuento de Verano', '2023-06-01', '2023-08-31', 10.00),
('Promo Fin de Semana', '2023-07-01', '2023-07-31', 5.00);

-- 9. Tabla: Producto_Promocion
INSERT INTO Producto_Promocion (ID_Producto, ID_Promocion) VALUES
(1, 1),
(3, 1),
(5, 2),
(9, 2);

-- 10. Tabla: Venta (usando procedimiento almacenado)
CALL RegistrarVenta(1, 1, 1, 3.69, '2023-07-01 10:15:00');
CALL RegistrarVenta(2, 2, 2, 3.30, '2023-07-01 11:30:00');
CALL RegistrarVenta(3, 1, 3, 2.25, '2023-07-02 12:45:00');
CALL RegistrarVenta(4, 2, 1, 3.40, '2023-07-02 14:00:00');
CALL RegistrarVenta(5, 3, 2, 3.00, '2023-07-03 15:15:00');
CALL RegistrarVenta(6, 4, 1, 6.00, '2023-07-03 16:30:00');
CALL RegistrarVenta(7, 1, 3, 3.00, '2023-07-04 17:45:00');
CALL RegistrarVenta(8, 2, 2, 2.50, '2023-07-04 19:00:00');
CALL RegistrarVenta(9, 3, 1, 0.50, '2023-07-05 10:15:00');
CALL RegistrarVenta(10, 4, 2, 1.50, '2023-07-05 11:30:00');

-- 11. Tabla: Detalle_Venta
INSERT INTO Detalle_Venta (ID_Venta, ID_Producto, Cantidad, Precio_Unitario) VALUES
(1, 1, 2, 5.06),
(1, 5, 1, 0.99),
(2, 3, 1, 5.6),
(2, 6, 2, 1.20),
(3, 9, 5, 1.69),
(4, 11, 1, 1.00),
(4, 12, 2, 1.20),
(5, 14, 1, 3.00),
(6, 17, 3, 2.00),
(7, 2, 1, 1.40),
(7, 7, 2, 0.80),
(8, 13, 1, 2.50),
(9, 8, 10, 0.05),
(10, 15, 1, 2.80);

-- 12. Tabla: Orden_Compra
INSERT INTO Orden_Compra (Fecha_Orden, ID_Proveedor, ID_Empleado, Estado) VALUES
('2023-06-25 09:00:00', 1, 3, 'Pendiente'),
('2023-06-26 10:30:00', 2, 4, 'Completada'),
('2023-06-27 11:45:00', 3, 1, 'En Proceso');

-- 13. Tabla: Detalle_Orden
INSERT INTO Detalle_Orden (ID_Orden, ID_Producto, Cantidad, Precio_Compra) VALUES
(1, 5, 100, 0.70),
(1, 6, 80, 0.90),
(2, 4, 50, 1.80),
(2, 11, 60, 0.90),
(3, 1, 200, 1.20),
(3, 2, 150, 1.10);

-- 14. Tabla: Inventario_Movimiento
INSERT INTO Inventario_Movimiento (ID_Producto, Fecha_Movimiento, Tipo_Movimiento, Cantidad, ID_Empleado) VALUES
(5, '2023-06-25 12:00:00', 'Entrada', 100, 3),
(6, '2023-06-25 12:05:00', 'Entrada', 80, 3),
(4, '2023-06-26 15:00:00', 'Entrada', 50, 4),
(11, '2023-06-26 15:10:00', 'Entrada', 60, 4),
(1, '2023-06-27 16:00:00', 'Entrada', 200, 1),
(2, '2023-06-27 16:15:00', 'Entrada', 150, 1);

-- 15. Tabla: Devolucion
INSERT INTO Devolucion (ID_Venta, Fecha_Devolucion, Motivo) VALUES
(1, '2023-07-02 10:00:00', 'Producto en mal estado'),
(3, '2023-07-03 11:00:00', 'Error en la compra');

-- 16. Tabla: Detalle_Devolucion
INSERT INTO Detalle_Devolucion (ID_Devolucion, ID_Producto, Cantidad) VALUES
(1, 1, 1),
(2, 9, 2);

-- *******************************************************
