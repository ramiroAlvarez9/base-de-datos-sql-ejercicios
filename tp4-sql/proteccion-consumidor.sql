
/*
    (a) ¿Choclo o Pochoclo? Listar los productos que el contenido sea “Choclo” y el tipo “Enlatado” o el contenido sea “Pochoclo” y el tipo “Bolsa”.
    (b) ¿A cuánto el tomate? Listar los precios del tomate que se vende en la zona de Bernal.
    (c) Comercios Gourmet: Listar los comercios que venden Avellanas a más de $50 y también venden Frutas Secas a menos de $40.
    (d) Productos Exclusivos: Listar los <pid, descripcion> de los productos que son vendidos
        en el barrio de Palermo, pero que no son vendidos en el barrio de San Telmo.
    (e) Barrios: Listar el <precio-promedio, barrio> del precio promedio de los productos
        ofrecidos en cada barrio.
    (f) Los precios de ahorita: Obtener la lista de los productos con sus precios actuales.
    (g) Sobreprecios: Obtener la lista de los productos que sufrieron aumentos en las entre
        dos fechas diferentes (no necesariamente consecutivas).
                
*/

PRODUCTO  <pid: INT PK, descripcion: VARCHAR(70), tipo: VARCHAR(40), contenido: VARCHAR(40)>

TIPO      <tipo: VARCHAR(40) PK, descripcion: VARCHAR(100)>

COMERCIO  <comercio: INT PK, nombre: VARCHAR(100), direccion: VARCHAR(250), barrio: VARCHAR(50), zona: VARCHAR(60)>

PRECIO    <pid: INT PK FK, comercio: INT PK FK, fecha_registro: DATETIME PK, precio DECIMAL(10,2)>



(c) Comercios Gourmet: Listar los comercios que venden Avellanas a más de $50 y también venden Frutas Secas a menos de $40.



(b) ¿A cuánto el tomate? Listar los precios del tomate que se vende en la zona de Bernal.

    SELECT p.contenido, pr.precio
    FROM   producto p JOIN precio pr ON pr.pid = p.pid JOIN comercio c ON  c.comercio = pr.comercio
    WHERE  zona ILIKE 'bernal' AND contenido ILIKE 'tomate';

    SELECT contenido, precio
    FROM   producto  NATURAL JOIN precio NATURAL JOIN comercio c
    WHERE  zona ILIKE 'bernal' AND contenido ILIKE 'tomate';



(a) ¿Choclo o Pochoclo? Listar los productos que el contenido sea “Choclo” y el tipo “Enlatado” o el contenido sea “Pochoclo” y el tipo “Bolsa”.

    SELECT  p.pid, p.tipo, p.contenido   
    FROM    producto p 
    WHERE   p.contenido ILIKE 'choclo%' AND p.tipo ILIKE 'enlatado%'
        UNION
    SELECT  p2.pid, p2.tipo, p2.contenido
    FROM    producto p2 
    WHERE   p2.contenido ILIKE 'Pochoclo%' AND p2.tipo ILIKE 'Bolsa%';