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
                monto  (
      SELECT 
          AVG( t2.monto ) 
      FROM
          banco b2
          JOIN cuenta c2 ON b.nombre = c2.nombre 
          JOIN transfiere t2 ON c2.numero = t2.numero_transfiere
          AND  c2.numero_sucursal         = t2.numero_sucursal_transfiere
          AND  c2.nombre                  = t2.nombre_transfiere
      WHERE 
          tipo_empresa = 'Privado'
  )
            >

-- 4 
Generar un listado de bancos que incluya cantidad de sucursales y cantidad de cuentas
por provincia de cada uno.

SELECT 
    b.nombre, 
    COUNT (s.id_sucursal) AS cantidad_de_sucursales,
    COUNT (c.numero)      AS cantidad_de_cuentas,
FROM
    banco b 
    JOIN sucursal s ON s.nombre = b.nombre
    JOIN cuenta c   ON s.nombre = c.nombre 
    AND  s.numero_sucursal = c.numero_sucursal
GROUP BY 
    b.nombre;
    
-- 5  
Devolver las cuentas inactivas que tengan transferencias superiores a la media de los
bancos de tipo "Privado" realizadas antes del 2010.

    SELECT 
        c.numero AS numero_de_cuentas 
    FROM 
        banco b 
        JOIN cuenta c     ON b.nombre = c.nombre 
        JOIN transfiere t ON c.numero = t.numero_transfiere
        AND  c.numero_sucursal = t.numero_sucursal_transfiere
        AND  c.nombre          = t.nombre_transfiere
    WHERE
        AND activa = False 
        AND monto > 
            (
                SELECT 
                    AVG( t2.monto ) 
                FROM
                    banco b2
                    JOIN cuenta c2 ON b.nombre = c2.nombre 
                    JOIN transfiere t2 ON c2.numero = t2.numero_transfiere
                    AND  c2.numero_sucursal         = t2.numero_sucursal_transfiere
                    AND  c2.nombre                  = t2.nombre_transfiere
                WHERE 
                    tipo_empresa = 'Privado'
            )
        AND 
            t.fecha_hora < '01/01/2010 00:00:00'



6) 
    Devolver todos los bancos y el año de fundación, de aquellas instituciones cuyas
    sucursales registren cuentas ACTIVAS con transferencias en dólares mayores a 2000.