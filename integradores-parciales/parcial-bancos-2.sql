ACCIONISTA<CUIT(PK), nyAp, cobrados, fecha_ingreso, domicilio_calle, domicilio_nro, domicilio_loc, domicilio_provincia >

INVIERTE<nombre(PK, FK), CUIT(PK,FK)>

BANCO<nombre(PK), tipo_empresa, fundado>

SUCURSAL<numero_sucursal(PK), nombre(PK,FK), domicilio, localidad, provincia>

CUENTA <numero(PK), numero_sucursal(PK, FK), nombre(PK, FK), moneda, saldo, activa>

TRANSFIERE  < 
                numero_transfiere(PK, FK), 
                numero_sucursal_transfiere(PK, FK),
                nombre_transfiere(PK, FK),
                numero_recibe(PK, FK),
                numero_sucursal_recibe(PK, FK),
                nombre_recibe(PK, FK), 
                fecha_hora(PK), 
                monto
            >




1.  Devolver los accionistas que ingresaron en el año 2009 que no sean de la provincia de San Juan pero que hayan
    invertido en un banco de la provincia de San Luis.

    
SELECT 
    a.cuit AS cuit_de_accionistas
FROM 
    accionistas a 
    JOIN invierte i  ON a.cuit = i.cuit 
    JOIN banco b     ON i.nombre = b.nombre 
    JOIN sucursal s  ON s.nombre = b.nombre 
WHERE 
    s.localidad = 'San Luis' 
        AND (a.fecha_ingreso >= '01/01/2009' AND fecha_ingreso <= '31/12/2009')
        a.domicilio_loc NOT IN (SELECT a.domicilio_loc FROM accionistas a WHERE a.domicilio_loc ILIKE 'san juan');


2. Devolver las cuentas de las transferencias recibidas por las sucursales de los bancos privados de la localidad de “Junín”
y las cuentas que solamente tengan transferencias a la localidad de “Trenque Lauquen”.

SELECT 
    c.numero AS numero_de_cuentas
FROM 
    banco b 
    JOIN sucursal s ON s.nombre = b.nombre 
    JOIN cuenta c   ON c.numero_sucursal = s.numero_sucursal
    AND  c.nombre = s.nombre 
    JOIN transfiere t ON c.numero = t.numero_recibe
    AND  c.numero_sucursal = t.numero_sucursal_recibe
    AND  c.nombre          = t.nombre_recibe
WHERE
    b.tipo_empresa ILIKE '%privado%' AND s.localidad ILIKE '%junin%'

UNION

SELECT 
    c.numero AS numero_de_cuentas
FROM 
    banco b 
    JOIN sucursal s ON s.nombre = b.nombre 
    JOIN cuenta c   ON c.numero_sucursal = s.numero_sucursal
    AND  c.nombre = s.nombre 
    JOIN transfiere t ON c.numero = t.numero_recibe
    AND  c.numero_sucursal = t.numero_sucursal_recibe
    AND  c.nombre          = t.nombre_recibe
WHERE 
    s.localidad NOT IN (SELECT s.localidad FROM sucursal s WHERE s.localidad <> 'Trenque Lauquen');

-- otra solucion 2 (la misma pero con una resta al final)
SELECT 
    c.numero AS numero_de_cuentas
FROM 
    banco b 
    JOIN sucursal s ON s.nombre = b.nombre 
    JOIN cuenta c   ON c.numero_sucursal = s.numero_sucursal
    AND  c.nombre = s.nombre 
    JOIN transfiere t ON c.numero = t.numero_recibe
    AND  c.numero_sucursal = t.numero_sucursal_recibe
    AND  c.nombre          = t.nombre_recibe
WHERE
    b.tipo_empresa ILIKE '%privado%' AND s.localidad ILIKE '%junin%'

UNION

SELECT 
    c.numero AS numero_de_cuentas
FROM 
    banco b 
    JOIN sucursal s ON s.nombre = b.nombre 
    JOIN cuenta c   ON c.numero_sucursal = s.numero_sucursal
    AND  c.nombre = s.nombre 
    JOIN transfiere t ON c.numero = t.numero_recibe
    AND  c.numero_sucursal = t.numero_sucursal_recibe
    AND  c.nombre          = t.nombre_recibe
WHERE 
    s.localidad IN (
    
        SELECT s.localidad FROM sucursal s WHERE s.localidad ILIKE '%trenque lauquen%'
            EXCEPT
        SELECT s.localidad FROM sucursal s WHERE s.localidad ILIKE '%trenque lauquen%'
    
    )


3. Obtener el monto total de transferencias para cada banco y 
tipo de que pertenezcan a la región de Cuyo (Cuyo está
formado por Mendoza, San Juan y San Luis).

SELECT DISTINCT 
    b.nombre, b.tipo_empresa, SUM (t.monto) 
FROM 
    banco b 
    JOIN cuenta c     ON b.nombre = c.nombre 
    JOIN sucursal s   ON c.nombre = s.nombre
    JOIN transfiere t ON c.numero = t.numero_transfiere
    AND  c.numero_sucursal = t.numero_sucursal_transfiere
    AND  c.nombre          = t.nombre_transfiere
    
WHERE provincia IN ('Mendoza', 'San Juan', 'San Luis')
GROUP BY b.nombre, b.tipo_empresa 



4. Obtener el listado de bancos con la sumatoria de transacciones emitidas, 
las recibidas y las diferencias ordenadas de menor a mayor

SELECT 
    b.nombre, 
    SUM (transferencias_recibidas.monto)  AS transferencias_recibidas, 
    SUM (transferencias_egresadas.monto)  AS transferencias_egresadas,
    ( SUM (transferencias_recibidas.monto) - SUM (transferencias_egresadas.monto) ) AS diferencia_recibidas_y_egresadas
FROM
    (SELECT banco b FROM 
    cuenta c 
    JOIN  sucursal s ON b.nombre = c.nombre 
    JOIN    ON c.nombre = s.nombre
    JOIN transfiere t ON c.numero = t.numero_transfiere
    AND  c.numero_sucursal = t.numero_sucursal_transfiere
    AND  c.nombre          = t.nombre_transfiere ) AS transferencias_egresadas 
    
        JOIN
    
    (banco b2 
    JOIN cuenta c2     ON b2.nombre = c.nombre 
    JOIN sucursal s2   ON c2.nombre = s.nombre
    JOIN transfiere t2 ON c2.numero = t.numero_transfiere
    AND  c2.numero_sucursal = t2.numero_sucursal_transfiere
    AND  c2.nombre          = t2.nombre_transfiere) AS transferencias_recibidas
    
    ON transferencias_egresadas.nombre = transferencias_recibidas.nombre

ORDER BY diferencia_recibidas_y_egresadas ASC; 
    
-- solucion mateo 
SELECT
    b.nombre,
    te.monto_total,
    tr.monto_total,
    ABS(te.monto_total - tr.monto_total) AS diferencia
FROM
    banco b
JOIN
    (SELECT nombre_transfiere, SUM(monto) AS monto_total FROM transfiere GROUP BY nombre_transfiere) te
ON 
    b.nombre = te.nombre_transfiere
JOIN
    (SELECT nombre_recibe, SUM(monto) AS monto_total FROM transfiere GROUP BY nombre_recibe) tr
ON 
    b.nombre = tr.nombre_recibe
GROUP BY 
    b.nombre
ORDER BY 
    diferencia ASC;

---


5. Devolver los 5 bancos que tienen más de 10 sucursales 
    con transferencias solamente en moneda "Euro" entre 01/01/2023    
    y 09/12/2023.

SELECT 
    b.nombre
FROM 
    banco b 
    JOIN cuenta c ON c.nombre = b.nombre 
    JOIN transferencia t ON c.numero = t.numero_transfiere
    AND  c.numero_sucursal = t.numero_sucursal_transfiere
    AND  c.nombre          = t.nombre_transfiere
WHERE 
    (
        fecha_hora >= '01/01/2023 00:00:00' 
            AND
        fecha_hora <= '09/12/2023 00:00:00'
    )     
    c.moneda NOT IN (SELECT c.moneda FROM cuenta c WHERE moneda <> 'Euro')
GROUP BY b.nombre 
HAVING COUNT (SELECT s.numero_sucursal FROM banco b JOIN  sucursal s ON s.nombre = b.nombre ) > 7;
    
    
    