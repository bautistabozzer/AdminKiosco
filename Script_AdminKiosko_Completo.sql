-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS Kiosco;
USE Kiosco;

-- Tabla: Categoria
CREATE TABLE Categoria (
    ID_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Categoria VARCHAR(50) NOT NULL
);

-- Tabla: Proveedor
CREATE TABLE Proveedor (
    ID_Proveedor INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Contacto VARCHAR(100),
    Telefono VARCHAR(15)
);

-- Tabla: Producto
CREATE TABLE Producto (
    ID_Producto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL DEFAULT 0,
    ID_Categoria INT NOT NULL,
    ID_Proveedor INT NOT NULL,
    FOREIGN KEY (ID_Categoria) REFERENCES Categoria(ID_Categoria),
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor(ID_Proveedor)
);

-- Tabla: Cliente
CREATE TABLE Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Telefono VARCHAR(15)
);

-- Tabla: Puesto
CREATE TABLE Puesto (
    ID_Puesto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Puesto VARCHAR(50) NOT NULL,
    Salario DECIMAL(10,2) NOT NULL
);

-- Tabla: Empleado
CREATE TABLE Empleado (
    ID_Empleado INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    ID_Puesto INT NOT NULL,
    FOREIGN KEY (ID_Puesto) REFERENCES Puesto(ID_Puesto)
);

-- Tabla: Metodo_Pago
CREATE TABLE Metodo_Pago (
    ID_Metodo_Pago INT AUTO_INCREMENT PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL
);

-- Tabla: Venta 
CREATE TABLE Venta (
    ID_Venta INT AUTO_INCREMENT PRIMARY KEY,
    Fecha_Venta DATETIME NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    ID_Cliente INT,
    ID_Empleado INT NOT NULL,
    ID_Metodo_Pago INT NOT NULL,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
    FOREIGN KEY (ID_Empleado) REFERENCES Empleado(ID_Empleado),
    FOREIGN KEY (ID_Metodo_Pago) REFERENCES Metodo_Pago(ID_Metodo_Pago)
);

-- Tabla: Detalle_Venta 
CREATE TABLE Detalle_Venta (
    ID_Venta INT NOT NULL,
    ID_Producto INT NOT NULL,
    Cantidad INT NOT NULL,
    Precio_Unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (ID_Venta, ID_Producto),
    FOREIGN KEY (ID_Venta) REFERENCES Venta(ID_Venta),
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto)
);

-- Tabla: Inventario_Movimiento
CREATE TABLE Inventario_Movimiento (
    ID_Movimiento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Producto INT NOT NULL,
    Fecha_Movimiento DATETIME NOT NULL,
    Tipo_Movimiento ENUM('Entrada', 'Salida') NOT NULL,
    Cantidad INT NOT NULL,
    ID_Empleado INT NOT NULL,
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto),
    FOREIGN KEY (ID_Empleado) REFERENCES Empleado(ID_Empleado)
);

-- Tabla: Orden_Compra 
CREATE TABLE Orden_Compra (
    ID_Orden INT AUTO_INCREMENT PRIMARY KEY,
    Fecha_Orden DATETIME NOT NULL,
    ID_Proveedor INT NOT NULL,
    ID_Empleado INT NOT NULL,
    Estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor(ID_Proveedor),
    FOREIGN KEY (ID_Empleado) REFERENCES Empleado(ID_Empleado)
);

-- Tabla: Detalle_Orden
CREATE TABLE Detalle_Orden (
    ID_Orden INT NOT NULL,
    ID_Producto INT NOT NULL,
    Cantidad INT NOT NULL,
    Precio_Compra DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (ID_Orden, ID_Producto),
    FOREIGN KEY (ID_Orden) REFERENCES Orden_Compra(ID_Orden),
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto)
);

-- Tabla: Promocion
CREATE TABLE Promocion (
    ID_Promocion INT AUTO_INCREMENT PRIMARY KEY,
    Descripcion VARCHAR(100) NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE NOT NULL,
    Descuento DECIMAL(5,2) NOT NULL
);

-- Tabla: Producto_Promocion
CREATE TABLE Producto_Promocion (
    ID_Producto INT NOT NULL,
    ID_Promocion INT NOT NULL,
    PRIMARY KEY (ID_Producto, ID_Promocion),
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto),
    FOREIGN KEY (ID_Promocion) REFERENCES Promocion(ID_Promocion)
);

-- Tabla: Devolucion
CREATE TABLE Devolucion (
    ID_Devolucion INT AUTO_INCREMENT PRIMARY KEY,
    ID_Venta INT NOT NULL,
    Fecha_Devolucion DATETIME NOT NULL,
    Motivo VARCHAR(255) NOT NULL,
    FOREIGN KEY (ID_Venta) REFERENCES Venta(ID_Venta)
);

-- Tabla: Detalle_Devolucion
CREATE TABLE Detalle_Devolucion (
    ID_Devolucion INT NOT NULL,
    ID_Producto INT NOT NULL,
    Cantidad INT NOT NULL,
    PRIMARY KEY (ID_Devolucion, ID_Producto),
    FOREIGN KEY (ID_Devolucion) REFERENCES Devolucion(ID_Devolucion),
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto)
);
-- Vistas

CREATE VIEW ProductosConCategoriaYProveedor AS
SELECT p.ID_Producto, p.Nombre AS Nombre_Producto, p.Precio, p.Stock,
       c.Nombre_Categoria, prov.Nombre AS Nombre_Proveedor
FROM Producto p
JOIN Categoria c ON p.ID_Categoria = c.ID_Categoria
JOIN Proveedor prov ON p.ID_Proveedor = prov.ID_Proveedor;

CREATE VIEW VentasPorCliente AS
SELECT c.ID_Cliente, c.Nombre, c.Apellido, COUNT(v.ID_Venta) AS Total_Ventas,
       SUM(v.Total) AS Total_Gastado
FROM Cliente c
LEFT JOIN Venta v ON c.ID_Cliente = v.ID_Cliente
GROUP BY c.ID_Cliente;

CREATE VIEW InventarioActual AS
SELECT p.ID_Producto, p.Nombre, p.Precio, p.Stock,
       (p.Precio * p.Stock) AS Valor_Inventario
FROM Producto p;

CREATE VIEW EmpleadosConPuestoYSueldo AS
SELECT e.ID_Empleado, e.Nombre, e.Apellido, p.Nombre_Puesto, p.Salario
FROM Empleado e
JOIN Puesto p ON e.ID_Puesto = p.ID_Puesto;

CREATE VIEW DevolucionesConMotivo AS
SELECT d.ID_Devolucion, d.Fecha_Devolucion, d.Motivo,
       p.Nombre AS Producto, dv.Cantidad
FROM Devolucion d
JOIN Detalle_Devolucion dv ON d.ID_Devolucion = dv.ID_Devolucion
JOIN Producto p ON dv.ID_Producto = p.ID_Producto;

-- Procedimientos Almacenados

DELIMITER //
CREATE PROCEDURE AgregarProducto(
    IN nombre VARCHAR(100),
    IN precio DECIMAL(10,2),
    IN stock INT,
    IN id_categoria INT,
    IN id_proveedor INT
)
BEGIN
    INSERT INTO Producto (Nombre, Precio, Stock, ID_Categoria, ID_Proveedor)
    VALUES (nombre, precio, stock, id_categoria, id_proveedor);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE RegistrarVenta(
    IN id_cliente INT,
    IN id_empleado INT,
    IN id_metodo_pago INT,
    IN total DECIMAL(10,2),
    IN fecha DATETIME
)
BEGIN
    INSERT INTO Venta (Fecha_Venta, Total, ID_Cliente, ID_Empleado, ID_Metodo_Pago)
    VALUES (fecha, total, id_cliente, id_empleado, id_metodo_pago);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarStock(
    IN id_producto INT,
    IN cantidad INT
)
BEGIN
    UPDATE Producto SET Stock = Stock + cantidad WHERE ID_Producto = id_producto;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerProductosPorCategoria(IN id_categoria INT)
BEGIN
    SELECT * FROM Producto WHERE ID_Categoria = id_categoria;
END //
DELIMITER ;

-- Triggers

DELIMITER //
CREATE TRIGGER ActualizarStockAlRegistrarVenta
AFTER INSERT ON Detalle_Venta
FOR EACH ROW
BEGIN
    UPDATE Producto SET Stock = Stock - NEW.Cantidad
    WHERE ID_Producto = NEW.ID_Producto;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER ValidarStockAntesDeVenta
BEFORE INSERT ON Detalle_Venta
FOR EACH ROW
BEGIN
    DECLARE stock_actual INT;
    SELECT Stock INTO stock_actual FROM Producto WHERE ID_Producto = NEW.ID_Producto;
    
    IF stock_actual < NEW.Cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente para la venta';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER RegistrarEntradaInventario
AFTER UPDATE ON Producto
FOR EACH ROW
BEGIN
    IF NEW.Stock > OLD.Stock THEN
        INSERT INTO Inventario_Movimiento (ID_Producto, Fecha_Movimiento, Tipo_Movimiento, Cantidad, ID_Empleado)
        VALUES (NEW.ID_Producto, NOW(), 'Entrada', NEW.Stock - OLD.Stock, 1); -- ID_Empleado puede ser dinámico
    END IF;
END //
DELIMITER ;

-- Funciones

DELIMITER //

-- Función: ObtenerPrecioPromocional
CREATE FUNCTION ObtenerPrecioPromocional(id_producto INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE precio DECIMAL(10,2);
    DECLARE descuento DECIMAL(5,2) DEFAULT 0.00;
    
    -- Obtiene el precio del producto
    SELECT Precio INTO precio 
    FROM Producto 
    WHERE ID_Producto = id_producto;

    -- Obtiene el descuento aplicable si el producto está en promoción activa
    SELECT COALESCE(MAX(Descuento), 0) INTO descuento
    FROM Promocion p 
    JOIN Producto_Promocion pp ON p.ID_Promocion = pp.ID_Promocion
    WHERE pp.ID_Producto = id_producto 
      AND CURRENT_DATE BETWEEN p.Fecha_Inicio AND p.Fecha_Fin;
    
    -- Retorna el precio con descuento si aplica
    RETURN IFNULL(precio * (1 - descuento / 100), precio);
END //

-- Función: ObtenerTotalVenta
CREATE FUNCTION ObtenerTotalVenta(id_venta INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    
    -- Calcula el total de la venta basada en el detalle
    SELECT SUM(Cantidad * Precio_Unitario) INTO total 
    FROM Detalle_Venta 
    WHERE ID_Venta = id_venta;

    -- Retorna el total calculado
    RETURN IFNULL(total, 0.00);
END //

-- Función: CalcularTotalInventario
CREATE FUNCTION CalcularTotalInventario()
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE total_inventario DECIMAL(15,2);

    -- Calcula el valor total del inventario
    SELECT SUM(Precio * Stock) INTO total_inventario 
    FROM Producto;

    -- Retorna el valor total del inventario
    RETURN IFNULL(total_inventario, 0.00);
END //

DELIMITER ;


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
