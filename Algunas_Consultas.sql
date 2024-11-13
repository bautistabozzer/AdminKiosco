-- Consulta Compleja: Inventario con valor total y promociones activas
SELECT p.ID_Producto, p.Nombre, p.Stock, p.Precio, 
       (p.Stock * p.Precio) AS Valor_Inventario, 
       COALESCE(pr.Descuento, 0) AS Descuento, 
       (p.Precio * (1 - COALESCE(pr.Descuento, 0) / 100)) AS Precio_Con_Descuento
FROM Producto p
LEFT JOIN Producto_Promocion pp ON p.ID_Producto = pp.ID_Producto
LEFT JOIN Promocion pr ON pp.ID_Promocion = pr.ID_Promocion 
   AND CURRENT_DATE BETWEEN pr.Fecha_Inicio AND pr.Fecha_Fin
ORDER BY p.ID_Producto;

-- Consulta Sencilla 1: Lista de productos con sus categorías y proveedores
SELECT p.Nombre AS Producto, c.Nombre_Categoria AS Categoria, prov.Nombre AS Proveedor
FROM Producto p
JOIN Categoria c ON p.ID_Categoria = c.ID_Categoria
JOIN Proveedor prov ON p.ID_Proveedor = prov.ID_Proveedor
ORDER BY p.Nombre;

-- Consulta Sencilla 2: Total de inventario
SELECT SUM(p.Precio * p.Stock) AS Valor_Total_Inventario
FROM Producto p;

-- Consulta Sencilla 3: Cantidad de ventas por método de pago
SELECT mp.Descripcion AS Metodo_Pago, COUNT(v.ID_Venta) AS Total_Ventas
FROM Metodo_Pago mp
JOIN Venta v ON mp.ID_Metodo_Pago = v.ID_Metodo_Pago
GROUP BY mp.ID_Metodo_Pago
ORDER BY Total_Ventas DESC;
