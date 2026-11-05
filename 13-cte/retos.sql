-- Utilizaremos nuestra tabla de laboratorio:

-- lab_aggregate_transactions
-- id	description	movement_type	amount
-- 1	Salario	income	3000000
-- 2	Freelance	income	500000
-- 3	Mercado	expense	150000
-- 4	Transporte	expense	20000
-- 5	Internet	expense	90000
-- 6	Pendiente	expense	NULL

-- Parte 1 — SQL práctico
-- Pregunta 1 — CTE con AVG

-- Encuentra los gastos cuyo importe sea superior al promedio de los gastos registrados.

-- Debes definir una CTE llamada expense_average que calcule el promedio. La consulta principal debe mostrar description y amount de los gastos que superen dicho promedio.

-- Pregunta 2 — Múltiples CTE

-- Construye un reporte utilizando dos CTE:
-- - valid_transactions: selecciona movement_type y amount, excluyendo importes NULL.
-- - type_summary: utiliza la primera CTE para calcular SUM(amount) como total_amount y COUNT(*) como total_transactions, agrupando por tipo.
-- La consulta principal debe mostrar únicamente los grupos cuyo total sea mayor que 250000, ordenados por total_amount DESC.

-- Pregunta 3 — Reutilización de CTE

-- Define una CTE llamada totals_by_type que calcule la suma de importes por movement_type.

-- Utilizando esa misma CTE, escribe una consulta principal que devuelva una sola fila con:
-- - total_income: suma de los ingresos.
-- - total_expense: suma de los gastos.
-- No debes volver a consultar directamente lab_aggregate_transactions fuera de la CTE.
-- Parte 2 — Debugging y razonamiento
-- Pregunta 4 — Detectar errores

-- Un desarrollador escribió:
-- WITH summary AS (
--     SELECT
--         movement_type,
--         SUM(amount) AS total_amount
--     FROM lab_aggregate_transactions
--     GROUP BY movement_type
-- )
-- SELECT movement_type, total_amount
-- FROM summary
-- WHERE SUM(amount) > 100000;


-- Explica por qué falla y escribe la consulta corregida, utilizando el resultado calculado por la CTE.

-- Pregunta 5 — Interpretación de resultados

-- Analiza:
-- WITH expenses AS (
--     SELECT amount
--     FROM lab_aggregate_transactions
--     WHERE movement_type = 'expense'
-- )
-- SELECT
--     COUNT(*) AS total_records,
--     COUNT(amount) AS known_amounts,
--     SUM(amount) AS total_expenses
-- FROM expenses;


-- ¿Qué valores devolverán las tres columnas? Explica brevemente la diferencia entre los dos COUNT.

-- Pregunta 6 — Decisión profesional

-- Un compañero propone utilizar una CTE para cada consulta SQL del proyecto, incluso para:
-- SELECT COUNT(*)
-- FROM lab_aggregate_transactions;


-- ¿Estás de acuerdo? Justifica cuándo utilizarías una CTE, cuándo preferirías una consulta sencilla y si una CTE garantiza automáticamente mejor rendimiento.

--1
with expense_average as(
    select AVG(amount) as avg_amount
    from lab_aggregate_transactions
    where movement_type = 'expense'
)
select description, amount
from lab_aggregate_transactions
where movement_type = 'expense'
and amount > (
    SELECT avg_amount
    FROM expense_average
);
--2
with valid_transactions as(
    select movement_type, amount
    from lab_aggregate_transactions
    where amount is not null
),
type_summary as(
    select sum(amount) as total_amount, count(*) as total_transactions, movement_type
    from valid_transactions
    GROUP BY movement_type
)
select total_amount, total_transactions, movement_type
from type_summary
where total_amount > 250000
ORDER BY total_amount desc;
--3
with totals_by_type as(
    select sum(amount) as total_amount, movement_type
    from lab_aggregate_transactions
    group by movement_type
)
SELECT
    (
        SELECT total_amount
        FROM totals_by_type
        WHERE movement_type = 'income'
    ) AS total_income,

    (
        SELECT total_amount
        FROM totals_by_type
        WHERE movement_type = 'expense'
    ) AS total_expense;

--4
el problema es que summary no entrega amount asi que no se puede hacer la comparacion
WITH summary AS (
    SELECT
        movement_type,
        SUM(amount) AS total_amount
    FROM lab_aggregate_transactions
    GROUP BY movement_type
)
SELECT movement_type, total_amount
FROM summary
WHERE total_amount > 100000;
--5
devuelve total_records 4, known amount 3 y total_expenses 260000
el primer count es la cantidad de expenses, el segundo cuanta solo los que tienen un valor
--6
no para todas, si sirve para mejorar el entendimiento de las consultas pero para las sencillas no hace falta, se sobreentiende facil
