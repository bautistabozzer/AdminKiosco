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
