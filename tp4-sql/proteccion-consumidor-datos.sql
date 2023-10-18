producto <pid: INT PK, descripcion: VARCHAR(70), tipo: VARCHAR(40), contenido: VARCHAR(40)>
tipo <tipo: VARCHAR(40) PK, descripcion: VARCHAR(100)>
comercio <comercio: INT PK, nombre: VARCHAR(100),direccion: VARCHAR(250), barrio: VARCHAR(50), zona: VARCHAR(60)>
precio <pid: INT PK FK, comercio: INT PK FK,
fecha_registro: DATETIME PK, precio DECIMAL(10,2)>




CREATE TABLE producto (
    pid INT PRIMARY KEY,
    descripcion VARCHAR(70),
    tipo VARCHAR(40),
    contenido VARCHAR(40)
);

CREATE TABLE tipo (
    tipo VARCHAR(40) PRIMARY KEY,
    descripcion VARCHAR(100)
);
CREATE TABLE comercio (
    comercio INT PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(250),
    barrio VARCHAR(50),
    zona VARCHAR(60)
);

CREATE TABLE precio (
    pid INT,
    comercio INT,
    fecha_registro TIMESTAMP,
    precio DECIMAL(10,2),
    PRIMARY KEY (pid, comercio, fecha_registro),
    FOREIGN KEY (pid) REFERENCES producto(pid),
    FOREIGN KEY (comercio) REFERENCES comercio(comercio)
);
