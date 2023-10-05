Pequeños Héroes
PROTECTOR < pasaporte PK, altura, peso, color_traje>
HERRAMIENTA < nombre PK, poder, color, origen, pasaporte FK>
CIUDAD < nombre PK, ubicación, población >
PROTEGE < nombre PK FK, pasaporte PK FK, fecha PK, fue_exitoso>
Con las restriciones:
a) Los trajes solo pueden ser de color: rojo, verde, azul, blanco o dorado.
b) La combinación de poder, color y origen debe ser única.
c) Los protectores pueden medir como máximo 120cm.
d) Las fechas deben ser entre 2020 y marzo del 2053.

CREATE TABLE protector (
    pasaporte VARCHAR (100) PRIMARY KEY, 
    altura INT, 
    peso INT, 
    color_traje VARCHAR(55),
    CHECK (color_traje IN ('rojo', 'verde', 'azul', 'blanco', 'dorado')),
    CHECK (altura <= 120)
);

CREATE TABLE herramienta (
    nombre PRIMARY KEY,
    poder VARCHAR(55),
    color VARCHAR(55),
    origen VARCHAR(55),
    UNIQUE(poder,color,origen),
    CONSTRAINT herramienta_fk_pasaporte FOREIGN KEY protector(pasaporte)
);

CIUDAD < nombre PK, ubicación, población >

CREATE TABLE ciudad (
    nombre VARCHAR (55) PRIMARY KEY,
    ubicacion VARCHAR(55),
    poblacion INT  
);

CREATE TABLE protege (
    nombre VARCHAR(55),
    pasaporte VARCHAR(100),
    fecha DATE,
    fue_exitoso BOOLEAN,
    CHECK (fecha BETWEEN '01/01/2020' AND '31/12/2023')

);