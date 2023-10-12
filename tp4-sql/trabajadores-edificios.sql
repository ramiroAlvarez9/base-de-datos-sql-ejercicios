-- DDL
-- (a) Modifique la relación trabajador 
-- agregando la edad del mismo.
/*
 trabajador <legajo, nombre, tarifa, oficio, legajo_supv>
 edificio   <id_e, dir, tipo, nivel_calidad, categoria>
 asignacion <legajo, id_e, fecha_inicio, num_dias>
 
 (Una fila por cada vez que un trabajador es asignado a un edificio.)
 (b) Modifique la relación edificio agregando un atributo que permita guardar la ciudad
 del edificio.
 (c) Actualice la relación asignaciones incrementando en 4 los números de dias en las
 asignaciones.
 (d) Actualice el nivel de calidad de los edificios que son oficinas cambiando 4 por 5 y la
 categoría de 1 por 4.
 (e) Elimine todos los plomeros.
 (f) Elimine los edificios que son residencias.
 */

--a)
ALTER TABLE trabajador ADD COLUMN edad INT;

--b)

ALTER TABLE edificio ADD COLUMN ciudad VARCHAR(55);

--c)

UPDATE asignaciones
SET num_dias = num_dias + 4 

--d)

UPDATE edificio
SET nivel_calidad = 5
WHERE tipo = 'oficina' AND nivel_calidad = 4;

--e)
DELETE trabajador
WHERE oficio = 'plomero';


--f)

(f) Elimine los edificios que son residencias.

DELETE FROM asignacion
WHERE id_e IN 
(SELECT id_e
    FROM edificio
    WHERE tipo <> 'residencia'
);

DELETE FROM edificio
WHERE tipo <> 'residencia' 


 --DML

/* 

 trabajador <legajo PK FK, nombre, tarifa, oficio, legajo_supv>

 edificio   <id_e PK , dir, tipo, nivel_calidad, categoria>

 asignacion <FK legajo PK FK, id_e PK FK , fecha_inicio, num_dias>

*/

/*

 (a) Nombre de los trabajadores cuya tarifa está entre 10 y 12 pesos.

 (b) Cuáles son los oficios de los trabajadores asignados al edificio 435?
 
 (c) Indicar el nombre del trabajador y el de su supervisor. X

 (d) Nombre de los trabajadores asignados a oficinas.

 (e) Qué trabajadores reciben una tarifa por hora mayor que la de su supervisor? X

 (f) Cuál es el número total de días que se han dedicado a plomería en el edificio 312?

 (g) Cuántos tipos de oficios diferentes hay? X

 (h) Para cada supervisor, cuál es la tarifa por hora más alta que se paga a un trabajador
     que informa a ese supervisor?

 (i) Para cada supervisor que supervisa a más de un trabajador, cuál es la tarifa más alta
 que se paga a un trabajador que informa a ese supervisor?

 (j) Para cada tipo de edificio, cuál es el nivel de calidad medio de los edificios con cate-
 goría 1? Considérense sólo aquellos tipos de edificios que tienen un nivel de calidad
 máximo no mayor que 3.
 
 (k) Qué trabajadores reciben una tarifa por hora menor que la del promedio?

 (l) Qué trabajadores reciben una tarifa por hora menor que la del promedio de los traba-
 jadores que tienen su mismo oficio?

 (m) Qué trabajadores reciben una tarifa por hora menor que la del promedio de los traba-
 jadores que dependen del mismo supervisor que él?

 (n) Seleccione el nombre de los electricistas asignados al edificio 435 y la fecha en la que
 empezaron a trabajar en él.

 (ñ) 
 Qué supervisores tienen trabajadores que tienen una tarifa por hora por encima de los
 12 euros?
 */

 --DML
* 
trabajador <legajo PK FK, nombre, tarifa, oficio, legajo_supv>
edificio   <id_e PK , dir, tipo, nivel_calidad, categoria>
asignacion <FK legajo PK FK, id_e PK FK , fecha_inicio, num_dias>


(m) Qué trabajadores reciben una tarifa por hora menor que la del promedio de los traba-
jadores que dependen del mismo supervisor que él?

(n) Seleccione el nombre de los electricistas asignados al edificio 435 y la fecha en la que
empezaron a trabajar en él.

(ñ) 
Qué supervisores tienen trabajadores que tienen una tarifa por hora por encima de los
12 euros?



--l)

SELECT t1.legajo FROM trabajador t1 JOIN trabajador t2 ON t1.oficio = t2.oficio 
GROUP BY t1.legajo HAVING t1.tarifa < (SELECT AVG(t2.tarifa) FROM trabajador t2);

--k)
SELECT t1.legajo FROM trabajador t1 GROUP BY t1.legajo HAVING t1.tarifa < (SELECT AVG(tarifa) FROM trabajador);

---j)

SELECT DISTINCT e.tipo, AVG(nivel_calidad) AS nivel_de_calidad_promedio FROM edificio e WHERE categoria = 1 GROUP BY e.tipo ;

--i) ??
 

--h) ??

SELECT MAX(tarifas_de_trabajadores) AS tarifa_maxima
FROM
(
SELECT DISTINCT t1.tarifa
    FROM trabajador t1 JOIN trabajador t2 ON t1.legajo_supv = t2.legajo
) 
tarifas_de_trabajadores;

--g)
SELECT COUNT(t_oficios_distintos) AS cantidad_de_oficios FROM (SELECT DISTINCT oficio FROM trabajador) t_oficios_distintos;

--f)
SELECT DISTINCT a.id_e ,SUM(a.num_dias) AS dias_totales FROM asignacion a NATURAL JOIN trabajador t
WHERE oficio = 'plomero' AND id_e = 312
GROUP BY a.id_e; 

--e) 
SELECT t1.legajo, t1.nombre 
FROM trabajador t1 JOIN trabajador t2 ON t1.legajo_supv = t2.legajo AND t1.tarifa > t2.tarifa;


--d)
SELECT DISTINCT t.nombre 
FROM trabajador t JOIN asignacion a ON t.legajo = a.legajo JOIN edificio e ON e.id_e = a.id_e
WHERE tipo = 'oficina';
--solucion 2
SELECT nombre FROM trabajador t WHERE t.legajo IN 
    (SELECT legajo FROM asignacion a NATURAL JOIN edificio e WHERE tipo ILIKE 'ofi%');

--c) 

SELECT DISTINCT t1.nombre AS trabajador, t2.nombre AS Supervisor
FROM trabajador t1 JOIN trabajador t2 ON t1.legajo_supv = t2.legajo;

--b)
SELECT DISTINCT oficio 
FROM trabajador t 
    JOIN asignacion a 
ON t.legajo = a.legajo 
WHERE id_e = 435;

--a)
SELECT nombre 
FROM trabajador 
WHERE tarifa BETWEEN 10 AND 12;  


