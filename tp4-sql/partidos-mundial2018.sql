

seleccion 
<nombre_seleccion: VARCHAR(25) PK,
director_tecnico: VARCHAR(35), 
preparador_fisico: VARCHAR(35) > 

jugador_seleccion <nombre: VARCHAR(35) PK,
posicion: VARCHAR(25),  posicion_auxiliar: VARCHAR(25), 
edad: INT, nombre_seleccion: VARCHAR(25) FK>

partido <id_partido: INT PK, equipo_local: VARCHAR(25) FK,
equipo_visitante: VARCHAR(25) FK, fecha: DATETIME,
nombre_arbitro: VARCHAR(35), estadio: VARCHAR(25) FK>
 
gol <   
        id_partido: INT PK FK,
        nombre_goleador: VARCHAR(25) PK FK,
        minuto: INT PK
    > 

tarjeta_amarilla <id_partido: INT PK FK,
nombre_amonestado: VARCHAR(35) PK FK, minuto: INT PK>

tarjeta_roja <id_partido: INT PK FK,
nombre_amonestado: VARCHAR(35) PK FK, minuto: INT>

estadio <nombre: VARCHAR(25) PK, capacidad: INT,
cantidad_de_butacas: INT, cantidad_de_banderitas: INT>



1. DDL/DML
(a) Agregar 3 tuplas a la tabla tarjetaamarilla.
        INSERT INTO jugadordeseleccion  VALUES  ('Gerardo Sofovich','delantero', 'extremo izquierdo', 34, 'Argentina'),
                                              ('Ruben Perez','delantero', 'extremo izquierdo', 90, 'Argentina'),
                                              ('Adrian Suar','defensor central', 'extremo izquierdo', 35, 'Uruguaya');

        INSERT INTO tarjetaamarilla  VALUES (103295, 'Gerardo Sofovich', 34),(103296,'Ruben Perez',90),(103297,'Adrian Suar', 35);

-- (b) Actualizar la cantidad de banderitas del Minerao a 3000 banderitas.
        UPDATE estadio 
        SET cantidadbanderitas = 3000
        WHERE nombre ILIKE 'minerao';

2. DML: Consultas

(a) Obtener la cantidad de goles convertidos por el jugador “Messi” en el partido 103243.

    SELECT COUNT(g.nombregoleador), g.id_partido AS goles_hechos_por_messi 
    FROM gol g 
    WHERE g.id_partido = 103243 AND g.nombregoleador ILIKE 'messi'
    GROUP BY g.id_partido ;  

(b) 
    Obtener nombre y cantidad de banderitas de los estadios donde haya dirigido algún
    árbitro que haya sacado tarjeta roja y al menos una tarjeta amarilla.

SELECT e.nombre, e.cantidadbanderitas 
FROM (tarjetaamarilla ta NATURAL JOIN tarjetaroja tr NATURAL JOIN partido p) AS partidos_y_tarjetas 
JOIN estadio e ON e.nombre = partidos_y_tarjetas.estadio;


(c) 
    Obtener el nombre de los jugadores que hayan recibidos tarjetas amarillas pero no
    tarjetas rojas.

SELECT ta.nombreamonestado 
FROM  tarjetaamarilla ta 
EXCEPT
SELECT tr.nombreamonestado
FROM   tarjetaroja tr;


(d) 
    Obtener los nombres de las selecciones con arqueros goleadores y defensores goleadores.


    SELECT DISTINCT g.nombregoleador, js.nombreseleccion, js.posicion
    FROM   gol g JOIN jugadordeseleccion js 
    ON     g.nombregoleador = js.nombre 
    WHERE  js.posicion ILIKE 'defensa' OR js.posicion ILIKE 'arquero';

(e) Obtener los nombres de jugadores expulsados por doble amarilla.
    

 idpartido | nombreamonestado  | minuto        
-----------+-------------------+--------
    103251 | Wyatt Mercer      |     14
    103254 | Wesley Koch       |     15    jugadores que aparecen mas de 2 veces en la tabla
    103255 | Christian Serrano |     16    
    103256 | Jameson Campos    |     17
    103257 | Lester Fuller     |     18
    103257 | Kennedy Castro    |     19
    103259 | Stewart Joyce     |     20
    103259 | Giacomo Leblanc   |      2
    103259 | Giacomo Leblanc   |     43

 

???????????????????????


(f) Obtener la tabla de equipos ordenados de mayor a menor de acuerdo a la cantidad de
goles que convirtieron. La tabla resultante debe tener 2 columnas con el nombre del
seleccionado y la cantidad de goles convertidos.

SELECT COUNT(sel.nombreseleccion) AS goles_de_seleccion, sel.nombreseleccion 
FROM (gol g NATURAL JOIN partido p) AS partidos_y_goles
    
    JOIN seleccion sel ON   sel.nombreseleccion  = partidos_y_goles.equipolocal 
                       OR   sel.nombreseleccion  = partidos_y_goles.equipovisitante
GROUP BY sel.nombreseleccion ORDER BY  goles_de_seleccion DESC;



SELECT nombreamonestado 
FROM  tarjetaamarilla ta 
EXCEPT
SELECT nombreamonestado
FROM   tarjetaroja tr;



-- los goleadores que metieron 2 o mas goles en todos los partidos jugados.
SELECT g1.nombregoleador
FROM gol g1 
GROUP BY g1.nombregoleador
HAVING COUNT (g1.nombregoleador) >= 2;