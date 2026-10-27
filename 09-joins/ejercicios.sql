-- Ejercicio 2 — Escribe tus primeras consultas JOIN
-- Vamos a trabajar con las mismas tablas.

-- Consulta 1. Recupera el identificador de cada cuenta, el nombre de la cuenta y el nombre de su propietario.

-- El resultado deberá tener estas columnas:
-- wallet_id	wallet_name	customer_name
-- 10	Nequi	Carlos
-- 11	Bancolombia	Carlos
-- 12	Efectivo	María

-- Debes utilizar INNER JOIN y alias de tablas y columnas. No necesitas preocuparte todavía por el orden de las filas.

-- Consulta 2. Recupera únicamente los nombres de las cuentas pertenecientes al cliente cuyo identificador es 1.

-- Debes combinar INNER JOIN con WHERE.

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

SELECT 
    wallets.id AS wallet_id, 
    wallets.name AS wallet_name, 
    customers.full_name AS customer_name
FROM wallets
INNER JOIN customers 
    ON wallets.customer_id = customers.id;

select
    wallets.name AS wallet_name,
    customers.full_name as customer_name
from wallets
inner join customers
    on wallets.customer_id = customers.id
where customers.id = 1;

-- Ejercicio 3 — Escribe SQL
-- 1. Recupera el identificador y nombre de todos los clientes, junto con el nombre de sus cuentas financieras.

-- Requisitos:
-- - Utilizar LEFT JOIN.
-- - Utilizar alias de tablas.
-- - Mostrar customer_id, customer_name y wallet_name.
-- - Incluir a los clientes que no tienen cuentas.
-- 2. Recupera únicamente los clientes que no tienen ninguna cuenta financiera.

-- Requisitos:
-- - Mostrar id y full_name de los clientes.
-- - Utilizar LEFT JOIN.
-- - Combinarlo con WHERE e IS NULL.

SELECT
    c.id AS customer_id,
    c.full_name AS customer_name,
    w.name AS wallet_name
FROM customers AS c
LEFT JOIN wallets AS w
    ON w.customer_id = c.id;

SELECT
    c.id AS customer_id,
    c.full_name AS customer_name,
    w.name AS wallet_name
FROM customers AS c
LEFT JOIN wallets AS w
    ON w.customer_id = c.id
WHERE w.id IS NULL;

-- 1. SQL práctico: escribe una consulta con RIGHT JOIN 
que muestre todos los clientes y el nombre de sus cuentas,
 incluyendo a Pedro. Debes comenzar con FROM wallets AS w y
  mostrar customer_name y wallet_name

SELECT
    c.full_name AS customer_name,
    w.name AS wallet_name
FROM wallets as w
RIGHT join customers as c
on w.customer_id = c.id;

-- Ejercicio 7 — SQL

-- Utiliza las tablas wallets y transactions del ejemplo anterior.

-- 1. Escribe una consulta que muestre todas las cuentas y únicamente sus transacciones cuyo importe sea mayor o igual a 50000.

-- Requisitos:
-- - Mostrar wallet_name, transaction_description y amount.
-- - Utilizar LEFT JOIN.
-- - Aplicar la condición monetaria dentro de ON.
-- - Conservar las cuentas que no tengan transacciones que cumplan el importe.

SELECT 
    w.name as wallet_name, t.description as transaction_description,
    t.amount as amount
from wallets as w
left join transactions as t
    on w.id = t.wallet_id
    and t.amount >= 50000;