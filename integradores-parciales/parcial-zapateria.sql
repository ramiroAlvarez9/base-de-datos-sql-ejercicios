ZAPATERIA < id_zap(PK), razon_social, ciudad, fecha_fundación, cant_empleados, tiene_promos >

CALZADO < marca(PK), modelo(PK), fecha_lanzamiento, precio, descripción >

CLIENTE < id_cli(PK), nyap, ciudad, fecha_registro >

COMPRA < marca(PK, FK), modelo(PK, FK), id_cli(PK, FK), fecha_compra(PK), precio_compra, forma_pago >

ARREGLO < id_zap(PK, FK), marca(PK, FK), modelo(PK, FK), id_cli(PK, FK), fecha_compra(PK, FK), fecha_arreglo(PK),
precio, descripción >

1) 
