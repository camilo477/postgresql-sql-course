-- Datos del examen
-- customers
-- id	full_name
-- 1	Carlos
-- 2	María
-- 3	Pedro

-- wallets
-- id	name	customer_id
-- 10	Nequi	1
-- 11	Bancolombia	1
-- 12	Efectivo	2

-- transactions
-- id	description	amount	wallet_id
-- 100	Mercado	150000	10
-- 101	Transporte	20000	10
-- 102	Salario	3000000	11
-- 103	Restaurante	60000	10

-- Parte 1 — SQL práctico (4 puntos)
-- Pregunta 1 — INNER JOIN

-- Recupera el nombre de cada cuenta y el nombre de su propietario.

-- Requisitos:
-- - Utilizar INNER JOIN.
-- - Mostrar wallet_name y customer_name.
-- - Mostrar únicamente las cuentas de María.
-- Pregunta 2 — LEFT JOIN + IS NULL

-- Necesitamos encontrar los clientes que todavía no tienen cuentas financieras.

-- Requisitos:
-- - Mostrar customer_id y customer_name.
-- - Utilizar LEFT JOIN.
-- - Utilizar WHERE e IS NULL.
-- - No mostrar columnas innecesarias.
-- Pregunta 3 — Múltiples JOIN

-- Necesitamos consultar las transacciones cuyo importe sea mayor o igual a 60000.

-- Requisitos:
-- - Mostrar customer_name, wallet_name, transaction_description y amount.
-- - Utilizar dos INNER JOIN.
-- - Ordenar por importe descendente.
-- - Resolver empates mediante el identificador de la transacción descendente.
-- Pregunta 4 — JOIN con varias condiciones

-- Necesitamos mostrar todas las cuentas financieras y únicamente sus transacciones cuyo importe sea estrictamente mayor que 100000.

-- Requisitos:
-- - Utilizar LEFT JOIN.
-- - Conservar también las cuentas sin transacciones que cumplan el importe.
-- - Mostrar wallet_name, transaction_description y amount.
-- - Colocar correctamente el filtro de importe.

-- Parte 2 — Razonamiento y debugging (2 puntos)
-- Pregunta 5 — RIGHT JOIN

-- Analiza esta consulta:
-- SELECT
--     c.full_name,
--     w.name
-- FROM customers AS c
-- RIGHT JOIN wallets AS w
--     ON c.id = w.customer_id;


-- Responde:

-- A. ¿Cuántas filas devuelve?

-- B. ¿Aparece Pedro? ¿Por qué?

-- C. Si necesitamos mostrar todos los clientes, incluyendo a Pedro, ¿cómo cambiarías el JOIN sin modificar el orden de las tablas?

-- Pregunta 6 — Debugging de JOIN

-- Tenemos estas dos tablas:
-- goal_participants
-- -----------------
-- customer_id
-- goal_id

-- goal_contributions
-- ------------------
-- customer_id
-- goal_id
-- amount


-- Un desarrollador escribe:
-- SELECT
--     gp.customer_id,
--     gp.goal_id,
--     gc.amount
-- FROM goal_participants AS gp
-- INNER JOIN goal_contributions AS gc
--     ON gp.customer_id = gc.customer_id;


-- El requisito es obtener únicamente los aportes que correspondan al mismo cliente y a la misma meta.

-- Responde:

-- A. ¿Qué problema tiene la consulta?

-- B. ¿Qué resultados incorrectos podría producir?

-- C. Escribe la consulta corregida.

--1
select w.name as wallet_name, c.full_name as customer_name
from customers as c
inner join wallets as w
on w.customer_id = c.id
and c.full_name = 'María';

--2
select c.id as customer_id, c.full_name as customer_name
from customers as c
left join wallets as w
on w.customer_id = c.id
where customer_id is null;

--3
SELECT
c.full_name as customer_name, w.name as wallet_name,
t.description as transaction_description, t.amount as amount
from customers as c
inner join wallets as w
on w.customer_id = c.id
inner join transactions as t
on t.wallet_id = w.id
where amount >=60000
order by amount desc, t.id desc
;

--4
SELECT
w.name as wallet_name, t.description as transaction_description,
t.amount as amount
from wallets as w
left join transactions as t
on t.wallet_id = w.id
and amount > 100000;