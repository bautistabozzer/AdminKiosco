-- *******************************************************
-- Script para la inserción de datos en la base de datos
-- Sistema de Gestión para Kiosco (AdminKiosco)
-- Bautista Bozzer
-- *******************************************************

-- base de datos
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

-- 7. Tabla: Producto
INSERT INTO Producto (Nombre, Precio, Stock, ID_Categoria, ID_Proveedor) VALUES
('Coca-Cola 500ml', 1.50, 100, 1, 3),
('Pepsi 500ml', 1.40, 80, 1, 3),
('Agua Mineral 500ml', 1.00, 120, 1, 3),
('Jugo de Naranja 1L', 2.00, 50, 1, 2),
('Papas Fritas Clásicas', 0.99, 60, 2, 1),
('Galletas de Chocolate', 1.20, 70, 2, 1),
('Barra de Cereal', 0.80, 90, 2, 1),
('Caramelos Masticables', 0.05, 500, 3, 4),
('Chocolatina', 0.50, 200, 3, 4),
('Chicle de Menta', 0.10, 300, 3, 4),
('Yogur Natural', 1.00, 40, 4, 2),
('Leche Entera 1L', 1.20, 60, 4, 2),
('Queso Cremoso 200g', 2.50, 30, 4, 2),
('Desodorante Corporal', 3.00, 25, 5, 5),
('Shampoo 500ml', 2.80, 35, 5, 5),
('Pasta Dental', 1.50, 45, 5, 5),
('Bebida Energizante 500ml', 2.00, 40, 1, 3),
('Gaseosa de Lima 500ml', 1.50, 70, 1, 3),
('Galletas Saladas', 0.90, 80, 2, 1),
('Helado en Vasito', 1.50, 50, 2, 1);

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

-- 10. Tabla: Venta
-- Inserción de 10 ventas (primera instancia, para pruebas)
-- calculamos manualmente el 'Total' de cada venta sumando los productos vendidos

-- Venta 1
INSERT INTO Venta (Fecha_Venta, Total, ID_Cliente, ID_Empleado, ID_Metodo_Pago)
VALUES ('2023-07-01 10:15:00', 3.69, 1, 1, 1);

-- Venta 2
INSERT INTO Venta (Fecha_Venta, Total, ID_Cliente, ID_Empleado, ID_Metodo_Pago)
VALUES ('2023-07-01 11:30:00', 3.30, 2, 2, 2);

-- Venta 3
INSERT INTO Venta (Fecha_Venta, Total, ID_Cliente, ID_Empleado, ID_Metodo_Pago)
VALUES ('2023-07-02 12:45:00', 2.25, 3, 1, 3);

-- Venta 4
INSERT INTO Venta (Fecha_Venta, Total, ID_Cliente, ID_Empleado, ID_Metodo_Pago)
VALUES ('2023-07-02 14:00:00', 3.40, 4, 2, 1);

-- Venta 5
INSERT INTO Venta (Fecha_Venta, Total, ID_Cliente, ID_Empleado, ID_Metodo_Pago)
VALUES ('2023-07-03 15:15:00', 3.00, 5, 3, 2);

-- Venta 6
INSERT INTO Venta (Fecha_Venta, Total, ID_Cliente, ID_Empleado, ID_Metodo_Pago)
VALUES ('2023-07-03 16:30:00', 6.00, 6, 4, 1);

-- Venta 7
INSERT INTO Venta (Fecha_Venta, Total, ID_Cliente, ID_Empleado, ID_Metodo_Pago)
VALUES ('2023-07-04 17:45:00', 3.00, 7, 1, 3);

-- Venta 8
INSERT INTO Venta (Fecha_Venta, Total, ID_Cliente, ID_Empleado, ID_Metodo_Pago)
VALUES ('2023-07-04 19:00:00', 2.50, 8, 2, 2);

-- Venta 9
INSERT INTO Venta (Fecha_Venta, Total, ID_Cliente, ID_Empleado, ID_Metodo_Pago)
VALUES ('2023-07-05 10:15:00', 0.50, 9, 3, 1);

-- Venta 10
INSERT INTO Venta (Fecha_Venta, Total, ID_Cliente, ID_Empleado, ID_Metodo_Pago)
VALUES ('2023-07-05 11:30:00', 1.50, 10, 4, 2);

-- 11. Tabla: Detalle_Venta
-- añadir detalles para cada venta, asegurándonos de que el total coincide con los productos vendidos

-- Venta 1 Detalles
INSERT INTO Detalle_Venta (ID_Venta, ID_Producto, Cantidad, Precio_Unitario) VALUES
(1, 1, 2, 1.35),  -- Coca-Cola con descuento (10% de descuento en 1.50)
(1, 5, 1, 0.99);

-- Venta 2 Detalles
INSERT INTO Detalle_Venta (ID_Venta, ID_Producto, Cantidad, Precio_Unitario) VALUES
(2, 3, 1, 0.90),  -- Agua Mineral con descuento (10% de descuento en 1.00)
(2, 6, 2, 1.20);

-- Venta 3 Detalles
INSERT INTO Detalle_Venta (ID_Venta, ID_Producto, Cantidad, Precio_Unitario) VALUES
(3, 9, 5, 0.45);  -- Chocolatina con descuento (10% de descuento en 0.50)

-- Venta 4 Detalles
INSERT INTO Detalle_Venta (ID_Venta, ID_Producto, Cantidad, Precio_Unitario) VALUES
(4, 11, 1, 1.00),
(4, 12, 2, 1.20);

-- Venta 5 Detalles
INSERT INTO Detalle_Venta (ID_Venta, ID_Producto, Cantidad, Precio_Unitario) VALUES
(5, 14, 1, 3.00);

-- Venta 6 Detalles
INSERT INTO Detalle_Venta (ID_Venta, ID_Producto, Cantidad, Precio_Unitario) VALUES
(6, 17, 3, 2.00);

-- Venta 7 Detalles
INSERT INTO Detalle_Venta (ID_Venta, ID_Producto, Cantidad, Precio_Unitario) VALUES
(7, 2, 1, 1.40),
(7, 7, 2, 0.80);

-- Venta 8 Detalles
INSERT INTO Detalle_Venta (ID_Venta, ID_Producto, Cantidad, Precio_Unitario) VALUES
(8, 13, 1, 2.50);

-- Venta 9 Detalles
INSERT INTO Detalle_Venta (ID_Venta, ID_Producto, Cantidad, Precio_Unitario) VALUES
(9, 8, 10, 0.05);

-- Venta 10 Detalles
INSERT INTO Detalle_Venta (ID_Venta, ID_Producto, Cantidad, Precio_Unitario) VALUES
(10, 15, 1, 2.80);

-- 12. Tabla: Orden_Compra
-- Inserción de 3 órdenes de compra
INSERT INTO Orden_Compra (Fecha_Orden, ID_Proveedor, ID_Empleado, Estado) VALUES
('2023-06-25 09:00:00', 1, 3, 'Pendiente'),
('2023-06-26 10:30:00', 2, 4, 'Completada'),
('2023-06-27 11:45:00', 3, 1, 'En Proceso');

-- 13. Tabla: Detalle_Orden
-- Detalles para cada orden de compra
INSERT INTO Detalle_Orden (ID_Orden, ID_Producto, Cantidad, Precio_Compra) VALUES
(1, 5, 100, 0.70),
(1, 6, 80, 0.90),
(2, 4, 50, 1.80),
(2, 11, 60, 0.90),
(3, 1, 200, 1.20),
(3, 2, 150, 1.10);

-- 14. Tabla: Inventario_Movimiento
-- Movimientos de inventario (entradas)
INSERT INTO Inventario_Movimiento (ID_Producto, Fecha_Movimiento, Tipo_Movimiento, Cantidad, ID_Empleado) VALUES
(5, '2023-06-25 12:00:00', 'Entrada', 100, 3),
(6, '2023-06-25 12:05:00', 'Entrada', 80, 3),
(4, '2023-06-26 15:00:00', 'Entrada', 50, 4),
(11, '2023-06-26 15:10:00', 'Entrada', 60, 4),
(1, '2023-06-27 16:00:00', 'Entrada', 200, 1),
(2, '2023-06-27 16:15:00', 'Entrada', 150, 1);

-- 15. Tabla: Devolucion
-- Inserción de 2 devoluciones
INSERT INTO Devolucion (ID_Venta, Fecha_Devolucion, Motivo) VALUES
(1, '2023-07-02 10:00:00', 'Producto en mal estado'),
(3, '2023-07-03 11:00:00', 'Error en la compra');

-- 16. Tabla: Detalle_Devolucion
-- Detalles para cada devolución
INSERT INTO Detalle_Devolucion (ID_Devolucion, ID_Producto, Cantidad) VALUES
(1, 1, 1),
(2, 9, 2);

-- Nota: Como esto es una primera entrega, no utilizamos procedimientos almacenados para actualizar el stock, debemos ajustar el stock manualmente tras las devoluciones y ventas.

-- 17. Actualización manual del stock en la tabla Producto

-- Ajuste de stock por ventas
-- Por cada producto vendido, restamos la cantidad vendida del stock
UPDATE Producto SET Stock = Stock - 2 WHERE ID_Producto = 1;  -- Venta 1
UPDATE Producto SET Stock = Stock - 1 WHERE ID_Producto = 5;  -- Venta 1
UPDATE Producto SET Stock = Stock - 1 WHERE ID_Producto = 3;  -- Venta 2
UPDATE Producto SET Stock = Stock - 2 WHERE ID_Producto = 6;  -- Venta 2
UPDATE Producto SET Stock = Stock - 5 WHERE ID_Producto = 9;  -- Venta 3
UPDATE Producto SET Stock = Stock - 1 WHERE ID_Producto = 11; -- Venta 4
UPDATE Producto SET Stock = Stock - 2 WHERE ID_Producto = 12; -- Venta 4
UPDATE Producto SET Stock = Stock - 1 WHERE ID_Producto = 14; -- Venta 5
UPDATE Producto SET Stock = Stock - 3 WHERE ID_Producto = 17; -- Venta 6
UPDATE Producto SET Stock = Stock - 1 WHERE ID_Producto = 2;  -- Venta 7
UPDATE Producto SET Stock = Stock - 2 WHERE ID_Producto = 7;  -- Venta 7
UPDATE Producto SET Stock = Stock - 1 WHERE ID_Producto = 13; -- Venta 8
UPDATE Producto SET Stock = Stock -10 WHERE ID_Producto = 8;  -- Venta 9
UPDATE Producto SET Stock = Stock - 1 WHERE ID_Producto = 15; -- Venta 10

-- Ajuste de stock por devoluciones
-- Por cada producto devuelto, sumamos la cantidad devuelta al stock
UPDATE Producto SET Stock = Stock + 1 WHERE ID_Producto = 1;  -- Devolución 1
UPDATE Producto SET Stock = Stock + 2 WHERE ID_Producto = 9;  -- Devolución 2

-- Ahora el stock está actualizado manualmente, en la proxima entrega lo realizare con sp.
-- *******************************************************
