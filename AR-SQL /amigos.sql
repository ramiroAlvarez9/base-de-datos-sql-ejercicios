AMIGO<nombre, edad, fechaIngresoAlGrupo>
REGALO<nombre, destinatario, fecha, tipoRegalo, valor>
FECHA_ESPECIAL<fecha, eventoConmemorativo>

CREATE TABLE amigo 
(
    nombre VARCHAR(255) PRIMARY KEY, 
    edad INT,
    fechaIngresoAlGrupo DATE 
);
CREATE TABLE regalo
(
    nombre VARCHAR(255),
    destinatario VARCHAR(255), 
    fecha DATE,
    tipoRegalo VARCHAR(255),
    valor INT,
    PRIMARY KEY (nombre,destinatario,fecha), 
    CONSTRAINT nombre_amigo_fk 
        FOREIGN KEY (nombre) REFERENCES amigo(nombre),
    CONSTRAINT destinatario_amigo_fk 
        FOREIGN KEY (destinatario) REFERENCES amigo(nombre)
);

CREATE TABLE fecha_especial 
(
    fecha DATE , 
    eventoConmemorativo VARCHAR(255),
    CONSTRAINT fecha_de_tabla_regalo_fk 
        FOREIGN KEY (fecha) REFERENCES regalo(fecha) 
);


-- Inserciones en la tabla amigo
INSERT INTO amigo (nombre, edad, fechaIngresoAlGrupo) 
VALUES 
    ('Ana', 32, '2002-07-05'),
    ('Fernando', 25, '2002-07-10'),
    ('Juan', 27, '2003-08-20'),
    ('Florencia', 26, '2004-02-12'),
    ('Jonatan', 28, '2005-01-02'),
    ('Eduardo', 30, '2005-06-26'),
    ('Julia', 28, '2006-06-19'),
    ('Carla', 29, '2007-06-19'),
    ('Marina', 25, '2020-06-19'),
    ('Claudio', 37, '2010-01-25');
    


-- Inserciones en la tabla regalo
INSERT INTO regalo (nombre, destinatario, fecha, tipoRegalo, valor) 
VALUES 
    ('Ana', 'Eduardo', '2018-01-11', 'Juguetes', 90),
    ('Ana', 'Carla', '2003-04-21', 'Perfumes', 136),
    ('Ana', 'Florencia', '2012-06-25', 'Electronica', 168),
    ('Ana', 'Florencia', '2005-02-05', 'Flores', 170),
    ('Ana', 'Claudio', '2010-01-25', 'Libreria', 207),
    ('Ana', 'Carla', '2009-09-11', 'Juguetes', 120),
    ('Ana', 'Fernando', '2002-07-14', 'Perfumes', 210),
    ('Ana', 'Carla', '2009-11-24', 'Ropa', 243),
    ('Carla', 'Marina', '2002-02-13', 'Flores', 81),
    ('Carla', 'Ana', '2020-02-03', 'Perfumes', 83),
    ('Carla', 'Jonatan', '2006-04-07', 'Libreria', 84),
    ('Carla', 'Florencia', '2020-03-13', 'Libreria', 150),
    ('Carla', 'Fernando', '2013-08-12', 'Ropa', 154),
    ('Carla', 'Julia', '2014-01-25', 'Ropa', 200),
    ('Eduardo', 'Juan', '2017-08-24', 'Ropa', 49),
    ('Eduardo', 'Julia', '2016-09-11', 'Libreria', 79),
    ('Eduardo', 'Fernando', '2019-02-15', 'Juguetes', 100),
    ('Eduardo', 'Florencia', '2020-04-05', 'Perfumes', 108),
    ('Eduardo', 'Juan', '2019-07-20', 'Flores', 140),
    ('Eduardo', 'Julia', '2019-02-16', 'Electronica', 195),
    ('Fernando', 'Marina', '2008-02-21', 'Ropa', 48),
    ('Fernando', 'Juan', '2013-11-04', 'Perfumes', 111),
    ('Fernando', 'Florencia', '2017-11-12', 'Juguetes', 183),
    ('Florencia', 'Claudio', '2016-02-14', 'Electronica', 42),
    ('Florencia', 'Eduardo', '2016-01-01', 'Juguetes', 129),
    ('Florencia', 'Marina', '2020-12-06', 'Electronica', 189),
    ('Florencia', 'Marina', '2017-07-20', 'Perfumes', 198),
    ('Jonatan', 'Marina', '2018-09-11', 'Perfumes', 187),
    ('Juan', 'Julia', '2013-11-21', 'Flores', 178),
    ('Juan', 'Juan', '2003-09-19', 'Electronica', 207),
    ('Juan', 'Julia', '2007-12-14', 'Perfumes', 244),
    ('Julia', 'Florencia', '2015-08-28', 'Libreria', 68),
    ('Julia', 'Fernando', '2011-08-27', 'Flores', 118),
    ('Julia', 'Marina', '2006-01-03', 'Flores', 187),
    ('Marina', 'Carla', '2002-04-29', 'Electronica', 52),
    ('Marina', 'Marina', '2003-03-11', 'Ropa', 86),
    ('Marina', 'Carla', '2018-07-20', 'Juguetes', 114),
    ('Marina', 'Juan', '2013-11-24', 'Juguetes', 115),
    ('Marina', 'Jonatan', '2005-01-02', 'Perfumes', 129),
    ('Marina', 'Carla', '2017-01-01', 'Electronica', 202),
    ('Marina', 'Eduardo', '2005-06-26', 'Juguetes', 241),
    ('Marina', 'Carla', '2017-03-08', 'Perfumes', 245),
    ('Juan',  'Marina', '2017-09-11', 'Juguetes', 500),
    ('Julia', 'Carla', '2018-01-01', 'Juguetes', 500),
    ('Julia', 'Jonatan', '2018-02-14', 'Juguetes', 500),
    ('Carla','Juan' '2018-03-08', 'Electronica', 600);
    
-- Inserciones en la tabla fecha_especial
INSERT INTO fecha_especial (fecha, eventoConmemorativo)
VALUES 
    ('2003-09-19', 'Mundial de Argentina'),
    ('2011-08-27', 'Día de San Valentín'), 
    ('2020-02-03', 'Día de San Valentín'),
    ('2018-07-20', 'Día del Amigo'),
    ('2018-09-11', 'Día del Maestro'),
    ('2018-02-14', 'Día de San Valentín'),
    ('2018-03-08', 'Día de la Mujer'),
    ('2018-02-14', 'Día de San Valentín'),
    ('2018-03-08', 'Día de la Mujer'),
    ('2017-09-11', 'Día del Maestro'),
    ('2018-01-01', 'Año Nuevo'),
    ('2017-03-08', 'Día de la Mujer'),
    ('2017-07-20', 'Día del Amigo'),
    ('2017-01-01', 'Año Nuevo'),
    ('2017-02-14', 'Día de San Valentín'),
    ('2016-09-11', 'Día del Maestro'),
    ('2016-01-01', 'Año Nuevo'),
    ('2016-02-14', 'Día de San Valentín'),
    ('2020-02-03', 'Día de San Valentín'),
    ('2020-04-05', 'Día de la Mujer'),
    ('2020-12-06', 'Día del Maestro');



AMIGO<nombre, edad, fechaIngresoAlGrupo>
REGALO<nombre, destinatario, fecha, tipoRegalo, valor>
FECHA_ESPECIAL<fecha, eventoConmemorativo>

a) Obtener el listado de <nombre, fechaIngresoAlGrupo, destinatario> de todos los regalos que hizo
en lo que va de este año 2023 y en noviembre de 2013

b) Obtener el listado de <nombre, fechaIngresoAlGrupo, destinatario> de todos los regalos realizados
por amigos que regalaron Flores y Perfumes.

c) Obtener el listado de amigos bienvenidos, que son los que recibieron regalos en la fecha que ingresaron al grupo.

d) Obtener el listado de amigos tacaños, que son los que nunca hicieron un regalo.

e) Obtener el listado de amigos por compromiso, 
que son los que solamente hicieron regalos en las
fechas especiales.















a)
    SELECT 
        a.nombre, a.fechaIngresoAlGrupo, r.destinatario
    FROM 
        amigo a 
        JOIN regalo r ON r.nombre = a.nombre 
    WHERE 
        (r.fecha BETWEEN '01-01-2023' AND '04-12-2023')
        AND 
        (r.fecha BETWEEN '01-11-2013' AND '-11-2013')

    SELECT 
        a.nombre, a.fechaIngresoAlGrupo, r.destinatario
    FROM 
        amigo a 
        JOIN regalo r ON r.nombre = a.nombre 
    WHERE 
        ( r.fecha >= '01/01/2023' AND r.fecha <= '04/12/2023' )
        AND 
        ( r.fecha >= '01/11/2013' AND r.fecha <= '31/11/2013');

b) 
    SELECT DISTINCT
        a.nombre,a.fechaIngresoAlGrupo, r4.destinatario, r4.tipoRegalo
    FROM 
        (
            SELECT DISTINCT r2.nombre
            FROM 
                regalo r2 
            WHERE 
                r2.tipoRegalo ILIKE 'flores'        
                INTERSECT 
            SELECT DISTINCT r3.nombre
            FROM 
                regalo r3
            WHERE 
                r3.tipoRegalo ILIKE 'perfumes'        
        ) AS nombre_amigos_floresyperfumes
    JOIN 
    amigo a         ON a.nombre =  nombre_amigos_floresyperfumes.nombre
    JOIN regalo r4  ON nombre_amigos_floresyperfumes.nombre = r4.nombre
    WHERE 
        r4.tipoRegalo ILIKE 'perfumes' OR r4.tipoRegalo ILIKE 'flores';

    -- solucion V2
    
    SELECT DISTINCT
        a.nombre, a.fechaIngresoAlGrupo, r.destinatario, r.tipoRegalo
    FROM 
        amigo a 
        JOIN regalo r ON a.nombre = r.nombre 
    WHERE 
        a.nombre IN 
            (
                SELECT 
                    a.nombre
                FROM 
                    amigo a NATURAL JOIN regalo r2 
                WHERE 
                    r2.tipoRegalo ILIKE 'perfumes'
                    
                    INTERSECT
                SELECT 
                    a.nombre
                FROM 
                    amigo a NATURAL JOIN regalo r2 
                WHERE 
                    r2.tipoRegalo ILIKE 'flores'
            );



c)
    SELECT 
        a.*
    FROM 
        regalo r
        JOIN amigo a ON r.destinatario = a.nombre 
    WHERE
        a.fechaIngresoAlGrupo = r.fecha;

d)


    SELECT
        a.nombre 
    FROM 
        amigo a 
    WHERE 
        a.nombre
            NOT IN 
                (
                    SELECT 
                        r.nombre 
                    FROM 
                        regalo r
                );
        
e) 
SELECT 
    r.nombre 
FROM
    regalo r 
    JOIN fecha_especial fespecial ON r.fecha = fespecial.fecha 

EXCEPT

SELECT 
    a2.nombre 
FROM
    amigo a2 
    JOIN regalo r2 ON a2.nombre = r2.nombre 
WHERE 
    r2.fecha NOT IN
                    (
                        SELECT 
                            fecha 
                        FROM 
                            fecha_especial
                    );


