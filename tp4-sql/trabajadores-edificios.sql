-- DDL
-- (a) Modifique la relación trabajador agregando la edad del mismo.
/*
 trabajador <legajo, nombre, tarifa, oficio, legajo_supv>
 edificio   <id_e, dir, tipo, nivel_calidad, categoria>
 asignacion <legajo, id_e, fecha_inicio, num_dias>
 
 (Una fila por cada vez que un trabajador es asignado a un edificio.)
 
 (b) Modifique la relación edificio agregando 
    un atributo que permita guardar la ciudad
    del edificio.
 
 (c) Actualice la relación asignaciones incrementando en 4 los números de dias en las
 asignaciones.
 
 (d) Actualice el nivel de calidad de los edificios que son oficinas cambiando 4 por 5 y la
 categoría de 1 por 4.

 (e) Elimine todos los plomeros.
 
 (f) Elimine los edificios que son residencias.
 
 */

 a)

ALTER TABLE trabajdor ADD COLUMN edad DECIMAL(3,1) DEFAULT 18;

b)
ALTER TABLE edificio ADD COLUMN ciudad VARCHAR(255);

c)
UPDATE asignacion
SET num_dias = num_dias + 4 UPDATE edificio 
SET nivel_calidad = 5 
WHERE nivel_calidad = 4;


d)

UPDATE edificio 
SET nivel_calidad = 5 
WHERE nivel_calidad = 4;

UPDATE edificio 
SET categoria = 4 
WHERE categoria = 1;



e)

DELETE FROM asignacion
WHERE legajo IN (SELECT legajo FROM trabajador NATURAL JOIN asignacion WHERE oficio ILIKE 'plomero');

DELETE FROM trabajador 
WHERE oficio ILIKE 'plomero';

f)

DELETE FROM asignacion 
WHERE id_e IN (SELECT id_e FROM edificio WHERE tipo ILIKE 'residencia');

DELETE FROM edificio 
WHERE tipo ILIKE 'residencia';


--DML
/* 
 
 trabajador <legajo PK FK, nombre, tarifa, oficio, legajo_supv>
 
 edificio   <id_e PK , dir, tipo, nivel_calidad, categoria>
 
 asignacion <FK legajo PK FK, id_e PK FK , fecha_inicio, num_dias>
 
*/
/*
 
 trabajador <legajo, nombre, tarifa, oficio, legajo_supv>
 edificio   <id_e, dir, tipo, nivel_calidad, categoria>
 asignacion <legajo, id_e, fecha_inicio, num_dias>
 

 (a) Nombre de los trabajadores cuya tarifa está entre 10 y 12 pesos.
 
 (b) Cuáles son los oficios de los trabajadores asignados al edificio 435?
 
 (c) Indicar el nombre del trabajador y el de su supervisor. X
 
 (d) Nombre de los trabajadores asignados a oficinas.
 
 (e) Qué trabajadores reciben una tarifa por hora mayor que la de su supervisor? X
 
 (f) Cuál es el número total de días 
     que se han dedicado a plomería en el edificio 312?
 
 (g) Cuántos tipos de oficios diferentes hay? 
 
 (h) Para cada supervisor, 
 cuál es la tarifa por hora más alta que se paga a un trabajador
 que informa a ese supervisor?
 
 (i) Para cada supervisor que supervisa a más de un trabajador, 
 cuál es la tarifa más alta que se paga a un trabajador que informa 
 a ese supervisor?
 
 (j) Para cada tipo de edificio, 
 cuál es el nivel de calidad medio de los edificios con categoría 1? 
 Considérense sólo aquellos tipos de edificios que tienen un nivel de calidad
 máximo no mayor que 3.
 
 (k) Qué trabajadores reciben una tarifa por hora menor que la del promedio? D
 
 (l) Qué trabajadores reciben una tarifa por hora menor 
     que la del promedio de los trabajadores 
     que tienen su mismo oficio?
 
 (m) Qué trabajadores reciben una tarifa por hora 
     menor que la del promedio de los trabajadores que 
     dependen del mismo supervisor que él? D
 
 (n) Seleccione el nombre de los electricistas 
 asignados al edificio 435 y la fecha en la que
 empezaron a trabajar en él.
 
 (ñ) 
 Qué supervisores tienen trabajadores 
 que tienen una tarifa por hora por encima de los
 12 euros?
 
 
 */

a) 
SELECT  
    t.nombre
FROM
    trabajador t 
WHERE 
    t.tarifa BETWEEN 10 AND 12

b)

SELECT
    t.oficio 
FROM 
    trabajador t 
    JOIN asignacion a ON t.legajo = a.legajo 
    JOIN edificio e   ON e.id_e   = a.id_e 
WHERE
    a.id_e = 435;


c) 

SELECT 
    t1.nombre AS trabajador,
    t2.nombre AS supervisor 
FROM 
    trabajador t1 
    JOIN trabajador t2 ON t1.legajo_supv = t2.legajo;

d) 

Nombre de los trabajadores asignados a oficinas.

SELECT 
    t.nombre 
FROM 
    trabajador t 
    JOIN asignacion a ON t.legajo = a.legajo
    JOIN edificio   e   ON a.id_e = e.id_e 
WHERE 
    e.tipo ILIKE 'Oficina';

e)  
SELECT 
    t1.nombre AS trabajador_nombre
FROM
    trabajador t1 
    JOIN trabajador t2 ON t1.legajo_supv = t2.legajo 
WHERE 
    t1.tarifa > t2.tarifa;
 
f)
SELECT 
    SUM (num_dias) AS numero_total_de_dias_dedicados_a_plomeria
FROM 
    edificio e 
    JOIN asignacion a ON e.id_e = a.id_e 
    JOIN trabajador t ON t.legajo = a.legajo
WHERE 
    t.oficio ILIKE 'electricista';

g)
    SELECT COUNT(DISTINCT t.oficio) FROM trabajador t;

h)

SELECT
    t2.legajo, MAX(t1.tarifa) AS tarifa_mas_alta
FROM 
    trabajador t1 
    JOIN trabajador t2 ON t1.legajo_supv = t2.legajo
GROUP BY 
    t2.legajo;

--solucion 2

SELECT legajo_supv, max(tarifa) AS max_tarif
FROM trabajador
GROUP BY legajo_supv;

i)

SELECT
   t2.legajo,MAX(t1.tarifa) AS tarifa_mas_alta
FROM 
    trabajador t1 
    JOIN trabajador t2 ON t1.legajo_supv = t2.legajo
GROUP BY 
    t2.legajo
HAVING COUNT (t1.legajo) > 1;

j)

SELECT 
    e.tipo AS tipo_de_eficio,
    AVG(e.nivel_calidad)
FROM 
    edificio e
WHERE 
    e.categoria = 1 
    AND 
    nivel_calidad <= 3
GROUP BY  
    e.tipo;

k) X
SELECT 
    t.legajo AS legajo 
FROM 
    trabajador t 
GROUP BY 
    t.legajo 
HAVING t.tarifa < AVG(t.tarifa);


SELECT legajo, nombre, tarifa
FROM trabajador
WHERE tarifa < (SELECT avg(tarifa) 
                FROM trabajador);

l)

SELECT 
    t1.legajo,
    t1.tarifa
FROM
    trabajador t1
WHERE 
    t1.tarifa 
        <
    ( SELECT 
            AVG(t2.tarifa)
      FROM 
            trabajador t2 
      WHERE SELECT 
    t1.legajo
FROM 
    trabajador t1 
WHERE 
    t1.tarifa 
        
        <

    (   
        SELECT 
            AVG(t2.tarifa)
        FROM 
            trabajador t2
        WHERE 
            t2.legajo_supv = t1.legajo_supv

    )
        t2.oficio = t1.oficio
    );
    
m)

SELECT 
    t1.*
FROM 
    trabajador t1 
WHERE 
    t1.tarifa 
        
        <

    (   
        SELECT 
            AVG(t2.tarifa)
        FROM 
            trabajador t2
        WHERE 
            t2.legajo_supv = t1.legajo_supv

    );       
    
n)

SELECT 
    t.nombre, a.fecha_inicio
FROM 
    trabajador t 
    JOIN asignacion a ON t.legajo = a.legajo 
    JOIN edificio   e ON a.id_e   = e.id_e 

WHERE 
    e.id_e = 435 
    AND 
    t.oficio ILIKE 'electricista'



ñ)

SELECT 
    t2.legajo 
FROM 
    trabajador t1
    JOIN trabajador t2 ON t1.legajo_supv = t2.legajo 
WHERE 
    t1.tarifa > 12;







