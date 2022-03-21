*&---------------------------------------------------------------------*
*& Report ZEJERCICIO5_YBC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEJERCICIO5_YBC.

*DATA: clientes TYPE TABLE OF  ztybc_clientes,
*      cliente LIKE LINE OF clientes.
*
*SELECT * FROM ztybc_clientes INTO TABLE clientes.
*
*LOOP AT clientes INTO cliente.
*  WRITE:/ 'Sucursal: ', cliente-sucursal.
*  WRITE: '  Cliente: ', cliente-nombre_cliente.
*  ""WRITE: '  Cuenta: ', cliente-cuenta.
*  WRITE: '  Saldo: ', cliente-saldo, cliente-moneda.
*  ""WRITE: '  Divisa: ', cliente-moneda.
*  ""WRITE: '  Clave: ', cliente-clavecliente.
*  WRITE:/'------------------------------------------------------------------------------------------------'.
*ENDLOOP.


data: clientes type table of ztybc_clientes,
      cliente like line of clientes,
      total like ztybc_clientes-saldo.

"Declaramos un rango dentro de 'ids' para un campo especifico de una tabla concreta:
ranges: ids for ztybc_clientes-clavecliente.
ids-sign = 'I'. "llamamos la propiedad 'sign' (incluye o excluye sus valores) de RANGES y le asignamos la opcion 'I' (incluye)
ids-option = 'BT'. "llamamos la propiedad 'option' (Operador de comparacion) de RANGES y le asignamos la opcion 'BT' (BETWEEN)
ids-low = '01'. "llamamos la propiedad 'low' (valor "desde" del intervalo) (Operador de comparacion) de RANGES y le asignamos la opcion '1' (por donde va a empezar)
ids-high = '03'. "llamamos la propiedad 'high' (valor "hasta" del intervalo, solo si se usa BETWEEN, si no, no se usa) de RANGES y le asignamos la opcion '3' (hasta donde)

append ids.

"hacemos la seleccion dentro de la tabla utilizando RANGES predeterminado
select * from ztybc_clientes where clavecliente in @ids[]"@ids apunta a la configuracion ya hecha del rango
 into table @clientes."@clientes apunta al campo donde tiene que buscar la informacion en la tabla

"probar READ TABLE clientes ....?

"Iteramos dentro del campo la informacion que queremos imprimir por pantalla
loop at clientes into cliente.
  write:/ 'Sucursal: ', cliente-sucursal.
  write:/ 'Cliente: ', cliente-nombre_cliente.
  write:/ 'Saldo: ', cliente-saldo.
  write:/ SY-ULINE.
endloop.

"hacemos la suma de los campos 'saldo' desde el campo @clientes y la introducimos en la variable TOTAL con @total
select sum( saldo ) from ztybc_clientes as cliente into @total where clavecliente in @ids[].

"imprimimos en pantalla el resultado de la suma almacenada en @total
write:/ 'Total: ', total, ' EUR'.