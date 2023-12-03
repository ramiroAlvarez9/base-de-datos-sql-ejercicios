CIUDADANO     <dni PK, nyAp>
PADRON        <dni PK FK, nroMesa, puedeVotar, emitioVoto>
MESA          <nro PK, municipio, provincia>
CARGO         <id PK, nombre, municipio, provincia>
VOTOS         <idMesa PK FK , idCargo PK FK, tipoVoto PK, cantVotos>
VOTOS_FUERZAS <     
                idMesa PK FK, 
                idCargo PK FK,
                nombreLista PK, 
                nombreFuerza, 
                cantVotos
               >




CREATE TABLE ciudadano
(
    dni SERIAL PRIMARY KEY,
    nyAp VARCHAR(255)
);

CREATE TABLE mesa 
(
    nro INT PRIMARY KEY,
    municipio VARCHAR(255),
    provincia VARCHAR(255)
);
CREATE TABLE padron 
(
    dni SERIAL PRIMARY KEY,
    nroMesa    VARCHAR(255),
    puedeVotar BOOLEAN,
    emitioVoto BOOLEAN,
    CONSTRAINT padron_dni_fk
        FOREIGN KEY 
            (dni)
                REFERENCES ciudadano (dni)
);



CREATE TABLE cargo 
(   
    id INT PRIMARY KEY,
    nombre VARCHAR(255),
    municipio VARCHAR(255),
    provincia VARCHAR(255)
);

CREATE TABLE votos 
(
    idMesa INT,
    idCargo VARCHAR(255),
    tipoVoto VARCHAR(255),
    cantVotos INT,
    PRIMARY KEY (idMesa,idCargo)
    CONSTRAINT fk_cargo FOREIGN KEY (idCargo) REFERENCES cargo(id)
);

CREATE TABLE votos_fuerzas 
(
    idMesa  INT ,
    idCargo INT ,
    nombreLista VARCHAR(255),
    nombreFuerza VARCHAR(255),
    cantVotos INT,
    PRIMARY KEY (idMesa,idCargo, nombreLista),
    CONSTRAINT fk_id_mesa 
        FOREIGN KEY 
            (idMesa)
                REFERENCES votos(idMesa),  -- en la tabla cargada en el motor, no hay claves foraneas por un error en la unicidad de las claves de 'VOTOS'
    CONSTRAINT fk_id_cargo 
        FOREIGN KEY 
            (idCargo )
                REFERENCES votos(idCargo)
);

CREATE TABLE votos_fuerzas 
(
    idMesa  INT ,
    idCargo INT ,
    nombreLista VARCHAR(255),
    nombreFuerza VARCHAR(255),
    cantVotos INT,
    PRIMARY KEY (idMesa,idCargo, nombreLista)
);




INSERT INTO 
    mesa 
        VALUES (60, 'Quilmes', 'Buenos Aires'),
               (2,  'Parque Patricios', 'CABA'),
               (3,  'Porque Potricios', 'COBA'); 


INSERT INTO 
        ciudadano 
    VALUES
        (11222333, 'Roberto Perez'),
        (44555666, 'Juan Garcia'),
        (22123123, 'Pepito Del Valle');

INSERT INTO 
    padron 
        VALUES 
            (11222333, 60, true, false),
            (44555666, 70, true, true),
            (22123123, 50, true, false);

INSERT INTO
    cargo
        VALUES 
    (1,'Presidente', NULL, NULL),
    (4, 'Gobernador', 'Avellaneda','Buenos Aires'),
    (33,'Intendente', 'Quilmes','Buenos Aires');

INSERT INTO 
        votos 
    VALUES 
        (2, 5, 'Positivo', 101),
        (2, 4, 'Blanco'  , 10),
        (2, 2,'Nulo',1);


INSERT INTO votos_fuerzas (idMesa,idCargo,nombreLista,nombreFuerza,cantVotos)
    VALUES 
(2 , 1 , 'l1', 'The Lefties' , 1000),
(2 , 4 , 'l2' , 'A+DLS' , 1000),
(2 , 33 ,'l3' , 'A+DLS' , 1000);


DDL / DML

1) Hecho .-

2)
b)

La siguiente consulta da error el ejecutarla, escribirla correctamente.:
    INSERT VALUES ("Avellaneda", 209, "Senadores Provinciales", "Buenos Aires")
    INTO CARGO AT (municipio, id, nombre, provincia);.

        INSERT INTO 
            cargo (municipio, id, nombre, provincia)
                VALUES  
                    ( 209, 'Senadores Provinciales','Avellaneda', 'Buenos Aires');

c) En la mesa 56, la fuerza “Todo Pasa” sacó 98 votos en cada una de sus dos listas para el cargo de
Intendente de Ezeiza, el cual se identifica con el id 178. Agregar los votos actualizando la tabla
VOTOS_FUERZA.
    INSERT INTO
        cargo (id,nombre,municipio ,provincia)
        VALUES (178, 'Intendente de Ezeiza', 'Ezeiza', 'Buenos Aires');
    
    INSERT INTO 
        votos (idMesa,idCargo,tipoVoto,cantVotos)
            VALUES  (56, 178, 'Positivo', 196);

    INSERT INTO votos_fuerzas (idMesa,idCargo,nombreLista,nombreFuerza,cantVotos)
    VALUES (56 , 178 , 'l1', 'Todo Pasa' , 98);

d)
    Eliminar el registro correspondientre al municipio “Porque Potricios” mal cargado en la tabla MESA. 

    DELETE FROM mesa
    WHERE municipio ILIKE 'porque potricios';

DML

a) Obtener la cantidad de mesas que hay en el municipio “Rivadavia” de la provincia de Buenos Aires,
pero no de las mesas de ese municipio en otras provincias.

    SELECT 
        municipio,
        COUNT(*) AS cantidad_de_mesas
    FROM 
        mesa 
    WHERE
        municipio ILIKE 'rivadavia'
            AND 
        provincia 
            NOT IN  (  
                        SELECT provincia
                        FROM   mesa 
                        WHERE 
                            provincia <> 'Buenos Aires'
                    )
    GROUP BY municipio;

b) 
    Obtener el padron de “Alta Gracia” de la provincia de Córdoba. En el padrón se debe poder visualizar:
nro de mesa, dni, nombre y apellido y si puede votar o no. Debe estar ordenado por nro de mesa,
luego por nombre y apellido.

    SELECT 
        p.nroMesa,p.dni, c.nyAp, p.puedeVotar
    FROM 
        padron p 
        JOIN ciudadano c ON p.dni = c.dni 
    ORDER BY  
        p.nroMesa ASC,
        c.nyAp    ASC;

c)
Mostrar los votos de cada uno de los candidatos al cargo de Gobernador de la Provincia de Buenos
Aires, agrupados por municipio. La consulta debe mostrar: municipio, lista, fuerza y votos positivos.
Debe estar ordenada por mayor cantidad de votos.

    SELECT 
        c.municipio, vf.nombreLista ,vf.nombreFuerza, vf.cantVotos
    FROM
        cargo c 
        JOIN votos v ON c.id = v.idCargo 
        JOIN votos_fuerzas vf ON vf.idMesa = v.idMesa 
        AND  vf.idCargo = v.idCargo
        JOIN mesa m   ON m.nro = v.idMesa
    WHERE
        c.nombre ILIKE 'gobernador de la provincia de buenos aires'
            AND 
        m.provincia ILIKE 'buenos aires'
            AND 
        v.tipoVoto ILIKE  'positivo'
    GROUP BY 
        c.municipio
    ORDER BY 
        vf.cantVotos DESC;


d) Modificar la consulta anterior para ver los votos totales de cada fuerza, pero solo de aquellas fuerzas
que hayan conseguido más del 3 % de los votos positivos totales para ese cargo.

    SELECT 
        c.municipio, vf.nombreLista ,vf.nombreFuerza, vf.cantVotos
    FROM
        cargo c 
        JOIN votos v ON c.id = v.idCargo 
        JOIN votos_fuerzas vf ON vf.idMesa = v.idMesa 
        AND  vf.idCargo = v.idCargo
        JOIN mesa m   ON m.nro = v.idMesa
    WHERE
        c.nombre ILIKE 'gobernador de la provincia de buenos aires'
            AND 
        m.provincia ILIKE 'buenos aires'
    GROUP BY 
        c.municipio
    ORDER BY 
        vf.cantVotos DESC;
        


