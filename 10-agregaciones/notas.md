Bloque 10: Funciones de agregación

Parte 1 — ¿Qué es una función de agregación?

Una función de agregación procesa un conjunto de filas y produce un resultado resumido.

transactions
id	description	movement_type	amount
1	Salario	income	3000000
2	Freelance	income	500000
3	Mercado	expense	150000
4	Transporte	expense	20000
5	Internet	expense	90000
6	Pendiente	expense	NULL

Parte 2 — COUNT()

COUNT() sirve para contar.
SELECT COUNT(*)
FROM transactions;
Cuenta todas las filas del resultado, aunque alguna columna contenga NULL.

SELECT COUNT(amount)
FROM transactions;
Cuenta únicamente las filas donde amount no es NULL.

COUNT(DISTINCT amount)	Valores distintos no nulos de amount


Parte 3 — SUM()

SELECT SUM(amount)
FROM transactions;

Sumaría todos los importes no nulos de la tabla.

Parte 2: AVG, MIN y MAX

1. AVG — Calcular promedios

SELECT AVG(amount)
FROM lab_aggregate_transactions;
El promedio se calcula utilizando solamente los tres importes conocidos. 

2. MIN — Obtener el valor mínimo

SELECT MIN(amount)
FROM lab_aggregate_transactions;

3. MAX — Obtener el valor máximo

SELECT MAX(amount)
FROM lab_aggregate_transactions;

Bloque 10 — Parte 3: Agregaciones con JOIN

2. JOIN + COUNT

Por ejemplo, queremos contar cuántas transacciones tiene una cuenta financiera:

SELECT COUNT(t.id) AS total_transactions
FROM wallets AS w
INNER JOIN transactions AS t
    ON w.id = t.wallet_id
WHERE w.id = 10;

3. Cuidado con LEFT JOIN y COUNT(*)

SELECT
    COUNT(*) AS total_rows,
    COUNT(t.id) AS total_transactions
FROM wallets AS w
LEFT JOIN transactions AS t
    ON w.id = t.wallet_id
WHERE w.id = 12;

La cuenta Efectivo (id = 12) no tiene transacciones.

Sin embargo, como utilizamos LEFT JOIN, PostgreSQL conserva la cuenta y genera una fila con las columnas de transactions en NULL

