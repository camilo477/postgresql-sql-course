-- Ejercicio 1 — Clasificación de gastos
-- Utiliza lab_aggregate_transactions.

-- Queremos clasificar únicamente las transacciones de tipo expense según su importe:
-- Condición	Clasificación
-- Importe NULL	unknown
-- Importe menor que 50000	small
-- Importe entre 50000 y 100000, incluidos ambos	medium
-- Importe mayor que 100000	large

-- Requisitos:
-- - Mostrar description y amount.
-- - Utilizar CASE con WHEN, THEN, ELSE y END.
-- - La columna calculada debe llamarse expense_level.
-- - Utilizar WHERE para considerar solamente gastos.
-- Tú escribes toda la consulta.

SELECT
description, amount,
CASE  
    when amount < 50000 then 'small'
    when amount >= 50000 and amount <=100000 then 'medium'
    when amount > 100000 then 'large'
    ELSE 'unknown'
END as expense_level
from lab_aggregate_transactions
where movement_type = 'expense'
;

-- Ejercicio 2 — Clasificación de movimientos
-- Necesitamos generar una columna llamada movement_label:
-- - Si movement_type = 'income', mostrar 'Ingreso'.
-- - Si movement_type = 'expense', mostrar 'Gasto'.
-- - Para cualquier otro valor, mostrar 'Otro'.
-- Requisitos:
-- - Mostrar description, movement_type y movement_label.
-- - Utilizar CASE.
-- - No utilizar WHERE, porque queremos clasificar todas las filas.

-- SELECT
-- description, movement_type,
-- CASE 
--     WHEN movement_type = 'income' THEN 'Ingreso'
--     WHEN movement_type = 'expense' THEN 'Gasto'    
--     ELSE 'Otro' 
-- END as movement_label
-- from lab_aggregate_transactions;


-- Ejercicio 4 — Reporte financiero condicional
-- Utiliza lab_aggregate_transactions.

-- Necesitamos obtener una sola fila con estas columnas:
-- Columna	Requisito
-- total_income	Suma de los ingresos
-- total_expense	Suma de los gastos
-- balance	Diferencia entre ingresos y gastos

-- Condiciones: utiliza CASE dentro de SUM(), no utilices CTE ni subconsultas y no escribas manualmente los totales.

SELECT
sum(
    CASE 
        WHEN movement_type = 'income' THEN amount  
        ELSE 0
        
    END 
)as total_income,
sum(
    case
        when movement_type = 'expense' then amount
        else 0
        
    END 
)as total_expense,
SUM(
        CASE 
            WHEN movement_type = 'income' THEN amount
            ELSE 0
        END
    )
    -
    SUM(
        CASE
            WHEN movement_type = 'expense' THEN amount
            ELSE 0
        END
    ) AS balance

FROM lab_aggregate_transactions;

-- Ejercicio 5 — Agrupación condicional
-- Queremos clasificar únicamente los gastos y contar cuántas transacciones existen en cada clasificación.
-- Condición	Clasificación
-- amount IS NULL	unknown
-- amount >= 100000	high
-- amount < 100000	low

-- Debes mostrar expense_level y total_transactions, utilizando CASE, COUNT, GROUP BY y WHERE.

SELECT
CASE 
    WHEN amount >= 100000 THEN 'high'
    when amount < 100000 then 'low' 
    ELSE 'unknown'
END as expense_level,
COUNT(*) AS total_transactions

FROM lab_aggregate_transactions
WHERE movement_type = 'expense'
GROUP BY expense_level;