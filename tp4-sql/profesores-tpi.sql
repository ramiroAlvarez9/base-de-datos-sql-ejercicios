/*

    alumno <legajo: int PK, apellido: varchar(30), nombre: varchar(30), aniodeingreso: int, trabaja: boolean>

    inscripto <cod_curso: varchar(6) PK, legajo: int PK>

    curso <cod_curso: varchar(6) PK, legajo_prof: int, cod_materia: varchar(30), dia: varchar(3), turno: int>

    profesor < legajo_prof: int PK, 
               cuil: varchar(30), 
               apellido: varchar(30), 
               nombre: varchar(30), 
               marca: varchar(20), 
               aniodeingreso: int, 
               polizaart: varchar(30), 
               salario: int>

    materia <cod_materia: varchar(15) PK,materia: varchar(150), semestre: int>

    puede_dar <cod_materia: varchar(15) PK, legajo_prof: int PK>
    
    profesor_trabaja_industria <legajo_prof: int PK, sueldo: int>
    
    (a) 
    Listar <cod_curso, legajo, apellido, nombre> donde aparezcan aquellos alumnos y
    docentes que participan del curso 2 de la materia Bases de Datos.

    (b) Listar el sueldo promedio de los profesores de Bases de Datos y que trabajan en la
    industria.
    
    (c) Listar <legajo-prof, apellido, nombre, añodeingreso> que no pueden dar una materia
    del semestre 1.

    (d) Listar <legajo-prof> que no trabajen en la industria.

    (e) Considerando que una materia tiene diferentes profesores en una misma materia, 
        listar <cod-materia, salario-promedio> de los profesores de cada materia.

*/

a) 
SELECT 
    c.cod_curso, a.legajo, a.apellido,a.nombre
FROM 
    alumno a 
    JOIN inscripto i ON i.legajo      = a.legajo 
    JOIN curso c     ON c.cod_curso   = i.cod_curso
    JOIN materia m   ON m.cod_materia = c.cod_materia 
WHERE 
    m.materia ILIKE 'bases de datos'
        AND
    c.cod_curso = 2

UNION 

SELECT 
    c.cod_curso, a.legajo, a.apellido,a.nombre
FROM 
    profesor p  
    JOIN puede_dar pd ON  p.legajo_prof = pd.legajo_prof 
    JOIN materia   m  ON  m.cod_materia = pd.cod_materia 
    JOIN curso     c  ON  m.cod_materia = c.cod_materia 
WHERE 
    m.materia ILIKE 'bases de datos'
        AND
    c.cod_curso = 2

b) 

SELECT 
    p.legajo_prof, 
    AVG(profesor_trabaja_industria.sueldo) AS sueldo_promedio_de_profesores
FROM 
    profesor p 
    JOIN profesor_trabaja_industria profesor_trabaja_industria 
    ON   profesor_trabaja_industria.legajo_prof = p.legajo_prof
GROUP BY 
    p.legajo_prof;

c) 

-- Solucion V1
SELECT
    p.legajo_prof, p.apellido, p.nombre, p.nombre
FROM 
    profesor p 
    JOIN puede_dar puede_dar ON puede_dar.legajo_prof = p.legajo_prof
    JOIN materia m           ON puede_dar.cod_materia = m.cod_materia
WHERE 
    m.semestre <> 1 

    EXCEPT 

SELECT
    p.legajo_prof, p.apellido, p.nombre, p.nombre
FROM 
    profesor p 
    JOIN puede_dar puede_dar ON puede_dar.legajo_prof = p.legajo_prof
    JOIN materia m           ON puede_dar.cod_materia = m.cod_materia
WHERE 
    m.semestre = 1 

-- solucion V2 

SELECT
    p.legajo_prof, p.apellido, p.nombre, p.nombre
FROM 
    profesor p 
    JOIN puede_dar puede_dar ON puede_dar.legajo_prof = p.legajo_prof
    JOIN materia m           ON puede_dar.cod_materia = m.cod_materia
WHERE 
    m.semestre NOT IN 
    (
        SELECT
            m.semestre 
        FROM 
            materia m 
        WHERE m.semestre = 1
    );

-- solucion V3 
SELECT 
    p.legajo_prof, p.apellido, p.nombre, p.anioDeIngreso AS anioDeIngreso
FROM 
    PROFESOR p 
    JOIN PUEDE_DAR pdar ON p.legajo_prof = pdar.legajo_prof
WHERE 
    p.legajo_prof NOT IN (
                            SELECT p1.legajo_prof
                            FROM PROFESOR p1 
                            JOIN PUEDE_DAR pdar ON p1.legajo_prof =pdar.legajo_prof
                            JOIN MATERIA m ON pdar.cod_materia = m.cod_materia
                            WHERE semestre = 1 );


d) 
SELECT 
    p.legajo_prof 
FROM 
    profesor p 
WHERE 
    p.legajo_prof 
        NOT IN (
                SELECT 
                    ptindustria.legajo_prof
                FROM
                    profesor_trabaja_industria ptrabajaindustria 
                )
    
-- solucion V2 

SELECT 
    p.legajo_prof 
FROM
    profesor p 

    EXCEPT 

SELECT 
    pti.legajo_prof 
FROM
    profesor_trabaja_industria pti
        

e) 
    SELECT 
        m.cod_materia, 
        AVG(p.salario)
    FROM 
        puede_dar pd 
        JOIN profesor p ON p.legajo_prof = pd.legajo_prof 
        JOIN materia  m ON m.cod_materia = pd.cod_materia
GROUP BY 
    p.legajo_prof, m.cod_materia;