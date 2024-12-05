use kiosco;
-- Productos mas vendidos
SELECT p.Nombre AS Producto, SUM(dv.Cantidad) AS Total_Vendido
FROM Producto p
JOIN Detalle_Venta dv ON p.ID_Producto = dv.ID_Producto
GROUP BY p.Nombre
ORDER BY Total_Vendido DESC
LIMIT 10;

-- Ventas por Método de Pago
SELECT mp.Descripcion AS Metodo_Pago, COUNT(v.ID_Venta) AS Cantidad_Ventas
FROM Metodo_Pago mp
JOIN Venta v ON mp.ID_Metodo_Pago = v.ID_Metodo_Pago
GROUP BY mp.Descripcion;

-- Valor del Inventario por Categoría
SELECT c.Nombre_Categoria, SUM(p.Stock * p.Precio) AS Valor_Inventario
FROM Categoria c
JOIN Producto p ON c.ID_Categoria = p.ID_Categoria
GROUP BY c.Nombre_Categoria;

-- Empleados y Salarios
SELECT p.Nombre_Puesto, COUNT(e.ID_Empleado) AS Numero_Empleados, AVG(p.Salario) AS Salario_Promedio
FROM Puesto p
JOIN Empleado e ON p.ID_Puesto = e.ID_Puesto
GROUP BY p.Nombre_Puesto;

