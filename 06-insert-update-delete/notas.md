Módulo 02 — PostgreSQL y SQL

Parte 1 — ¿Qué es DML?

En el Bloque 02 aprendiste que DDL (Data Definition Language) permite definir estructuras.
CREATE TABLE categories (
    id INTEGER PRIMARY KEY,
    name TEXT
);

Ahora conoceremos DML (Data Manipulation Language), utilizado para trabajar con los registros almacenados.

Comando     Operación	Ejemplo de negocio
INSERT	Agregar registros	Registrar una nueva categoría
UPDATE	Modificar registros	Cambiar el nombre de una categoría
DELETE	Eliminar registros	Eliminar una categoría

Parte 2 — INSERT INTO

1. ¿Para qué sirve INSERT?

payment_methods
id	name	is_active
1	Efectivo	true
2	Tarjeta	true

Queremos registrar un nuevo método de pago llamado Transferencia.

Para eso utilizamos INSERT.

INSERT INTO nombre_tabla (columna1, columna2)
VALUES (valor1, valor2);

3. Insertar múltiples registros

INSERT INTO payment_methods (name, is_active)
VALUES
    ('Efectivo', TRUE),
    ('Tarjeta débito', TRUE),
    ('Tarjeta crédito', FALSE);

Parte 3 — Preparar nuestro entorno en Fedora

Bloque 06 — Parte 2: UPDATE

1. ¿Qué es UPDATE?

UPDATE es una instrucción DML que permite cambiar los valores de una o varias columnas de registros que ya existen.

Imagina que tenemos una tabla de productos:
id	name	price
1	Teclado	80000
2	Mouse	40000
3	Monitor	650000

El precio del Mouse cambió a 45000.

No necesitamos eliminarlo ni insertar otro registro. Podemos actualizarlo.
UPDATE products
SET price = 45000
WHERE id = 2;

2. Actualizar varias columnas
También podemos modificar varias columnas simultáneamente:
UPDATE products
SET name = 'Mouse inalámbrico',
    price = 55000
WHERE id = 2;

3. El peligro de UPDATE sin WHERE
Este es uno de los conceptos más importantes del bloque.

Observa:
UPDATE products
SET price = 10000;

¿Qué registros modificará PostgreSQL?

Todos.

