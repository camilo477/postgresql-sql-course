-- customers
-- id	full_name
-- 1	Ana
-- 2	Diego

-- wallets
-- id	name	customer_id
-- 10	Banco	1
-- 11	Efectivo	1
-- 12	Nequi	2
-- 13	Ahorros	2

-- transactions
-- id	wallet_id	description	movement_type	amount
-- 100	10	Salario	income	2000000
-- 101	10	Mercado	expense	100000
-- 102	11	Transporte	expense	50000
-- 103	12	Freelance	income	300000
-- 104	12	Pendiente	expense	NULL

-- La cuenta Ahorros (id = 13) no tiene transacciones.
-- Parte 1 — Consultas SQL
-- Pregunta 1 — COUNT y NULL
-- Escribe una única consulta sobre transactions que devuelva dos columnas:
-- - total_transactions: cantidad total de registros.
-- - transactions_with_amount: cantidad de registros con un importe no nulo.
-- Pregunta 2 — SUM y múltiples JOIN
-- Calcula el total de gastos de Ana, considerando todas sus cuentas.

-- Requisitos: utilizar customers, wallets y transactions, filtrar por customers.id = 1 y por movement_type = 'expense', y devolver el resultado como total_expenses.
-- Pregunta 3 — AVG, MIN y MAX
-- Escribe una consulta que calcule estas estadísticas de los gastos registrados en transactions:
-- - average_expense
-- - minimum_expense
-- - maximum_expense
-- Utiliza las tres funciones correspondientes en una sola consulta.
-- Pregunta 4 — COUNT con LEFT JOIN
-- Escribe una consulta que cuente las transacciones de la cuenta Ahorros (wallets.id = 13).

-- Debes utilizar LEFT JOIN para conservar la cuenta aunque no tenga movimientos.

-- Devuelve una sola columna llamada total_transactions y asegúrate de que el resultado sea cero, no uno.

-- Parte 2 — Razonamiento y debugging
-- Pregunta 5 — Resultados sin coincidencias
-- Analiza:
-- SELECT
--     COUNT(*) AS total,
--     SUM(amount) AS total_amount,
--     AVG(amount) AS average_amount
-- FROM transactions
-- WHERE wallet_id = 999;


-- No existe ninguna transacción con wallet_id = 999.

-- Explica qué valor devuelve cada una de las tres agregaciones y por qué.
-- Pregunta 6 — Debugging de JOIN
-- Un desarrollador quiere calcular la suma de los ingresos de Diego.

-- Escribe:
-- SELECT SUM(t.amount) AS total_income
-- FROM customers AS c
-- INNER JOIN wallets AS w
--     ON c.id = w.customer_id
-- INNER JOIN transactions AS t
--     ON w.id = t.id
-- WHERE c.id = 2;


-- La consulta tiene un error en la relación entre las tablas y no aplica todos los filtros necesarios.

-- Tu tarea es identificar ambos problemas, explicar por qué afectan al resultado y escribir la consulta corregida.
--1
select count(*) as total_transactions, count(amount) as transactions_with_amount
from transactions;
--2
select sum(amount) as total_expenses
from customers as c
inner join wallets as w
on w.customer_id = c.id
inner join transactions as t
on t.wallet_id = w.id
where t.movement_type = 'expense' and c.id = 1;
--3
select AVG(amount) as average_expense,
min(amount) as minimum_expense,
max(amount) as maximum_expense
from transactions
where movement_type = 'expense';
--4
SELECT COUNT(t.id) AS total_transactions
FROM wallets AS w
LEFT JOIN transactions AS t
    ON w.id = t.wallet_id
WHERE w.id = 13;
--5
devuelve total 0, total_amount no devuelve nada y average_amount tampco, no deveulven porque no existen cantidades, ya que no existe el id
--6
el problema es que t.id no se puede relacionar con w.id, en todo caso seria t.wallet_id, por otra parte falta filtrar por ingresos

SELECT SUM(t.amount) AS total_income
FROM customers AS c
INNER JOIN wallets AS w
    ON c.id = w.customer_id
INNER JOIN transactions AS t
    ON w.id = t.wallet_id
WHERE c.id = 2 and t.movement_type = 'income';