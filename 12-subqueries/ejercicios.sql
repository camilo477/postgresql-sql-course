-- Ejercicio 1 — SQL práctico
-- Queremos encontrar:

-- Todas las transacciones de tipo expense cuyo importe sea estrictamente superior al promedio de los gastos registrados.

-- Requisitos:
-- - Mostrar description y amount.
-- - Utilizar una subquery en WHERE.
-- - Calcular el promedio mediante AVG().
-- - Considerar únicamente los gastos tanto para el promedio como para los resultados.
-- - No escribir manualmente el valor del promedio.
-- Tú debes escribir la consulta completa.

select description, amount
from lab_aggregate_transactions
where movement_type = 'expense' and amount >(
select avg(amount)
from lab_aggregate_transactions
where movement_type = 'expense')
;

-- wallets
-- id	name
-- 10	Nequi
-- 11	Bancolombia
-- 12	Efectivo

-- transactions
-- id	wallet_id	description	amount
-- 100	10	Mercado	150000
-- 101	10	Transporte	20000
-- 102	11	Salario	3000000
-- 103	10	Restaurante	60000

-- Ejercicio 4 — IN con subquery
-- Escribe una consulta que recupere:
-- - id y name de las cuentas financieras.
-- - Solamente las cuentas que tengan alguna transacción con un importe estrictamente mayor que 100000.
-- - Utiliza obligatoriamente una subconsulta con IN.
-- - No utilices JOIN.
-- Ejercicio 5 — NOT EXISTS
-- Encuentra las cuentas financieras que no tienen ninguna transacción registrada.

-- Requisitos:
-- - Mostrar id y name.
-- - Utilizar una subconsulta correlacionada.
-- - Utilizar NOT EXISTS.
-- - No utilizar JOIN.

--4
select id, name
from wallets
where id IN(
    SELECT wallet_id
    from transactions
    where amount > 100000
);


--5
select w.id, w.name
from wallets as w
where not exists(
    SELECT wallet_id
    from transactions
    where wallet_id = w.id
);

-- Ejercicio 7 — Subquery en FROM
-- Escribe una consulta que:
-- 1. Calcule el total de importes por wallet_id dentro de una subquery en FROM.
-- 2. Utilice el alias summary para la subquery.
-- 3. Desde la consulta externa, devuelva wallet_id y total_amount.
-- 4. Muestre solamente las cuentas cuyo total sea estrictamente mayor que 200000.
-- 5. Ordene los resultados por total_amount DESC.
-- No utilices HAVING ni CTE. El objetivo es practicar la subconsulta en FROM.

select summary.wallet_id, summary.total_amount
from (
    select wallet_id, sum(amount) as total_amount
    from transactions
    group by wallet_id
    ORDER BY total_amount desc
)as summary
where summary.total_amount > 200000;