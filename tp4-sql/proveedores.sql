/*1. DDL/DML
(b) Modifique la relación componentes agregando como atributo la provincia de la ciudad
de los Componentes.
(c) Modifique la relación artículos agregando un atributo que permita guardar el número
de serie de cada artículo.
9/12
Apellido y Nombre: Práctica 4: SQL
(d) Actualice la componentes cambiando los colores rojos por violeta y los azules por
marrón.
(e) Actualice la definición de componentes para que los colores posibles sean solamente
{rojo, verde, azul, violeta o marrón}
(f) Actualice la ciudad de los proveedores cuyos nombres son Carlos o Eva, y cambie su
ciudad por Bahía Blanca.
(g) Elimine todos los envios cuya cantidad esté entre 200 y 300. X
(h) Elimine los artículos de La Plata
*/

PROVEEDORES
<id_prov PK, prov_nombre, categoria, ciudad>

COMPONENTES
<id_comp PK, comp_nombre, color, peso, ciudad >

ARTICULOS
<id_art PK, art_nombre, ciudad>

ENVIOS
<id_prov PK FK, id_comp PK FK, id_art PK FK, cantidad>

b)

ALTER TABLE componentes DROP COLUMN provincia;

ALTER TABLE componentes ADD COLUMN provincia VARCHAR(255) DEFAULT 'Buenos Aires';


c) 
ALTER TABLE articulos DROP COLUMN n_serie;

ALTER TABLE articulos ADD COLUMN n_serie SERIAL;
    
d)

UPDATE 
    componentes 
SET 
    color = 'Violeta'
WHERE 
    color ILIKE 'rojo';

UPDATE 
    componentes 
SET 
    color = 'Marron'
WHERE 
    color ILIKE 'azul';

e)

ALTER TABLE componentes ADD CONSTRAINT check_color_constraint CHECK (color IN('Rojo', 'Verde', 'Azul', 'Violeta', 'Marron'));


f) 
UPDATE 
    proveedores
SET 
    ciudad = 'Bahia Blanca'
WHERE 
    prov_nombre ILIKE 'carlos' OR prov_nombre ILIKE 'eva';  

g)

DELETE FROM envios 
WHERE cantidad BETWEEN 200 AND 300;

h)
    DELETE FROM 
        envios 
    WHERE 
        id_art IN 
            (   
                SELECT 
                    id_art 
                FROM 
                    articulos 
                WHERE 
                    ciudad ILIKE 'la plata'
            );
        
    DELETE FROM 
        articulos   
    WHERE 
        ciudad ILIKE 'la plata';



PROVEEDORES
<id_prov PK, prov_nombre, categoria, ciudad>

COMPONENTES
<id_comp PK, comp_nombre, color, peso, ciudad >

ARTICULOS
<id_art PK, art_nombre, ciudad>

ENVIOS
<id_prov PK FK, id_comp PK FK, id_art PK FK, cantidad>


(a) Obtener todos los detalles de todos los artículos de Bernal.

(b) Obtener todos los valores de id_prov para los proveedores que abastecen el artículo
T1.

(c) Obtener de la tabla de artículos los valores de id_art y ciudad donde el nombre de la
ciudad acaba en D o contiene al menos una E.

(d) Obtener los valores de id_prov para los proveedores 
que suministran para el artículo T1 el componente C1.

(e) Obtener los valores de art_nombre en orden alfabético para los artículos abastecidos
por el proveedor P1.

(f) Obtener los valores de id_comp para los componentes suministrados para cualquier
artículo de Capital Federal.

(g) Obtener el id_comp del (o los) componente(s) que tienen el menor peso.

(h) Obtener los valores de idprov para 
los proveedores que suministran para un artículo
de La Plata o Capital Federal un componente Rojo.

(i) Seleccionar el id_prov 
de los proveedores que nunca suministraron un componente verde.



PROVEEDORES
<id_prov PK, prov_nombre, categoria, ciudad>

COMPONENTES
<id_comp PK, comp_nombre, color, peso, ciudad >

ARTICULOS
<id_art PK, art_nombre, ciudad>

ENVIOS
<id_prov PK FK, id_comp PK FK, id_art PK FK, cantidad>


(j) Obtener, para los envíos del proveedor P2, 
el número de suministros realizado de artículos distintos suministrados 
y la cantidad total.

(k) Obtener la cantidad máxima suministrada en un mismo envío, para cada proveedor.

(l) 
    Para cada artículo y componente 
    suministrado obtener los valores de id_comp, id_art
    y la cantidad total correspondiente.


(m) Seleccionar los nombres de los 

    componentes que son suministrados  en una cantidad
    
    total superior a 500.

(n) Obtener los identificadores de artículos, 
id_art,
para los que se ha suministrado algún
componente del que se haya suministrado una media superior 
a 420 artículos.

(ñ) Seleccionar los identificadores de proveedores que hayan realizado 
algún envío con cantidad mayor que la media de los envíos realizados 
para el componente a que corresponda dicho envío.

(o) Seleccionar los identificadores de artículos 
para los cuales todos sus componentes se
fabrican en una misma Ciudad.  X

(p) Seleccionar los identificadores 
de artículos para los que se provean envíos de todos los
componentes existentes en la base de datos. 








a) 

SELECT 
    *
FROM 
    articulos 
WHERE 
    ciudad ILIKE 'bernal';

b)

SELECT 
    p.id_prov
FROM 
    proveedores p
    JOIN envios e ON p.id_prov = e.id_prov
WHERE 
    e.id_art ILIKE 't1';


c)
SELECT 
    a.id_art, a.ciudad 
FROM 
    articulos a
WHERE 
    a.ciudad ILIKE '%d' OR a.ciudad ILIKE '%e%'; 


d)

SELECT 
    p.id_prov 
FROM 
    proveedores p 
    JOIN envios e ON p.id_prov = e.id_prov
WHERE 
    e.id_art ILIKE 'T1';


e)
SELECT 
    a.art_nombre 
FROM 
    envios e 
    JOIN articulos a ON e.id_art = e.id_art 
WHERE 
    e.id_prov ILIKE 'p1'
ORDER BY 
    a.art_nombre ASC;


f) 
SELECT 
    e.id_comp 
FROM 
    envios e 
    JOIN articulos a ON e.id_art = a.id_art
WHERE 
    a.ciudad ILIKE 'capital federal';


g)

SELECT 
    c.id_comp
FROM 
    componentes c 
WHERE 
    c.peso = (
                SELECT 
                    MIN (peso) 
                FROM
                    componentes                 
            );


h)
    SELECT 
        e.id_prov 
    FROM 
        envios e 
        JOIN articulos a   ON e.id_art = a.id_art 
        JOIN componentes c ON c.id_comp = e.id_comp
    WHERE 
        a.ciudad ILIKE 'la plata'
        AND 
        c.color = 'Rojo';

i)
--solucion V1

    SELECT DISTINCT 
        p.id_prov 
    FROM 
        proveedores p 
        JOIN envios e ON p.id_prov = e.id_prov 
        JOIN componentes c ON c.id_comp = e.id_comp 
    WHERE 
        c.color <> 'Verde'
    
     EXCEPT
    
    SELECT 
        p.id_prov 
    FROM 
        proveedores p 
        JOIN envios e ON p.id_prov = e.id_prov 
        JOIN componentes c ON c.id_comp = e.id_comp 
    WHERE 
        c.color ILIKE 'Verde'

-- solucion V2
    
   SELECT DISTINCT 
        p.id_prov 
    FROM 
        proveedores p 
        JOIN envios e      ON p.id_prov = e.id_prov 
        JOIN componentes c ON c.id_comp = e.id_comp 
    WHERE 
        p.id_prov NOT IN 
            (
                SELECT DISTINCT 
                    p.id_prov 
            
                FROM 
                        proveedores p 
                        JOIN envios e ON p.id_prov = e.id_prov 
                        JOIN componentes c ON c.id_comp = e.id_comp 
                WHERE 
                    c.color ILIKE 'verde'
            )
    ORDER BY 
        p.id_prov ASC;


j)
    SELECT DISTINCT 
        e.id_prov              AS proveedor_2,
        COUNT(DISTINCT id_art) AS articulos_distintos_suministrados,
        SUM  (e.cantidad)      AS cantidad_total 
    FROM 
        envios e 
    WHERE 
        e.id_prov ILIKE 'p2'
    GROUP BY 
        e.id_prov;

k)
    SELECT 
        e.id_prov       AS proveedores,
        
        MAX(e.cantidad) AS cantidad_maxima_suministrada
    FROM 
        envios e 
    GROUP BY 
        e.id_prov; 

-- maxima cantidad suministrada en todos los envios.

SELECT  
        MAX(e.cantidad) AS cantidad_maxima_suministrada
    FROM 
        envios e;

l)
    SELECT 
        e.id_comp,
        e.id_art,
        SUM(e.cantidad)
    FROM 
        envios e 
    GROUP BY 
        e.id_comp, e.id_art
    ORDER BY 
        e.id_comp ASC;


m)

SELECT DISTINCT
    e.id_comp,e.cantidad 
FROM 
    envios e 
GROUP BY 
    e.id_comp, e.cantidad
HAVING SUM(e.cantidad) > 500;



 id_comp 
---------
 C4
 C5
 C3
 C1

- - - - - - - - - - - -


n)
SELECT DISTINCT
    id_art 
FROM 
    ( 
      SELECT 
        id_comp
      FROM 
        envios 
      GROUP BY 
        id_comp
      HAVING 
        AVG(cantidad) > 420
    ) AS componentes_media_mayor_a_420
    JOIN
    envios e ON e.id_comp = componentes_media_mayor_a_420.id_comp
ORDER BY id_art ASC;


ñ)

SELECT 
    e.id_prov
FROM 
    envios e 
    JOIN (
        SELECT 
            e.id_comp ,AVG(cantidad) AS media 
        FROM 
            envios 
    ) AS comp_media
    ON e.id_comp = comp_media.id_comp
    
    WHERE 
    e.cantidad > comp_media.media;

o)

SELECT 
    id_art 
FROM 
    envios e 
    JOIN componentes comps ON e.id_comp = comps.id_comp 
GROUP BY 
    id_art 
HAVING 
    COUNT(DISTINCT ciudad) = 1;

p)


SELECT DISTINCT
    e.id_art 
FROM 
    envios e 
WHERE 
    e.id_comp
        IN 
            (
                SELECT DISTINCT 
                    id_comp
                FROM
                    componentes 
            );

     
    