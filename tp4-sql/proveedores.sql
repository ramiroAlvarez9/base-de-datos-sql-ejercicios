------------------------------------------------------------------------------------------------------------------------------------------------------

1. DDL/DML

(b) Modifique la relación componentes agregando como atributo la provincia de la ciudad
de los Componentes.

    ALTER TABLE componentes ADD COLUMN provincia VARCHAR(55);

(c) Modifique la relación artículos agregando un atributo que permita guardar el número
de serie de cada artículo.
 
    ALTER TABLE articulos ADD COLUMN n_serie SERIAL;

(d) Actualice la relacion componentes cambiando los colores rojos por violeta y los azules por
marrón.

    UPDATE componentes 
    SET color = 'Violeta'
    WHERE color ILIKE 'rojo';

    UPDATE componentes 
    SET color = 'Marron'
    WHERE color ILIKE 'azul';

(e) Actualice la definición de componentes para que los colores posibles sean solamente
{rojo, verde, azul, violeta o marrón}

    ALTER TABLE componentes ADD CONSTRAINT colores_solo CHECK( color IN ('Rojo', 'Verde', 'Azul', 'Violeta', 'Marron'));

(f) Actualice la ciudad de los proveedores cuyos nombres son Carlos o Eva, y cambie su
ciudad por Bahía Blanca.

    UPDATE proveedores 
    SET ciudad = 'Bahia Blanca'
    WHERE prov_nombre ILIKE 'carlos' OR prov_nombre ILIKE 'eva';

(g) Elimine todos los envios cuya cantidad esté entre 200 y 300.

DELETE FROM envios
WHERE cantidad BETWEEN 200 AND 300;

(h) Elimine los artículos de La Plata.

DELETE FROM envios 
WHERE id_art IN 
(SELECT id_art FROM articulos WHERE ciudad ILIKE 'La Plata');

DELETE FROM articulos  
WHERE ciudad ILIKE 'la plata';


------------------------------------------------------------------------------------------------------------------------------------------------------

PROVEEDORES <id_prov, prov_nombre ,categoria , ciudad>
ARTICULOS < id_art PK , art_nombre, ciudad, n_serie>
COMPONENTES <id_comp PK , comp_nombre, color, peso, ciudad , provincia>
ENVIOS <id_prov , id_comp , id_art, cantidad>


2. DML: Resolver los siguientes ejercicios usando SQL

-- (a) Obtener todos los detalles de todos los artículos de Bernal.
    
    SELECT * FROM articulos WHERE ciudad ILIKE 'bernal';

-- (b) Obtener todos los valores de id_prov para los proveedores que abastecen el artículo T1.

    SELECT e.id_prov 
    FROM envios e 
    WHERE id_art ILIKE 't1';


-- (c) Obtener de la tabla de artículos los valores de id_art y ciudad donde el nombre de la ciudad acaba en D o contiene al menos una E.

    SELECT a.id_art, a.ciudad 
    FROM articulos a 
    WHERE ciudad ILIKE '%d' OR ciudad ILIKE '%e%' 
    ORDER BY a.ciudad ASC;



-- (d) Obtener los valores de id_prov para los proveedores que suministran para el artículo T1 el componente C1.

    SELECT id_prov FROM envios WHERE id_art ILIKE 't1' AND id_comp ILIKE 'c1';


(e) Obtener los valores de art_nombre en orden alfabético para los artículos abastecidos
por el proveedor P1.

    SELECT DISTINCT a.art_nombre 
    FROM articulos a JOIN envios e 
    ON a.id_art = e.id_art 
    WHERE id_prov ILIKE 'p1'
    ORDER BY a.art_nombre ASC;


(f) Obtener los valores de id_comp para los componentes suministrados para cualquier
artículo de Capital Federal.

    SELECT e.id_comp 
    FROM envios e JOIN articulos a 
    ON e.id_art = a.id_art 
    WHERE a.ciudad ILIKE 'cap. fed.';

(g) Obtener el id_comp del (o los) componente(s) que tienen el menor peso.

    SELECT c.id_comp
    FROM componentes c 
    GROUP BY c.id_comp 
    HAVING c.peso < (SELECT AVG (peso) FROM componentes ); 


PROVEEDORES <id_prov, prov_nombre ,categoria , ciudad>
ARTICULOS < id_art PK , art_nombre, ciudad, n_serie>
COMPONENTES <id_comp PK , comp_nombre, color, peso, ciudad , provincia>
ENVIOS <id_prov , id_comp , id_art, cantidad>

(h) Obtener los valores de idprov para los proveedores que suministran para un artículo
de La Plata o Capital Federal un componente Rojo.

    SELECT e.id_prov 
    FROM envios e JOIN articulos a ON a.id_art = e.id_art 
    JOIN componentes c ON c.id_comp = e.id_comp;
    WHERE a.ciudad ILIKE 'la plata'  OR a.ciudad ILIKE 'cap. fed.' AND c.color ILIKE 'rojo';
   
(i) Seleccionar el id_prov de los proveedores que nunca suministraron un componente
verde.

SELECT * 
FROM   componentes c JOIN envios e ON c.id_comp = e.id_comp
WHERE color <> 'Verde'
    EXCEPT 
SELECT e.id_prov 
FROM   componentes c JOIN envios e ON c.id_comp = e.id_comp
WHERE color ILIKE 'verde';


(j) Obtener, para los envíos del proveedor P2, el número de suministros realizados de
artículos distintos y la cantidad total de los mismos.

    SELECT e.id_prov, COUNT(DISTINCT e.id_art) AS sumistros_realizados , SUM(e.cantidad) AS cantidad_total_articulos
    FROM envios e WHERE id_prov = 'P2' GROUP BY e.id_prov;


(k) Obtener la cantidad máxima suministrada en un mismo envío, para cada proveedor.

    SELECT DISTINCT e.id_prov, MAX(e.cantidad) AS cantidad_maxima    
    FROM envios e GROUP BY e.id_prov;


(l) Para cada artículo y componente suministrado obtener los valores de id_comp, id_art
y la cantidad total correspondiente.

    SELECT DISTINCT e.id_comp , e.id_art, SUM(e.cantidad)
    FROM envios e 
    GROUP BY e.id_comp,e.id_art;
    
(m) Seleccionar los nombres de los componentes que son suministrados en una cantidad
total superior a 500. 
    
    
    SELECT DISTINCT c.comp_nombre, e.cantidad
    FROM componentes c NATURAL JOIN envios e  
    GROUP BY c.comp_nombre, e.cantidad
    HAVING SUM(e.cantidad) > 500;
    


(n) Obtener los identificadores de artículos, id_art, para los que se ha suministrado algún
componente del que se haya suministrado una media superior a 420 artículos. X

    

    SELECT e.id_art  
    FROM   envios e 
    GROUP BY e.id_art
    HAVING ( SELECT AVG(cantidad) FROM componentes c NATURAL JOIN envios e2) > 420 ; 



(ñ) Seleccionar los identificadores de proveedores que hayan realizado algún envío con
cantidad mayor que la media de los envíos realizados para el componente a que corresponda dicho envío. X
    
   
    
    SELECT e.id_prov 
    FROM   envios e 
    GROUP BY e.id_prov 
    HAVING 



(o) Seleccionar los identificadores de artículos para los cuales todos sus componentes se
fabrican en una misma Ciudad.

    PROVEEDORES <id_prov, prov_nombre ,categoria , ciudad>
    ARTICULOS < id_art PK , art_nombre, ciudad, n_serie>
    COMPONENTES <id_comp PK , comp_nombre, color, peso, ciudad , provincia>
    ENVIOS <id_prov , id_comp , id_art, cantidad>

    SELECT a.id_art, c.id_comp 
    FROM   articulos a JOIN componentes c 
    ON c.ciudad = a.ciudad;
    


(p) Seleccionar los identificadores de artículos para los que se provean envíos de todos los
componentes existentes en la base de datos. X

    SELECT a.id_art 
    FROM   articulos a  NATURAL JOIN envios e;
