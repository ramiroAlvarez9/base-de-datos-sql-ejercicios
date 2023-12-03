
-- creates

CREATE TABLE alumno(
	legajo int PRIMARY KEY,
	apellido varchar(30),
	nombre varchar(30),
	aniodeingreso int,
	trabaja boolean
);

CREATE TABLE profesor(
	legajo_prof int PRIMARY KEY,
	cuil varchar(30),
	apellido varchar(30),
	nombre varchar(30),
	marca varchar(20),
	aniodeIngreso int,
	polizaart varchar(30),
	salario int
);

CREATE TABLE curso(
	cod_curso varchar(6) PRIMARY KEY,
	legajo_prof int,
	cod_materia varchar(30),
	dia varchar(3),
	turno int
);

CREATE TABLE inscripto(
	cod_curso varchar(6) PRIMARY KEY,
	legajo int,
	FOREIGN KEY (legajo) REFERENCES alumno(legajo),
	FOREIGN KEY (cod_curso) REFERENCES curso(cod_curso)
);


CREATE TABLE materia(
	cod_materia varchar(15) PRIMARY KEY,
	materia varchar(150),
	semestre int
);

CREATE TABLE puede_dar(
	cod_materia varchar(15),
	legajo_prof int,
	PRIMARY KEY(cod_materia, legajo_prof)
);

CREATE TABLE profesor_trabaja_industria(
	legajo_prof int PRIMARY KEY,
	sueldo int
);

-- insert ----

#PARA ESTE EJERCICIO NO SE PROVEEN LOS DATOS DE PRUEBA.

-- Inserciones en la tabla alumno
INSERT INTO alumno VALUES (1, 'Apellido1', 'Nombre1', 2020, true);
INSERT INTO alumno VALUES (2, 'Apellido2', 'Nombre2', 2019, false);
-- Puedes seguir añadiendo más filas según sea necesario.

-- Inserciones en la tabla inscripto
INSERT INTO inscripto VALUES ('C001', 1);
INSERT INTO inscripto VALUES ('C002', 2);
-- Puedes seguir añadiendo más filas según sea necesario.

-- Inserciones en la tabla curso
INSERT INTO curso VALUES ('C001', 101, 'M001', 'LUN', 1);
INSERT INTO curso VALUES ('C002', 102, 'M002', 'MAR', 2);
-- Puedes seguir añadiendo más filas según sea necesario.

-- Inserciones en la tabla profesor
INSERT INTO profesor VALUES (101, '123456789', 'ApellidoProf1', 'NombreProf1', 'Marca1', 2010, 'Poliza1', 50000);
INSERT INTO profesor VALUES (102, '987654321', 'ApellidoProf2', 'NombreProf2', 'Marca2', 2012, 'Poliza2', 60000);
-- Puedes seguir añadiendo más filas según sea necesario.

-- Inserciones en la tabla materia
INSERT INTO materia VALUES ('M001', 'Bases de Datos', 1);
INSERT INTO materia VALUES ('M002', 'Otra Materia', 2);
-- Puedes seguir añadiendo más filas según sea necesario.

-- Inserciones en la tabla puede_dar
INSERT INTO puede_dar VALUES ('M001', 101);
INSERT INTO puede_dar VALUES ('M002', 102);
-- Puedes seguir añadiendo más filas según sea necesario.

-- Inserciones en la tabla profesor_trabaja_industria
INSERT INTO profesor_trabaja_industria VALUES (101, 70000);
INSERT INTO profesor_trabaja_industria VALUES (102, 80000);
-- Puedes seguir añadiendo más filas según sea necesario.
