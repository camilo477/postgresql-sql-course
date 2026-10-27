Día 9 | Bloque 09: JOIN

Parte 1 — ¿Qué es un JOIN?

Imagina que tenemos estas dos tablas en una aplicación financiera.

customers
id	full_name
1	Carlos
2	María
3	Pedro

wallets
id	name	customer_id
10	Nequi	1
11	Bancolombia	1
12	Efectivo	2

Sabemos que wallets.customer_id es una Foreign Key que referencia a customers.id.

Necesitamos mostrar todas las cuentas financieras junto con el nombre de su propietario.

Cómo obtenemos información de ambas tablas en una misma consulta?

Mediante un JOIN.

2. INNER JOIN

INNER JOIN permite combinar filas de dos tablas cuando cumplen una condición de unión.

SELECT
    customers.full_name,
    wallets.name
FROM customers
INNER JOIN wallets
    ON customers.id = wallets.customer_id;

3. Entendiendo FROM, INNER JOIN y ON

SELECT
    customers.full_name,
    wallets.name
FROM customers
INNER JOIN wallets
    ON customers.id = wallets.customer_id;


FROM customers

Indica la tabla desde la que comenzamos la consulta.

INNER JOIN wallets

Incorpora la segunda tabla a la consulta.

ON customers.id = wallets.customer_id

Define la condición que deben cumplir las filas para combinarse.

SELECT customers.full_name, wallets.name Determina cuáles columnas aparecerán en el resultado.

Parte 2 — Alias de tablas

SELECT
    c.full_name,
    w.name
FROM customers AS c
INNER JOIN wallets AS w
    ON c.id = w.customer_id;

Aquí:
- c representa customers.
- w representa wallets.
Es la misma consulta anterior, pero más corta.

Bloque 09 — Parte 2: LEFT JOIN

1. ¿Qué sucede si un cliente no tiene cuentas?

Aquí utilizamos LEFT JOIN.

SELECT
    c.full_name,
    w.name AS wallet_name
FROM customers AS c
LEFT JOIN wallets AS w
    ON c.id = w.customer_id;

Resultado:
full_name	wallet_name
Carlos	Nequi
Carlos	Bancolombia
María	Efectivo
Pedro	NULL

3. ¿Importa el orden de las tablas?
Sí, especialmente con LEFT JOIN.

Compara:
FROM customers AS c
LEFT JOIN wallets AS w
    ON c.id = w.customer_id


Con:
FROM wallets AS w
LEFT JOIN customers AS c
    ON w.customer_id = c.id

Bloque 09 — Parte 3: RIGHT JOIN

1. ¿Qué es RIGHT JOIN?

RIGHT JOIN conserva todas las filas de la tabla situada a la derecha del JOIN, aunque no tengan coincidencias en la tabla izquierda.

SELECT
    c.full_name,
    w.name
FROM wallets AS w
RIGHT JOIN customers AS c
    ON w.customer_id = c.id;

¿Cuál conviene utilizar?
En la práctica profesional, normalmente prefiero LEFT JOIN, porque suele facilitar la lectura: comenzamos con la tabla cuyos registros queremos conservar.

Bloque 09 — Parte 4: Múltiples JOIN

1. Contexto financiero

Tenemos:

customers
id	full_name
1	Carlos
2	María
3	Pedro

wallets
id	name	customer_id
10	Nequi	1
11	Bancolombia	1
12	Efectivo	2

transactions
id	description	amount	wallet_id
100	Mercado	150000	10
101	Transporte	20000	10
102	Salario	3000000	11
103	Restaurante	60000	10

Observa algo interesante: María tiene una cuenta, pero todavía no tiene transacciones.

2. ¿Cómo funcionan los múltiples JOIN?

SELECT
    c.full_name,
    w.name AS wallet_name,
    t.description
FROM customers AS c
INNER JOIN wallets AS w
    ON c.id = w.customer_id
INNER JOIN transactions AS t
    ON w.id = t.wallet_id;

Aquí PostgreSQL combina las tablas siguiendo las relaciones:
1. customers con wallets.
2. El resultado con transactions.

Bloque 09 — Parte 5: JOIN con varias condiciones

1. Utilizar AND dentro de ON

SELECT
    w.name,
    t.description,
    t.amount
FROM wallets AS w
LEFT JOIN transactions AS t
    ON w.id = t.wallet_id
    AND t.amount > 100000;

Cuenta	Transacción	Importe
Nequi	Mercado	150000
Bancolombia	Salario	3000000
Efectivo	NULL	NULL

2. Diferencia entre ON y WHERE

SELECT
    w.name,
    t.description,
    t.amount
FROM wallets AS w
LEFT JOIN transactions AS t
    ON w.id = t.wallet_id
WHERE t.amount > 100000;

Cuenta	Transacción	Importe
Nequi	Mercado	150000
Bancolombia	Salario	3000000

¿Por qué desapareció Efectivo?

Porque el LEFT JOIN primero conserva la cuenta sin transacciones, asignando NULL a las columnas de transactions.

Después WHERE t.amount > 100000 excluye esa fila, porque comparar NULL con 100000 produce UNKNOWN.

3. JOIN utilizando dos columnas de relación

SELECT
    gp.customer_id,
    gp.goal_id,
    gc.amount
FROM goal_participants AS gp
INNER JOIN goal_contributions AS gc
    ON gp.customer_id = gc.customer_id
    AND gp.goal_id = gc.goal_id;

    