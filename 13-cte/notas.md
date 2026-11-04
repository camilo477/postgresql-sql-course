Parte 1 — ¿Qué es una CTE?

CTE significa Common Table Expression, o expresión de tabla común.

Es una forma de definir un resultado con nombre que podemos utilizar dentro de una sentencia SQL.

WITH

WITH nombre_cte AS (
    SELECT ...
    FROM ...
)
SELECT ...
FROM nombre_cte;

2. Ejemplo financiero
Vamos a utilizar nuestra tabla lab_aggregate_transactions de Fedora.
id	description	movement_type	amount
1	Salario	income	3000000
2	Freelance	income	500000
3	Mercado	expense	150000
4	Transporte	expense	20000
5	Internet	expense	90000
6	Pendiente	expense	NULL

Queremos obtener:
La cantidad de gastos con importe registrado y la suma total de esos gastos.

Primera etapa: seleccionar los gastos válidos

SELECT amount
FROM lab_aggregate_transactions
WHERE movement_type = 'expense'
  AND amount IS NOT NULL;

Esta consulta devuelve tres importes: 150000, 20000 y 90000.

Segunda etapa: utilizar una CTE

WITH valid_expenses AS (
    SELECT amount
    FROM lab_aggregate_transactions
    WHERE movement_type = 'expense'
      AND amount IS NOT NULL
)
SELECT
    COUNT(*) AS total_expenses,
    SUM(amount) AS total_amount
FROM valid_expenses;

Resultado:
total_expenses	total_amount
3	260000

Parte 2 — CTE vs. Subquery en FROM

SELECT summary.movement_type, summary.total_amount
FROM (
    SELECT
        movement_type,
        SUM(amount) AS total_amount
    FROM lab_aggregate_transactions
    GROUP BY movement_type
) AS summary;

Una CTE permite organizar ese mismo cálculo con otra estructura:

WITH summary AS (
    SELECT
        movement_type,
        SUM(amount) AS total_amount
    FROM lab_aggregate_transactions
    GROUP BY movement_type
)
SELECT
    summary.movement_type,
    summary.total_amount
FROM summary;

Bloque 13 — Parte 2: Múltiples CTE

Podemos declarar varias CTE utilizando WITH y separándolas con comas.


WITH expenses AS (
    SELECT amount
    FROM lab_aggregate_transactions
    WHERE movement_type = 'expense'
),
expense_summary AS (
    SELECT
        COUNT(*) AS total_expenses,
        SUM(amount) AS total_amount
    FROM expenses
)
SELECT *
FROM expense_summary;