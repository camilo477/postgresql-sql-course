-- Ejercicios — Primera práctica con CTE

-- Ejercicio 1 — CTE con ingresos
-- Utiliza lab_aggregate_transactions.

-- Necesitamos conocer el ingreso más alto y el promedio de los ingresos.

-- Requisitos:
-- 1. Define una CTE llamada income_transactions.
-- 2. Dentro de ella, selecciona únicamente las transacciones cuyo movement_type = 'income'.
-- 3. En la consulta principal, calcula MAX(amount) con el alias highest_income.
-- 4. Calcula también AVG(amount) con el alias average_income.
-- 5. No utilices subconsultas directamente dentro de FROM; utiliza WITH.
-- Tú debes escribir la sentencia SQL completa.

--1
with income_transactions as(
    select amount
    from lab_aggregate_transactions
    where movement_type = 'income'
)
select
    max(amount) as highest_income,
    avg(amount) as average_income
from income_transactions;

--2
with totals_by_type as(
    select sum(amount) as total_amount, movement_type
    from lab_aggregate_transactions
    GROUP BY movement_type

)
select movement_type, total_amount
from totals_by_type
where total_amount > 300000
ORDER BY total_amount desc;

-- Ejercicio 4 — Múltiples CTE

-- Utilizaremos lab_aggregate_transactions.

-- Objetivo: obtener las estadísticas de las transacciones con importes registrados, organizando la consulta en dos CTE.
-- Requisitos
-- Primera CTE: valid_transactions

-- Debe recuperar solamente:
-- - movement_type
-- - amount
-- Y excluir todas las transacciones cuyo amount sea NULL.

-- Segunda CTE: movement_summary

-- Debe utilizar valid_transactions para calcular:
-- - movement_type
-- - total_amount: suma de los importes.
-- - total_transactions: cantidad de transacciones.
-- Debe agrupar los registros por movement_type.

-- Consulta principal

-- Debe utilizar movement_summary y devolver las tres columnas, ordenadas por total_amount DESC.

-- No te mostraré la implementación completa: quiero que construyas tú mismo las dos CTE y la consulta principal.

with valid_transactions as(
    select amount, movement_type
    from lab_aggregate_transactions
    where amount is not null
),
movement_summary as(
    select movement_type, sum(amount) as total_amount,
    count(*) as total_transactions
    from valid_transactions
    GROUP BY movement_type
)
select movement_type,total_amount, total_transactions
from movement_summary
ORDER BY total_amount desc;