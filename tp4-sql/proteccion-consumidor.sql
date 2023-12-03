
/*
    (a) ¿Choclo o Pochoclo? Listar los productos que el contenido sea “Choclo” y el tipo “Enlatado” o el contenido sea “Pochoclo” y el tipo “Bolsa”.
    (b) ¿A cuánto el tomate? Listar los precios del tomate que se vende en la zona de Bernal.
    (c) Comercios Gourmet: Listar los comercios que venden Avellanas a más de $50 y también venden Frutas Secas a menos de $40.
    (d) Productos Exclusivos: Listar los <pid, descripcion> de los productos que son vendidos
        en el barrio de Palermo, pero que no son vendidos en el barrio de San Telmo.
    
    (e) Barrios: Listar el <precio-promedio, barrio> del precio promedio de los productos
        ofrecidos en cada barrio.

    (g) Sobreprecios: Obtener la lista de los productos que 
        sufrieron aumentos 
        en las entre dos fechas diferentes (no necesariamente consecutivas).              
*/

PRODUCTO  <pid: INT PK, 
            descripcion: VARCHAR(70), 
            tipo: VARCHAR(40), 
            contenido: VARCHAR(40)
            >

TIPO      <tipo: VARCHAR(40) PK, descripcion: VARCHAR(100)>

COMERCIO  <comercio: INT PK, nombre: VARCHAR(100), 
            direccion: VARCHAR(250), barrio: VARCHAR(50), 
            zona: VARCHAR(60)>

PRECIO    <pid: INT PK FK, 
           comercio: INT PK FK, 
           fecha_registro: TIMESTAMP PK, 
           precio DECIMAL(10,2)>




(a) ¿Choclo o Pochoclo? 
    Listar los productos que el contenido sea “Choclo” y 
    el tipo “Enlatado” o el contenido sea “Pochoclo” y el tipo “Bolsa”.

SELECT  
    p.pid,p.contenido, p.tipo 
FROM
    producto p 
WHERE
    p.contenido ILIKE 'choclo' 
    AND p.tipo ILIKE 'enlatado'

UNION

SELECT 
    p.pid,p.contenido, p.tipo 
FROM
    producto p 
WHERE 
    p.contenido ILIKE 'pochoclo' 
    AND p.tipo ILIKE 'bolsa';

2)

(b) ¿A cuánto el tomate? 
    Listar los precios del tomate que se vende en la zona de Bernal.

SELECT 
    p.pid, p.descripcion, pr.precio ,c.zona
FROM 
    producto p 
    JOIN precio pr  ON pr.pid = p.pid 
    JOIN comercio c ON c.comercio = pr.comercio 
WHERE 
    c.zona = 'Bernal';


(c) Comercios Gourmet: 
    Listar los comercios que venden Avellanas a más de $50 y 
    también venden Frutas Secas a menos de $40.

SELECT 
    c.comercio 
FROM 
    comercio c 
    JOIN precio pr  ON pr.comercio = c.comercio 
    JOIN producto p ON pr.pid      = p.pid 
WHERE 
    p.descripcion = 'Avellana'
    AND pr.precio >= 50

INTERSECT 


SELECT 
    c.comercio 
FROM 
    comercio c 
    JOIN precio pr  ON pr.comercio = c.comercio 
    JOIN producto p ON pr.pid      = p.pid 
WHERE 
    p.descripcion = 'Frutas Secas'
    AND pr.precio <= 40;



(d) Productos Exclusivos: Listar los <pid, descripcion> 
de los productos que son vendidos
    en el barrio de Palermo, 
pero que no son vendidos en el barrio de San Telmo.


SELECT 
    p.pid, p.descripcion
FROM 
    precio pr 
    JOIN comercio c ON pr.comercio = c.comercio
    JOIN producto p ON p.pid       = pr.pid 
WHERE 
    c.barrio ILIKE 'palermo%'

EXCEPT

SELECT 
    p.pid, p.descripcion 
FROM 
    precio pr 
    JOIN comercio c ON pr.comercio = c.comercio
    JOIN producto p ON p.pid       = pr.pid 
WHERE 
    c.barrio ILIKE 'San Telmo';

    
(e) Barrios: Listar el <precio-promedio, barrio> 
    del precio promedio de los productos
    ofrecidos en cada barrio.

SELECT
    comercios.barrio, 
    AVG(precios.precio) AS precios_promedios 
FROM
    comercio comercios 
    JOIN precio precios ON comercios.comercio = precios.comercio 
    JOIN producto productos ON productos.pid  = precios.pid
GROUP BY
    comercios.barrio;
    
(g) Sobreprecios: Obtener la lista de los productos que sufrieron aumentos 
    en las entre dos fechas diferentes (no necesariamente consecutivas).          

SELECT 
    p1.pid 
FROM 
    precio p1 
    JOIN precio p2 ON p1.pid = p2.pid 
WHERE 
    p1.fecha_registro > p2.fecha_registro 
        AND 
    p1.precio > p2.precio;


