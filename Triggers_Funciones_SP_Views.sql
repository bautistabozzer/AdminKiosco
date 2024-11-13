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


