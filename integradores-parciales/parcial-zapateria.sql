ZAPATERIA < id_zap(PK), razon_social, ciudad, fecha_fundación, cant_empleados, tiene_promos >
CALZADO < marca(PK), modelo(PK), fecha_lanzamiento, precio, descripción >
CLIENTE < id_cli(PK), nyap, ciudad, fecha_registro >
COMPRA < marca(PK, FK), modelo(PK, FK), id_cli(PK, FK), fecha_compra(PK), precio_compra, forma_pago >
ARREGLO < id_zap(PK, FK), marca(PK, FK), modelo(PK, FK), id_cli(PK, FK), fecha_compra(PK, FK), fecha_arreglo(PK),
precio, descripción >

3) 
Obtener por ciudad la cantidad de zapaterías, 
el promedio de empleados y la fecha en la que se fundó la zapatería más antigua. 
Las columnas resultantes deben ser <ciudad, cant_zapaterias, avg_empl,
old_zapateria>.

SELECT
     z.ciudad,
     COUNT(z.ciudad) AS cant_zapaterias,
     AVG  (z.cant_empleados)  AS avg_empl,
     MIN  (z.fecha_fundación) AS  old_zapateria
FROM 
    zapatería z 
GROUP BY z.ciudad; 

-- en este caso esta bien contar por ciudades?

4) 
Obtener <nyap, fecha_registro> de los clientes que le hayan realizado al menos un arreglo que cuyo
precio haya sido mayor a 10000, 
y a su vez, han comprado al menos tres zapatillas de la marca ‘mandibas’

SELECT 
    c.nyap, c.fecha_registro 
FROM 
    cliente c 
    JOIN arreglo a ON c.id_cli  = a.id_cli 
    JOIN compra cr ON cr.id_cli = a.id_cli 
    AND  cr.modelo = a.modelo 
    AND  cr.marca  = a.marca 
WHERE 
    cr.precio_compra > 10000 
    
    INTERSECT    

SELECT 
    nyap, fecha_registro 
FROM 
    cliente c 
    JOIN arreglo a ON c.id_cli  = a.id_cli 
    JOIN compra cr ON cr.id_cli = a.id_cli 
    AND  cr.modelo = a.modelo 
    AND  cr.marca  = a.marca 
WHERE
    cr.marca = 'mandibas'
GROUP BY 
    c.nyap, c.fecha_registro
HAVING COUNT(*) >= 3;


6) SELECT 
        c.id_cli, c.fecha_registro
    FROM   
        zapateria z 
        JOIN cliente c ON z.id_cli = c.id_cli 
    WHERE 
        c.ciudad <> z.ciudad
    EXCEPT 

    SELECT 
        c.id_cli, c.fecha_registro
    FROM 
        cliente c 
        JOIN zapateria z ON c.id_cli = z.id_cli
    WHERE 
        z.ciudad = c.ciudad 
        
7) 

