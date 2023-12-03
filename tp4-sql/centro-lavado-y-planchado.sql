1. Consultas DML

empleado <
          apodo: VARCHAR(30) PK,
          edad: INT, 
          telefono: VARCHAR(30)    
         >
lavarropas <    codlavarropas: INT PK, 
                marca: VARCHAR(20),
                origen: CHAR(3), 
                val_defecto: ARG, 
                capacidad: INT,
                id_sucursal: VARCHAR(40) FK 
            >
plancha     <
                cod_plancha: INT PK, 
                fabricante: VARCHAR(20),
                id_sucursal: VARCHAR(40) FK
            >
turno <
        fecha: DATETIME PK, 
        plancha_id: INT PK FK,
        apodo: VARCHAR(30) PK FK, 
        horas: INT
    >
sucursal 
        < 
            id_sucursal: VARCHAR(40) PK, 
            barrio: VARCHAR(50)
        >


(a) Obtener todos los (cod_plancha, fabricante) de las planchas instaladas en sucursales
que no tengan lavarropas ESPañoles.


    SELECT 
        p.codplancha, p.fabricante 
    FROM 
        plancha p 
        JOIN lavarropas l ON p.idsucursal = l.idsucursal 
    WHERE l.origen <> 'ESP'    
        
        EXCEPT

    SELECT 
        p2.codplancha, p2.fabricante 
    FROM 
        plancha p2 
        JOIN lavarropas l2 ON p2.idsucursal = l2.idsucursal 
    WHERE l2.origen = 'ESP';
        


(b) Obtener todos los (cod_lavarropas, marca) de los lavarropas fabricados en BRA o que
en la sucursal donde está instalado trabaje el empleado “johnny”

    SELECT l.codlavarropas,l.marca 
    FROM 
        lavarropas l
    WHERE l.origen = 'BRA'
    
        UNION
    
    SELECT l1.codlavarropas,l1.marca
    FROM
         turno t 
         JOIN plancha p ON p.codplancha = t.plancha_id
         JOIN lavarropas l1 ON t=.idsucursal = l1.idsucursal
    WHERE 
        t.apodo = 'Johnny';
            




(c) Obtener la (id_sucursal, cantidad) de lavarropas por sucursal.

    SELECT l.idsucursal, COUNT(l.idsucursal) AS cantidad
    FROM lavarropas l
    GROUP BY l.idsucursal;

    SELECT l.marca, COUNT(l.marca) AS cantidad_de_marcas_de_origen
    FROM lavarropas l
    GROUP BY l.marca;
    


(d) Obtener el promedio de horas trabajadas por empleado, de aquellos empleados que
trabajan en sucursales que tienen lavarropas con capacidad de más de 20 kg y cuyo
promedio de horas trabajadas sea mayor a 5.

    SELECT 
        t.apodo ,AVG(t.horas) AS horas_trabajas_por_empleado
    FROM 
        turno t 
        JOIN plancha p    ON p.cod_plancha = t.plancha_id 
        JOIN lavarropas l ON p.idsucursal = l.idsucursal 
    WHERE 
        l.capacidad > 20
    GROUP BY t.apodo 
    HAVING AVG(t.horas) > 5; 

        
(e) Obtener los empleados que trabajaron solamente con planchas del fabricante “Atma”.

    SELECT 
        t.apodo
    FROM 
        turno t
        JOIN plancha p ON p.cod_plancha = t.plancha_id 
        WHERE 
            p.fabricante <> 'Atma';
        EXCEPT
    SELECT 
        t.apodo
    FROM 
        turno t
        JOIN plancha p ON p.cod_plancha = t.plancha_id 
        WHERE 
            p.fabricante = 'Atma';    


