MANADA < región PK, origen PK, temperatura, población >
LOBO < nombre PK, peso, edad, región PK FK, origen PK FK >
RASTREADOR < id PK, porcentaje_batería >
ENCUENTRA < nombre PK, región PK FK, origen PK FK, id PK, fecha PK >
a) Las regiones deben comenzar por "RG ".
b) El porcentaje de batería debe ser por defecto veinte, y un número entero entre cero y cien.
c) Las fechas de encuentro no pueden ser en el mes de octubre ni de noviembre.
d) La edad puede ser como máximo treinta y cuatro.
e) Las temperaturas deben ser números decimales entre menos treinta y sesenta.
f ) Población es un número entero que por defecto debe ser mil.


CREATE TABLE manada (
    region VARCHAR(55),
    origen VARCHAR(55), 
    temperatura DECIMAL(3,1),
    poblacion INT DEFAULT 1000,
    PRIMARY KEY (region,origen),
    CHECK (temperatura BETWEEN -30 AND 60),
    CHECK (region ILIKE 'RG%')
);

INSERT INTO manada(region, origen, temperatura, poblacion) VALUES ('rg rio del valle', 'argentina', 01.1, 1100);


CREATE TABLE lobo (
    nombre VARCHAR(55),
    peso INT,
    edad INT,
    region VARCHAR(55),
    origen VARCHAR(55),
    CHECK (edad <= 34),
    PRIMARY KEY (nombre),
    CONSTRAINT lobo_primeraFk FOREIGN KEY (region,origen) REFERENCES manada(region,origen)
    --Si son de la misma tabla, puedo declarar la restriccion en una sola linea.

);

CREATE TABLE rastreador (
    id INT PRIMARY KEY, 
    porcentaje_bateria INT, 
    CHECK (porcentaje_bateria BETWEEN 5 AND 100)
);

ENCUENTRA < nombre PK, región PK FK, origen PK FK, id PK, fecha PK >


CREATE TABLE encuentra (
    nombre VARCHAR(55),
    region VARCHAR(55),
    origen VARCHAR(55),
    id INT,
    fecha TIMESTAMP,
    PRIMARY KEY (nombre, region, origen, id, fecha),
    CONSTRAINT encuentra_fk1rgor  FOREIGN KEY (region,origen) REFERENCES manada(region,origen),
    CONSTRAINT encuentra_fk2id    FOREIGN KEY (id) REFERENCES rastreador(id)
);