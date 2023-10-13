

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

gol <id_partido: INT PK FK,
nombre_goleador: VARCHAR(25) PK FK, minuto: INT PK> 

tarjeta_amarilla <id_partido: INT PK FK,
nombre_amonestado: VARCHAR(35) PK FK, minuto: INT PK>

tarjeta_roja <id_partido: INT PK FK,
nombre_amonestado: VARCHAR(35) PK FK, minuto: INT>

estadio <nombre: VARCHAR(25) PK, capacidad: INT,
cantidad_de_butacas: INT, cantidad_de_banderitas: INT>

1. DDL/DML
(a) Agregar 3 tuplas a la tabla tarjetaamarilla.
        
        INSERT INTO tarjetaamarilla VALUES (103295, 'Gerardo Sofovich', 34),(103296,'Ruben Perez',90),(103297,'Adrian Suar', 35);

-- (b) Actualizar la cantidad de banderitas del Minerao a 3000 banderitas.
    
        UPDATE estadio SET cantidadbanderitas = 3000 WHERE nombre ILIKE 'minerao';

2. DML: Consultas

-- (a) Obtener la cantidad de goles convertidos por el jugador “Messi” en el partido 103243.

    SELECT g.nombregoleador AS messi_hizo_goles, COUNT(g.nombregoleador) FROM gol g WHERE g.idpartido = 103243 AND nombregoleador = 'Messi' GROUP BY g.nombregoleador;
/*
    (b) Obtener nombre y cantidad de banderitas de los estadios donde haya dirigido algún
    árbitro que haya sacado tarjeta roja y al menos una tarjeta amarilla.  
*/

    SELECT DISTINCT e.nombre, e.cantidadbanderitas 
    FROM 
    (
        SELECT DISTINCT p.nombrearbitro, p.estadio 
        FROM partido p JOIN tarjetaroja tr ON p.idpartido = tr.idpartido
            INTERSECT 
        SELECT DISTINCT p.nombrearbitro, p.estadio 
        FROM partido p JOIN tarjetaroja ta ON p.idpartido = ta.idpartido
    ) AS arbitro_estadio_tarjetas
    JOIN 
    estadio e 
    ON e.nombre = arbitro_estadio_tarjetas.estadio;



(c) Obtener el nombre de los jugadores que hayan recibidos tarjetas amarillas pero no
tarjetas rojas.

    SELECT DISTINCT ta.nombreamonestado 
    FROM tarjetaamarilla ta 
    EXCEPT
    SELECT DISTINCT tr.nombreamonestado
    FROM tarjetaroja tr;

(d) Obtener los nombres de las selecciones con arqueros goleadores y defensores goleadores.

    SELECT selecciones_y_jugadores.nombreseleccion 
    FROM (seleccion s NATURAL JOIN jugadordeseleccion ) AS selecciones_y_jugadores 
    JOIN gol g 
    ON g.nombregoleador = selecciones_y_jugadores.nombre
    WHERE selecciones_y_jugadores.posicion ILIKE 'defensor' 
    OR selecciones_y_jugadores.posicion ILIKE 'arquero'
    OR selecciones_y_jugadores.posicionauxiliar ILIKE 'defensor'
    OR selecciones_y_jugadores.posicionauxiliar ILIKE 'arquero'; 


(e) Obtener los nombres de jugadores expulsados por doble amarilla.

    SELECT ta.nombreamonestado 
    FROM tarjetaamarilla ta 
    GROUP BY ta.nombreamonestado
    HAVING COUNT(ta.nombreamonestado) >= 2

        INTERSECT
    
    SELECT tr.nombreamonestado 
    FROM tarjetaamarilla tr;


(f) Obtener la tabla de equipos ordenados de mayor a menor de acuerdo a la cantidad de
goles que convirtieron. La tabla resultante debe tener 2 columnas con el nombre del
seleccionado y la cantidad de goles convertidos.

SELECT selecciones_y_goles.nombreseleccion, COUNT(selecciones_y_goles.idpartido) AS goles_totales
FROM (   
        SELECT * 
            FROM 
                seleccion 
                    JOIN 
                partido 
            ON  nombreseleccion  = equipolocal OR  nombreseleccion  = equipovisitante
                
        NATURAL JOIN gol g 
        ) AS selecciones_y_goles 

GROUP BY selecciones_y_goles.nombreseleccion        

ORDER BY goles_totales DESC;


