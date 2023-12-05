CREATE TABLE alumno (
    nroAlumno INT PRIMARY KEY,
    nombre VARCHAR(100),
    grupo VARCHAR(100)
);

CREATE TABLE practica(
    nroPractica INT PRIMARY KEY,
    curso VARCHAR(100),
    fecha TIMESTAMP
);

CREATE TABLE entrega (
    nroAlumno INT,
    nroPractica INT,
    nota INT,
    PRIMARY KEY(nroAlumno,nroPractica),
    CONSTRAINT entrega_fk_nroAlumno   FOREIGN KEY (nroAlumno)   REFERENCES alumno(nroAlumno),
    CONSTRAINT entrega_fk_nroPractica FOREIGN KEY (nroPractica) REFERENCES practica(nroPractica)
);

-- inserciones en la tabla ALUMNO
INSERT INTO alumno (nroAlumno, nombre, grupo)
                   VALUES (1000, 'Benjamin', 'BD-12');
                          (1001, 'David', 'BD-14'),
                          (1002, 'Gabriela', 'BD-15'),
                          (1003, 'Gisela', 'BD-13'),
                          (1004, 'David', 'BD-11'),
                          (1005, 'Samuel', 'BD-14'),
                          (1006, 'Gabriel', 'BD-14'),
                          (1007, 'Gabriel', 'BD-11'),
                          (1008, 'Victoria', 'BD-12'),
                          (1009, 'Benjamin', 'BD-11'),
                          (1010, 'Daniel', 'BD-15');

-- Inserciones en la tabla PRACTICA
INSERT INTO practica(nroPractica, curso, fecha) VALUES (1, 'C1', '2020-12-03 00:00:00'),
                                                      (2, 'C1', '2020-04-13 00:00:00'),
                                                      (3, 'C2', '2020-03-12 00:00:00'),
                                                      (4, 'C2', '2020-04-15 00:00:00'),
                                                      (5, 'C2', '2020-05-11 00:00:00'),
                                                      (6, 'C3', '2020-04-12 00:00:00'),
                                                      (7, 'C3', '2020-04-12 00:00:00'),
                                                      (8, 'C4', '2020-03-12 00:00:00'),
                                                      (9, 'C4', '2020-05-11 00:00:00');

-- inserciones en la tabla ENTREGA
entrega 

-- Inserciones en la tabla entrega
INSERT INTO entrega(nroAlumno,nroPractica,nota) VALUES (1000, 1, 6), (1000, 6, 10), (1000, 7, 9), (1000, 8, 10),
                            (1001, 3, 5), (1001, 4, 9),
                            (1002, 3, 4), (1002, 4, 10), (1002, 5, 8),
                            (1003, 1, 7), (1003, 4, 6), (1003, 5, 7), (1003, 6, 3), (1003, 7, 2), (1003, 8, 3), (1003, 9, 8),
                            (1004, 2, 5), (1004, 3, 9), (1004, 7, 6), (1004, 9, 8),
                            (1005, 3, 4), (1005, 4, 5), (1005, 6, 2), (1005, 7, 5), (1005, 8, 5), (1005, 9, 6),
                            (1006, 1, 10), (1006, 4, 7), (1006, 7, 5), (1006, 8, 6),
                            (1007, 1, 4), (1007, 3, 10), (1007, 4, 3), (1007, 5, 10),
                            (1008, 1, 9), (1008, 2, 3), (1008, 5, 9), (1008, 6, 8), (1008, 9, 5),
                            (1009, 2, 9), (1009, 3, 8), (1009, 4, 7), (1009, 6, 6), (1009, 7, 9), (1009, 8, 8),
                            (1010, 3, 8), (1010, 5, 7);



ALUMNO<NroAlumno, Nombre, Grupo>
PRACTICA<NroPractica, Curso, Fecha>
ENTREGA<NroAlumno, NroPractica, Nota>


a) Obtener los alumnos que han entregado prácticas de segundo y tercer curso.

    SELECT 
        a.* 
    FROM 
        alumno a 
        JOIN entrega e  ON a.nroAlumno   = e.nroAlumno
        JOIN practica p ON e.nroPractica = p.nroPractica
    WHERE 
        p.curso ILIKE 'c2' OR p.curso ILIKE 'c3' ;  
        
b) Obtener los alumnos que solo han entregado prácticas de segundo curso.
    SELECT DISTINCT
        a.nombre
    FROM 
        alumno a 
        JOIN entrega e  ON a.nroAlumno   = e.nroAlumno
        JOIN practica p ON p.nroPractica = e.nroPractica
    WHERE 
        p.curso ILIKE 'c2'
        
        EXCEPT
        
    SELECT DISTINCT
        a.nombre
    FROM 
        alumno a 
        JOIN entrega e  ON a.nroAlumno = e.nroAlumno
        JOIN practica p ON p.nroPractica = e.nroPractica
    WHERE 
        p.curso <> 'c2';
    


c) Obtener los alumnos que han entregado prácticas 
        de segundo curso 
    y pertenecen al grupo ”BD-11”

SELECT 
        a.*, p.curso
    FROM 
        alumno a 
        JOIN entrega e  ON a.nroAlumno   = e.nroAlumno
        JOIN practica p ON p.nroPractica = e.nroPractica
    WHERE 
        p.curso ILIKE 'c2'

    INTERSECT

SELECT 
        a.* , p.curso
    FROM 
        alumno a 
        JOIN entrega e  ON a.nroAlumno   = e.nroAlumno
        JOIN practica p ON p.nroPractica = e.nroPractica
    WHERE 
        a.grupo ILIKE 'bd-11';












