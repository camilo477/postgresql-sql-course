-- Ejercicio 1 — COUNT con GROUP BY
-- Queremos saber, para cada tipo de movimiento:
-- - Cuántas transacciones existen en total.
-- - Cuántas transacciones tienen un importe registrado.
-- Debes devolver exactamente estas columnas:
-- Columna	Descripción
-- movement_type	Tipo de movimiento
-- total_transactions	Número total de transacciones
-- known_amounts	Número de importes no nulos

-- Requisito: resuélvelo utilizando una única consulta con GROUP BY y dos funciones COUNT.
-- Ejercicio 2 — SUM y AVG por grupo
-- Necesitamos generar un reporte que muestre, para cada tipo de movimiento:
-- - El tipo de movimiento.
-- - La suma de sus importes (total_amount).
-- - El importe promedio (average_amount).
-- Debes utilizar SUM(), AVG() y GROUP BY en una sola consulta.

--1
SELECT
    movement_type,
    COUNT(*) AS total_transactions,
    count(amount) as known_amounts
FROM lab_aggregate_transactions
GROUP BY movement_type;
--2
select
    movement_type,
    sum(amount) as total_amount,
    AVG(amount) as average_amount
from lab_aggregate_transactions
group by movement_type;

Ejercicio 4 — Agrupación múltiple
Utiliza la tabla ficticia transactions con las seis filas mostradas anteriormente.

Escribe una consulta que devuelva:
- wallet_id
- movement_type
- total_amount, utilizando SUM().
Debes agrupar por cuenta y tipo de movimiento.
Ejercicio 5 — HAVING
Utiliza tu tabla real lab_aggregate_transactions de Fedora.

Escribe una consulta que muestre los tipos de movimiento cuya suma de importes sea estrictamente mayor que 300000.

Devuelve movement_type y total_amount.

Debes utilizar GROUP BY y HAVING.
Ejercicio 6 — WHERE + HAVING
Utilizando la misma tabla real:

Queremos mostrar los tipos de movimiento que:
- Tengan importes registrados, es decir, que amount no sea NULL.
- Tengan por lo menos 3 transacciones después de aplicar ese filtro.
Devuelve movement_type y total_transactions.

Debes utilizar WHERE, GROUP BY y HAVING.

--4
select wallet_id, movement_type, sum(amount) as total_amount
from transactions
group by wallet_id, movement_type;

--5
SELECT movement_type, sum(amount) as total_amount
from lab_aggregate_transactions
group by movement_type
having sum(amount)  > 300000;
--6
SELECT
movement_type, count(*) as total_transactions
from lab_aggregate_transactions
WHERE amount IS NOT NULL
group by movement_type
having count(*) >=3

-- Ejercicio final de práctica — Reporte por cliente
-- Escribe una consulta SQL que genere el reporte anterior.


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

-- Requisitos:
-- - Utilizar las tres tablas: customers, wallets y transactions.
-- - Incluir a todos los clientes, aunque no tengan cuentas o transacciones.
-- - Mostrar customer_name y total_transactions.
-- - Utilizar COUNT() y GROUP BY.
-- - Ordenar por customers.id ASC.
-- - No utilizar subconsultas ni CTE.

SELECT
    c.full_name AS customer_name,
    COUNT(t.id) AS total_transactions
FROM customers AS c
LEFT JOIN wallets AS w
    ON w.customer_id = c.id
LEFT JOIN transactions AS t
    ON t.wallet_id = w.id
GROUP BY c.id, c.full_name
ORDER BY c.id ASC;
