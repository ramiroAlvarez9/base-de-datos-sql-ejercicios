COMIQUERÍA < nombre_comiquería PK, forma_contributiva, ciudad, dirección, piso, local >
EDITORIAL < nombre_editorial PK, jefe, nro_empleados, al_día_con_afip>
CÓMIC < nombre PK, tomo PK, demografía, origen, edición FK>
VENTA < nombre PK FK, tomo PK FK, nombre_comiquería PK FK, fecha PK, cantidad_comprada, forma_pago>



a) Las formas contributivas son: esquema piramidal, monotributo, cooperativa o empresa.
b) Solo puede haber una comiquería en un LOCAL de un piso de una dirección de una ciudad.
c) Las demografías son: shonen, seinen, shoujo y josei.
d) El origen de los cómics solo pueden ser: Japón, Korea, China, Francia o USA.
e) Las formas de pago son: efectivo, débito, crédito o transferencia.
f ) Ningún número puede ser negativo.


CREATE TABLE comiqueria (
    nombre_comiqueria VARCHAR(100) PRIMARY KEY,
    forma_contributiva VARCHAR(100), 
    ciudad VARCHAR(100),
    direccion VARCHAR(100),
    piso INT,
    loc INT,
    CHECK (forma_contributiva IN('esquema piramidal', 'monotributo', 'cooperativa', 'empresa')),
    UNIQUE(loc),
    CHECK (piso >= 0),
    CHECK (loc >= 0)
);


CREATE TABLE editorial (

    nombre_editorial VARCHAR(100) PRIMARY KEY,
    jefe VARCHAR(100),
    nro_empleados INT,
    al_día_con_afip BOOLEAN,
    CHECK (nro_empleados >= 0)
);

CÓMIC < nombre PK, tomo PK, demografía, origen, edición FK>

CREATE TABLE comic (
    nombre VARCHAR(100),
    tomo INT,
    demografía VARCHAR(100),
    origen VARCHAR(100),
    CHECK (tomo >= 0),
    CONSTRAINT comic_pks PRIMARY KEY (nombre,tomo)

);

VENTA < nombre PK FK, tomo PK FK, nombre_comiquería PK FK, fecha PK, cantidad_comprada, forma_pago>

CREATE TABLE venta (
    nombre VARCHAR(100),
    tomo INT, 
    nombre_comiqueria VARCHAR(100),
    fecha DATE,
    cantidad_comprada INT,
    forma_pago VARCHAR(100),
    CHECK (cantidad_comprada >= 0),
    CHECK (forma_pago IN('efectivo','debito','credito','transferencia')),
    CONSTRAINT venta_pks PRIMARY KEY (nombre,tomo,nombre_comiqueria,fecha),
    CONSTRAINT venta_comics_fks     FOREIGN KEY (nombre,tomo) REFERENCES comic(nombre,tomo),
    CONSTRAINT venta_comiqueria_fks FOREIGN KEY (nombre_comiqueria) REFERENCES comiqueria(nombre_comiqueria)
);



