-- Parte 1 — SQL práctico
-- Pregunta 1 — Subquery escalar
-- Necesitamos recuperar las transacciones de tipo expense cuyo importe sea estrictamente mayor que el promedio de todos los gastos.

-- Debes mostrar description y amount, calcular el promedio mediante una subconsulta escalar y no escribir manualmente el promedio.
-- Pregunta 2 — IN con subquery
-- Necesitamos identificar los clientes que tengan al menos una transacción de tipo income con importe mayor o igual a 200000 en cualquiera de sus cuentas.

-- Debes mostrar id y full_name de los clientes, utilizar IN con una subconsulta y no utilizar JOIN en la consulta externa. Puedes utilizarlo dentro de la subconsulta si lo necesitas.
-- Pregunta 3 — NOT EXISTS correlacionado
-- Escribe una consulta que encuentre las cuentas financieras que no tengan ninguna transacción registrada.

-- Debes mostrar id y name de las cuentas, utilizar NOT EXISTS con una subconsulta correlacionada y no utilizar JOIN.
-- Pregunta 4 — Subquery en FROM
-- Queremos obtener los clientes que tengan al menos tres transacciones, considerando todas sus cuentas.

-- Requisitos:
-- - La subconsulta en FROM debe utilizar wallets, transactions, GROUP BY y COUNT(t.id) para calcular las transacciones por cliente.
-- - Utiliza summary como alias de esa subconsulta.
-- - Desde la consulta externa, muestra customer_id y total_transactions.
-- - Filtra los clientes que tengan tres o más transacciones.
-- - Ordena por total_transactions DESC y después por customer_id ASC.
-- No utilices HAVING ni CTE.

-- Parte 2 — Debugging y razonamiento
-- Pregunta 5 — Error en subquery escalar
-- Un desarrollador quiere encontrar las cuentas que tienen al menos una transacción de tipo ingreso.

-- Escribe:
-- SELECT id, name
-- FROM wallets
-- WHERE id = (
--     SELECT wallet_id
--     FROM transactions
--     WHERE movement_type = 'income'
-- );


-- Responde:

-- A. ¿Qué problema tiene la subconsulta?

-- B. ¿Qué sucedería al ejecutar esta consulta con los datos del examen?

-- C. Corrige la consulta utilizando IN.
-- Pregunta 6 — NOT IN y NULL
-- Tenemos esta consulta:
-- SELECT w.id, w.name
-- FROM wallets AS w
-- WHERE w.id NOT IN (
--     SELECT t.wallet_id
--     FROM transactions AS t
-- );


-- Responde:

-- A. ¿Qué cuenta devuelve con los datos originales?

-- B. Supongamos que posteriormente aparece una transacción con wallet_id = NULL y que la columna permite ese valor. ¿Qué efecto tendría sobre esta consulta?

-- C. ¿Por qué NOT EXISTS puede ser una alternativa más segura para encontrar cuentas sin transacciones cuando la subconsulta puede contener valores NULL?

--1
select description, amount
from transactions
where movement_type = 'expense'
and amount >(
select AVG(amount)
from transactions
where movement_type = 'expense'
)
;
--2
select id, full_name
from customers
where id in(
    select w.customer_id
    from wallets as w
    inner join transactions as t
    on w.id = t.wallet_id
    where t.movement_type = 'income'
    AND t.amount >= 200000
);
--3
SELECT id, name
FROM wallets w
WHERE NOT EXISTS (
    SELECT 1
    FROM transactions t
    WHERE t.wallet_id = w.id
);
--4
select summary.customer_id, summary.total_transactions
from(
    select w.customer_id,
    count(t.id) as total_transactions
    from wallets as w
    inner join transactions as t
    on w.id = t.wallet_id
    GROUP BY w.customer_id
)as summary
WHERE summary.total_transactions >= 3
ORDER BY
    summary.total_transactions DESC,
    summary.customer_id ASC;
--5
a.primero que usa una subconsulta como expresion que retorna mas de un resultado
b. sale error
c. SELECT id, name
FROM wallets
WHERE id in  (
    SELECT wallet_id
    FROM transactions
    WHERE movement_type = 'income'
);
--6
a. devuelve ahorros
b. no mostraria esta transaccion tambien porque es null, devolveria 0 filas
c. porque una cosa es null y otra es si hay o no transacciones independientemente de su valor