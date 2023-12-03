COMIDA<codigo, codItem, esEspecial>
BEBIDA<codigo, codItem, centimetrosCubicos>
GUARNICION<codigo, codItem, tamaño>
ITEM<codItem, descripcion, precio, calorias>
ITEMenMENU<codMenu, codItem>
MENU<codMenu, nombre>

CREATE TABLE comida
(
    codigo  INT PRIMARY KEY,
    codItem INT,
    esEspecial BOOLEAN,
    CONSTRAINT comida_item_fk FOREIGN KEY (codItem) REFERENCES item(codItem)
);

CREATE TABLE bebida 
(
    codigo INT PRIMARY KEY,
    codItem INT, 
    centimetrosCubicos INT,
    CONSTRAINT bebida_item_fk FOREIGN KEY (codItem) REFERENCES item(codItem)
);
CREATE TABLE guarnicion
(
    codigo INT PRIMARY KEY,
    codItem INT, 
    centimetrosCubicos INT,
    CONSTRAINT guarnicion_item_fk FOREIGN KEY (codItem) REFERENCES item(codItem)
);
CREATE TABLE item
(
    codItem INT PRIMARY KEY,
    descripcion VARCHAR(255),
    precio INT,
    calorias INT
);

CREATE TABLE itemenmenu 
(
    codMenu INT,
    codItem INT,
    PRIMARY KEY(codMenu,codItem),
    CONSTRAINT itemenmenu_item_fk FOREIGN KEY (codItem) REFERENCES item(codItem)

);
CREATE TABLE  menu 
(
    codMenu INT PRIMARY KEY, 
    nombre VARCHAR(255)
);
-- insercion en ITEM 
INSERT INTO item (codItem, descripcion, precio, calorias)
VALUES
(510, 'Hamburguesa', 50, 80),
(511, 'Bife', 40, 100),
(512, 'Pollo', 30, 55),
(513, 'Queso', 10, 70),
(514, 'Tomate', 10, 30),
(515, 'Cebolla', 10, 30),
(516, 'Jugo de Naranja', 45, 60),
(517, 'Coca Cola', 80, 80),
(518, 'Limonada', 40, 40),
(519, 'Sprite', 45, 200),
(520, 'Agua Mineral', 50, 100),
(521, 'Agua Saborizada', 30, 35),
(522, 'Ensalada', 45, 50),
(523, 'Papas Fritas', 80, 70),
(524, 'Nuggets', 70, 30),
(525, 'Guacamole', 60, 40),
(526, 'Papas Noisette', 40, 50),
(527, 'Pure', 30, 60);

-- inserciones en tabla COMIDA
INSERT INTO comida (codigo, codItem, esEspecial)
VALUES
(100, 510, TRUE),
(101, 511, TRUE),
(102, 512, FALSE),
(103, 513, FALSE),
(104, 514, TRUE),
(105, 515, TRUE);

-- inserciones en tabla BEBIDA
INSERT INTO bebida (codigo, codItem, centimetrosCubicos)
VALUES
(200, 516, 150),
(201, 517, 80),
(202, 518, 70),
(203, 519, 200),
(204, 520, 100),
(205, 521, 90);

--inserciones en tabla guarnicion 

INSERT INTO guarnicion (codigo, codItem, centimetrosCubicos)
VALUES
(300, 522, 100),
(301, 523, 200),
(302, 524, 600),
(303, 525, 60 ),
(304, 526, 200),
(305, 527, 500);

-- item en menu

INSERT INTO itemenmenu (codMenu, codItem)
VALUES
(101, 510),
(106, 510),
(107, 511),
(104, 512),
(105, 512),
(108, 512),
(101, 514),
(102, 514),
(103, 514),
(104, 514),
(105, 514),
(106, 514),
(107, 514),
(108, 514),
(101, 515),
(102, 515),
(103, 515),
(104, 515),
(105, 515),
(106, 515),
(107, 515),
(108, 515),
(105, 516),
(106, 516),
(103, 517),
(102, 518),
(104, 518),
(108, 519),
(101, 520),
(107, 521),
(101, 522),
(101, 525),
(103, 526),
(104, 526),
(108, 526),
(102, 527);

-- Menu


INSERT INTO menu (codMenu, nombre)
VALUES
(101, 'Criollo'),
(102, 'Natural'),
(103, 'Basico'),
(104, 'Super'),
(105, 'Mega'),
(106, 'Americano'),
(107, 'Tropical'),
(108, 'Invernal');




COMIDA<codigo, codItem, esEspecial>
BEBIDA<codigo, codItem, centimetrosCubicos>
GUARNICION<codigo, codItem, tamaño>
ITEM<codItem, descripcion, precio, calorias>
ITEMenMENU<codMenu, codItem>
MENU<codMenu, nombre>


a) Listado de Menúes <codMenu, nombre> que tengan, o una comida especial, o una bebida que tenga
menos de 100 calorías (o ambas).

b) Listado de bebidas <codItem, cod, descripcion> que tengan la mismas calorías que centrimetrosCubicos.

c) Listado de Guarnicion 
    <codItem, codigo, descripcion> que no estén en ningún menú.

d) Listado de Menúes 
    <codMenu, nombre> 
    que tienen solamente items con precios menores a <= $45 y calorías <= 60.

a)
    SELECT
        m.*
    FROM  
        menu m 
        JOIN itemenmenu item_menu ON m.codMenu = item_menu.codMenu 
        JOIN comida comida        ON comida.codItem = item_menu.codItem 
    WHERE 
        comida.esEspecial = TRUE 
    
    UNION

    SELECT
        m.*
    FROM  
        menu m 
        JOIN itemenmenu item_menu ON m.codMenu = item_menu.codMenu 
        JOIN item i               ON i.codItem = item_menu.codItem 
        JOIN bebida b             ON b.codItem = i.codItem
    WHERE 
        i.calorias >= 100; 
    

b)
    SELECT 
        b.codItem, b.codigo, i.descripcion
    FROM 
        bebida b 
        JOIN item i ON b.codItem = i.codItem 
    WHERE 
        i.calorias = b.centimetroscubicos;
    

d)

SELECT 
    menu.codMenu, menu.nombre 
FROM 
    item item 
    JOIN itemenmenu itemenmenu ON item.codItem = itemenmenu.codItem
    JOIN menu menu             ON menu.codMenu = itemenmenu.codMenu 

WHERE 
    item.precio <= 45 AND item.calorias <= 60

EXCEPT 

SELECT 
    menu.codMenu, menu.nombre 
FROM 
    item item 
    JOIN itemenmenu itemenmenu ON item.codItem = itemenmenu.codItem
    JOIN menu menu             ON menu.codMenu = itemenmenu.codMenu 

WHERE 
    item.precio >= 45 OR item.calorias >= 60;

-- solucion V2

SELECT 
    menu.codMenu, menu.nombre 
FROM 
    item item 
    JOIN itemenmenu itemenmenu ON item.codItem = itemenmenu.codItem
    JOIN menu menu             ON menu.codMenu = itemenmenu.codMenu 

WHERE 
    item.precio NOT IN 
        (
            SELECT precio 
            FROM   item 
            WHERE 
                precio >= 45 
        )
        
        AND

    item.calorias NOT IN
        (
            SELECT calorias 
            FROM   item 
            WHERE  
                   calorias >= 45
        );



c) 
    SELECT 
        g.codigo, g.codItem, g.centimetrosCubicos
    FROM
        guarnicion g 
    
    EXCEPT

    SELECT 
        g.codigo, g.codItem, g.centimetrosCubicos
    FROM
        guarnicion g 
    
        EXCEPT 

    SELECT 
        g.codigo, g.codItem, g.centimetrosCubicos

    FROM 
        guarnicion g
        NATURAL JOIN itemenmenu itemenmenu
        NATURAL JOIN menu menu;
    