Parte 1 — ORDER BY

1. ¿Qué es ORDER BY?

Sin ORDER BY, PostgreSQL no garantiza el orden en que devuelve las filas.

Nuestra tabla de práctica
Seguiremos utilizando la tabla categories de finance_practice.
id	name	is_active	created_on
1	Alimentación	TRUE	2026-10-01
2	Transporte	TRUE	2026-10-02
3	Salario	TRUE	2026-10-03
4	Entretenimiento	FALSE	2026-10-04
5	Salud	TRUE	2026-10-05
6	Compras	FALSE	2026-10-06

2. ORDER BY ASC — Orden ascendente

SELECT id, name
FROM categories
ORDER BY id ASC;

Resultado:
id	name
1	Alimentación
2	Transporte
3	Salario
4	Entretenimiento
5	Salud
6	Compras

ASC significa ascending (ascendente).

Importante: ASC es el orden predeterminado, así que estas consultas son equivalentes:
ORDER BY id ASC
ORDER BY id

3. ORDER BY DESC — Orden descendente

SELECT id, name
FROM categories
ORDER BY id DESC;

Resultado:
id	name
6	Compras
5	Salud
4	Entretenimiento
3	Salario
2	Transporte
1	Alimentación

SELECT name, created_on
FROM categories
ORDER BY created_on DESC;

Esta consulta devuelve las categorías comenzando por la fecha de creación más reciente.

4. Combinar ORDER BY con WHERE

SELECT id, name, created_on
FROM categories
WHERE is_active = TRUE
ORDER BY created_on DESC;

Primero identificamos las filas que cumplen el filtro y después establecemos el orden del resultado.

Bloque 05 — Parte 2: ORDER BY con múltiples columnas
1. ¿Por qué necesitamos varios criterios?

Imagina que tenemos esta tabla de transacciones:

transactions
id	description	amount	created_on
1	Mercado	150000	2026-10-15
2	Transporte	20000	2026-10-16
3	Salario	3000000	2026-10-15
4	Arriendo	800000	2026-10-17
5	Restaurante	60000	2026-10-16
6	Internet	90000	2026-10-15

Queremos ordenar las transacciones por fecha, comenzando por la más reciente.

SELECT id, description, created_on
FROM transactions
ORDER BY created_on DESC;

Pero observa que algunas transacciones comparten la misma fecha.

2. Agregar un segundo criterio

SELECT id, description, created_on
FROM transactions
ORDER BY created_on DESC, id DESC;

Primer criterio: created_on DESC

Ordena por fecha, comenzando por la más reciente.

Segundo criterio: id DESC

3. ¿Los criterios deben utilizar el mismo orden?

Podemos combinar ASC y DESC:

SELECT id, description, amount
FROM transactions
ORDER BY amount DESC, id ASC;

Bloque 05 — Parte 3: LIMIT

1. ¿Qué es LIMIT?

LIMIT permite establecer el número máximo de filas que devolverá PostgreSQL.

SELECT id, description, amount
FROM transactions
LIMIT 3;

PostgreSQL devolverá como máximo tres filas.

2. Combinar LIMIT con ORDER BY

SELECT id, description, amount
FROM transactions
ORDER BY amount DESC
LIMIT 3;

3. LIMIT combinado con WHERE

SELECT id, description, amount
FROM transactions
WHERE amount > 100000
ORDER BY amount DESC
LIMIT 2;

4. ¿Qué ocurre cuando hay empates?

ORDER BY amount DESC
LIMIT 3;

El orden relativo entre esas transacciones empatadas no está garantizado.

ORDER BY amount DESC, id DESC
LIMIT 3;

Bloque 05 — Parte 4: OFFSET y paginación

1. ¿Qué es OFFSET?

OFFSET permite omitir una cantidad determinada de filas del resultado.

magina que tenemos estas transacciones, ya ordenadas desde la más reciente hasta la más antigua, resolviendo empates por ID descendente:
id	description	created_on
4	Arriendo	2026-10-17
5	Restaurante	2026-10-16
2	Transporte	2026-10-16
6	Internet	2026-10-15
3	Salario	2026-10-15
1	Mercado	2026-10-15
Supongamos que queremos omitir los primeros dos registros.
SELECT id, description, created_on
FROM transactions
ORDER BY created_on DESC, id DESC
OFFSET 2;


El resultado comenzaría desde la tercera fila.

2. Combinar LIMIT y OFFSET

imagina que queremos mostrar dos transacciones por página.
Página 1
SELECT id, description, created_on
FROM transactions
ORDER BY created_on DESC, id DESC
LIMIT 2 OFFSET 0;


Resultado:
id	description
4	Arriendo
5	Restaurante
Página 2
SELECT id, description, created_on
FROM transactions
ORDER BY created_on DESC, id DESC
LIMIT 2 OFFSET 2;


Resultado:
id	description
2	Transporte
6	Internet

3. Fórmula de paginación


OFFSET = (página - 1) * tamaño_página

Página	LIMIT	OFFSET
1	5	0
2	5	5
3	5	10
4	5	15

