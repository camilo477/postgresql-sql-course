-- Parte 1 — SQL práctico
-- 1. GROUP BY y agregaciones

-- Escribe una consulta sobre transactions que devuelva una fila por cada movement_type, con estas columnas:
-- - movement_type
-- - total_transactions: número total de transacciones.
-- - known_amounts: número de importes no nulos.
-- - total_amount: suma de los importes.
-- 2. GROUP BY + HAVING + JOIN

-- Necesitamos conocer las cuentas cuyo total de gastos sea estrictamente superior a 120000.

-- Requisitos:
-- - Utilizar wallets y transactions.
-- - Considerar únicamente movement_type = 'expense'.
-- - Mostrar wallet_name y total_expenses.
-- - Agrupar por cuenta.
-- - Filtrar los grupos mediante HAVING.
-- - Ordenar por total_expenses DESC y después por wallets.id ASC para resolver empates.
-- 3. GROUP BY con múltiples columnas

-- Escribe una consulta que muestre el total de dinero por combinación de cuenta y tipo de movimiento.

-- Devuelve:
-- - wallet_id
-- - movement_type
-- - total_amount
-- Utiliza transactions y agrupa correctamente por dos columnas. No necesitas incluir las cuentas sin transacciones.

-- 4. LEFT JOIN + GROUP BY

-- Necesitamos mostrar todas las cuentas financieras y cuántas transacciones tiene cada una, incluyendo las que no tengan ninguna.

-- Requisitos:
-- - Mostrar wallet_name y total_transactions.
-- - Utilizar LEFT JOIN.
-- - Contar correctamente las transacciones aunque amount sea NULL.
-- - Ordenar por wallets.id ASC.
-- Parte 2 — Debugging y razonamiento
-- 5. Encuentra los errores

-- Un desarrollador quiere mostrar una fila por cuenta con su nombre y la cantidad de transacciones, incluyendo las cuentas sin movimientos.

-- Escribe:
-- SELECT
--     w.name,
--     t.movement_type,
--     COUNT(*) AS total_transactions
-- FROM wallets AS w
-- LEFT JOIN transactions AS t
--     ON w.id = t.wallet_id
-- GROUP BY w.id;


-- Responde:

-- A. ¿Qué problema tiene seleccionar t.movement_type?

-- B. ¿Por qué COUNT(*) podría producir un resultado incorrecto?

-- C. Escribe la consulta corregida.

-- 6. WHERE vs. HAVING

-- Analiza:
-- SELECT
--     movement_type,
--     COUNT(*) AS total_transactions,
--     SUM(amount) AS total_amount
-- FROM transactions
-- WHERE amount IS NOT NULL
-- GROUP BY movement_type
-- HAVING COUNT(*) >= 2;


-- Responde:

-- A. ¿Qué hace WHERE en esta consulta?

-- B. ¿Qué hace HAVING?

-- C. ¿Cuántas filas devuelve la consulta y cuáles son los valores de movement_type que aparecen?

-- D. ¿Por qué no sería correcto trasladar directamente COUNT(*) >= 2 a la cláusula WHERE?

--1
select movement_type, count(*) as total_transactions, count(amount) as known_amounts, sum(amount) as total_amount
from transactions
GROUP BY movement_type;
--2
SELECT
    w.name as wallet_name,
    SUM(t.amount) AS total_expenses
FROM transactions AS t
INNER JOIN wallets AS w
    ON w.id = t.wallet_id
WHERE t.movement_type = 'expense'
GROUP BY w.id, w.name
having sum(t.amount) > 120000
ORDER BY total_expenses desc, w.id asc;
--3
SELECT w.id as wallet_id, t.movement_type as movement_type, sum(t.amount) as total_amount
from transactions as t
inner join wallets as w
on w.id = t.wallet_id
group by w.id, t.movement_type
order by movement_type, wallet_id asc;
--4
select w.name as wallet_name, COUNT(t.id) AS total_transactions
FROM wallets AS w
LEFT JOIN transactions AS t
    ON w.id = t.wallet_id
group by w.id, w.name
ORDER BY w.id asc;
--5
a. debe usarla en group by
b. count * mostrara incluso los que no tienen movement_type
c. SELECT
    w.name AS wallet_name,
    COUNT(t.id) AS total_transactions
FROM wallets AS w
LEFT JOIN transactions AS t
    ON w.id = t.wallet_id
GROUP BY w.id
ORDER BY w.id ASC;
--6
a. where se encarga de no meter algun amount NULL
b. having solo mostrara si la agrupacion tiene 2 o mas
c. movement_type que muestra expense e income, muestra 2 filas
d. porque where filtra filas individuales, count cuenta las del grupo