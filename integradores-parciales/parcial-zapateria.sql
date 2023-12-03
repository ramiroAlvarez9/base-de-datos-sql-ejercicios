




ZAPATERIA < id_zap(PK), razon_social, ciudad, fecha_fundación, cant_empleados, tiene_promos >
CALZADO < marca(PK), modelo(PK), fecha_lanzamiento, precio, descripción >
CLIENTE < id_cli(PK), nyap, ciudad, fecha_registro >
COMPRA < marca(PK, FK), modelo(PK, FK), id_cli(PK, FK), fecha_compra(PK), precio_compra, forma_pago >
ARREGLO < id_zap(PK, FK), marca(PK, FK), modelo(PK, FK), id_cli(PK, FK), fecha_compra(PK, FK), fecha_arreglo(PK),
precio, descripción >

1. Insertar en la DB un arreglo del zapato de la marca ‘buma’, modelo ‘aixfaz’ del cliente treinta y cuatro,
llamado ‘Mandiel Ramnazzo’, que fue arreglado el 29-10-2023 con la descripción ‘cambio de cierre’ que
sale $2500 en la zapatería ‘D10S’ de Quilmes, que posee descuentos y veinticuatro empleados. Considere
que la base de datos está vacía.

2. Eliminar a los clientes reg-istrados en el día 28-02-2015. Por otra parte, si considera que la base de datos
NO está vacía, y sabemos que 100 clientes se registraron el 28-02-2015. ¿Por qué motivo su consulta
podría no eliminar a los 100 clientes?

3. Obtener por ciudad la cantidad de zapaterías, el promedio de empleados y la fecha en la que se fundó la zapatería más antigua. Las columnas resultantes deben ser <ciudad, cant_zapaterias, avg_empl,
old_zapateria>.

4. Obtener <nyap, fecha_registro> de los clientes que le hayan realizado al menos un arreglo que cuyo
precio haya sido mayor a 10000, y a su vez, han comprado al menos tres zapatillas de la marca ‘mandibas’.

5. Obtener < marca, modelo, id_cli, precio, precio_compra, fecha_compra> de los calzados que se compraron un $500 más caros que su precio de lanzamiento.

6. Obtener <id_cli, fecha_registro> de los clientes que nunca arreglaron zapatos en su ciudad

7. Obtener por marca y modelo < marca, modelo, id_cli, fecha_compra, precio_compra, forma_pago > de
la compra más reciente.



4)

-- SOLUCION V1

SELECT 
    c.nyap, c.fecha_registro
FROM 
    cliente c
    JOIN arreglo a ON c.id_cli = a.id_cli
WHERE 
    a.precio > 10000
    
    INTERSECT 

SELECT 
    c.nyap, c.fecha_registro
FROM 
    cliente c
    JOIN arreglo a ON c.id_cli = a.id_cli
WHERE 
    a.marca ILIKE 'mandibas'
GROUP BY
    c.nyap, c.fecha_registro 
HAVING 
    COUNT (a.marca) >= 3;

-- SOLUCION V2 
SELECT 
    c.nyap, c.fecha_registro
FROM 
    cliente c
    JOIN arreglo a ON c.id_cli = a.id_cli
WHERE 
    a.precio > 10000
        AND 
    c.nyap IN 
        (
            SELECT DISTINCT 
                c2.nyap
            FROM 
                cliente c2
                JOIN arreglo a2  ON c2.id_cli = a2.id_cli
            WHERE 
                a2.marca = 'Mandibas'
            GROUP BY 
                c2.nyap 
            HAVING COUNT(*) > 3;

        );

