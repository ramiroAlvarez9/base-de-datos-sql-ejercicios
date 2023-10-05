PARTICIPANTE < dni PK, edad, ciudad >
PROGRAMA < número PK, fecha, hora_inicio, grabación>
PLATO < nombre PK, dni PK FK, tipo, es_vegano, número FK>
Con las restriciones:
a) La hora es un float mayor a doce y menor a veinticuatro.
b) No puede haber dos participantes de un mismo lugar.
c) El tipo de plato debe ser: entrada, principal, postre o aperitivo.
d) Los participantes no pueden ser menores de edad.


CREATE TABLE participante (
    dni SERIAL PRIMARY KEY, 
    edad INT,
    ciudad VARCHAR(55),
    CHECK (edad >= 18)
);
CREATE TABLE programa (
    numero SERIAL PRIMARY KEY,
    fecha DATE, 
    hora_inicio FLOAT,
    CHECK (hora_inicio BETWEEN 12 AND 24),
    grabacion VARCHAR (55)
);

CREATE TABLE plato (
    nombre VARCHAR(55),
    dni SERIAL, 
    numero INT, 
    tipo VARCHAR(100),
    es_vegano BOOLEAN,
    CHECK (tipo IN ('entrada','principal', 'postre', 'aperitivo')),
    PRIMARY KEY(nombre, dni),
    CONSTRAINT plato_fk_dni FOREIGN KEY (dni) REFERENCES participante(dni), 
    CONSTRAINT plato_fk_numero FOREIGN KEY (numero) REFERENCES programa(numero) 
);