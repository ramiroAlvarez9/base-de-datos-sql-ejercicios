/*
alumno <legajo: int PK, apellido: varchar(30), nombre: varchar(30),
aniodeingreso: int, trabaja: boolean>
inscripto <cod_curso: varchar(6) PK, legajo: int PK>
curso <cod_curso: varchar(6) PK, legajo_prof: int,
cod_materia: varchar(30), dia: varchar(3), turno: int>
profesor <legajo_prof: int PK, cuil: varchar(30),
apellido: varchar(30), nombre: varchar(30),
marca: varchar(20), aniodeingreso: int,
polizaart: varchar(30), salario: int>
materia <cod_materia: varchar(15) PK,
materia: varchar(150), semestre: int>
puede_dar <cod_materia: varchar(15) PK, legajo_prof: int PK>
profesor_trabaja_industria <legajo_prof: int PK, sueldo: int>
Revise el archivo profesores-tpi--creacion.sql para la creación de las tablas. En
este ejercicio no se proveen las inserciones de prueba.

1. DML

(a) Listar <cod_curso, legajo, apellido, nombre> donde aparezcan aquellos alumnos y
docentes que participan del curso 2 de la materia Bases de Datos.

(b) Listar el sueldo promedio de los profesores de Bases de Datos y que trabajan en la
industria.

(c) Listar <legajo-prof, apellido, nombre, añodeingreso> que no pueden dar una materia
del semestre 1.

(d) Listar <legajo-prof> que no trabajen en la industria.

(e) Considerando que una materia tiene diferentes profesores en una misma materia, listar <cod-materia, salario-promedio> de los profesores de cada materia.
*/