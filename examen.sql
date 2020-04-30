
--Generar script para poblar todas las tablas.
--Cliente
INSERT INTO Cajeros 
(NomApels) 
VALUES
("Carlos Lizandro")

INSERT INTO Productos
(Nombre, Precio)
VALUES
("Computadora", 8000.00)

INSERT INTO Maquinas_Registradoras
(Piso)
VALUES
(10)

INSERT INTO Ventas
(Cajero, Maquina, Producto)
VALUES
(1, 1, 1)

--Mostrar el número de ventas de cada producto, ordenado de más a menos ventas.

SELECT          p.Producto, p.Nombre, MAX(v.producto)
FROM            Productos p 
INNER JOIN      Ventas v
ON              p.Producto = v.Producto
ORDER BY        v.producto


--Obtener un informe completo de ventas, indicando el nombre del cajero que realizo la venta, nombre y precios
--de los productos vendidos, y el piso en el que se encuentra la máquina registradora donde se realizó la venta.

SELECT          c.NombApels, v.Cajero, v.Maquina, v.Producto, p.Nombre, p.Precio, m.Piso
FROM            Ventas v
INNER JOIN      Cajero c
ON              c.Cajero = v.Cajero
INNER JOIN      Productos p
ON              p.Producto = v.Producto
INNER JOIN      Maquinas_Registradoras m
ON              p.Maquina = m.Maquina

--Obtener las ventas totales realizadas en cada piso.
SELECT      Piso, SUM(Precio)
FROM        Ventas v, Producto p, Maquinas_Registradoras m
WHERE       v.Producto = p.Producto
AND         v.Maquina = m.Maquina
GROUP BY    Pizo

--Obtener el código y nombre de cada cajero junto con el importe total de sus ventas.

SELECT          c.Cajero c.NombApels, SUM(p.Precio)
FROM            Producto p 
INNER JOIN      Cajeros c 
LEFT JOIN       Ventas v
ON              v.Cajero = c.Cajero
ON              v.Producto = v.Producto
GROUP BY        c.Cajero, c.NombApels

--Obtener el código y nombre de aquellos cajeros que hayan realizado ventas en pisos cuyas ventas totales
--sean inferiores a los 5000 pesos.

SELECT  c.Cajero, c.NombApels
FROM    Cajeros c
WHERE   c.Cajero, IN
(
    SELECT  Cajero 
    FROM    Ventas
    WHERE   Maquina IN 
    (
        SELECT  Maquina 
        FROM    Maquinas_Registradoras
        WHERE   Pizo IN
        (
            SELECT      Pizo 
            FROM        Ventas v, Productos p, Maquinas_Registradoras m
            WHERE       v.Producto = p.Producto 
            AND         v.Maquina = m.Maquina 
            GROUP BY    Pizo
            HAVING      SUM(Precio) < 5000
        )
    )
)