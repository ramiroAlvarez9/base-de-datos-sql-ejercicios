4. UNQuesta

ALUMNO < legajo PK, nombre, dni, teléfono, fecha_nacimiento>
COMISION < número PK, materia PK, nombre_profesor>
PREGUNTA < consigna PK, número PK FK, materia PK FK, tema, dificultad>
RESPUESTA < legajo PK FK, consigna PK FK, número PK FK, materia PK FK, >
Con las restriciones:

a) Las respuestas están vinculadas a las preguntas.
-- b) Los temas pueden ser: matemática, lengua, geografía e historia.
-- c) Los profesores solo pueden estar dictando una comisión,
d) Los teléfonos son una cadena de caracteres que deben comenzar por "+54".

CREATE TABLE respuesta (
    legajo INT,
    consigna (300), 
    numero INT, 
    materia (100), 
    CONSTRAINT respuesta_pks PRIMARY KEY (legajo,consigna,numero,materia),
    CONSTRAINT repuesta_legajo_fk   FOREIGN KEY (legajo)   REFERENCES alumno(legajo),
    CONSTRAINT repuesta_consigna_fk FOREIGN KEY (consigna) REFERENCES pregunta(consigna),
    CONSTRAINT repuesta_numero_fk   FOREIGN KEY (numero)   REFERENCES comision(numero),
    CONSTRAINT repuesta_materia_fk  FOREIGN KEY (materia)  REFERENCES comision(materia),
);

CREATE TABLE pregunta(

    consigna VARCHAR(300), 
    numero INT, -- pk fk
    materia (100), --pk fk 
    tema VARCHAR(100),
    dificultad INT,
    CHECK (tema IN('matematica', 'lengua', 'geografia', 'historia'))
    CONSTRAINT pregunta_numero_fk FOREIGN KEY (numero) REFERENCES comision(numero),
    CONSTRAINT pregunta_materia_fk FOREIGN KEY (materia) REFERENCES comision(materia)

);

CREATE TABLE alumno (

    legajo INT PRIMARY KEY, 
    nombre VARCHAR(55),
    dni INT, 
    telefono INT , 
    fecha_nacimiento DATE,
    CHECK (telefono LIKE +54'%')
);

CREATE TABLE comision (
    numero INT,
    materia VARCHAR(100),
    nombre_profesor VARCHAR(100) ,
    UNIQUE (nombre_profesor),
    CONSTRAINT comision_pks PRIMARY KEY (numero,materia)
);

