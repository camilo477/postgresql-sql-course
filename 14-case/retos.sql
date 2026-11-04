-- Datos del examen
-- Utilizaremos esta tabla ficticia transactions:
-- id	description	movement_type	amount
-- 1	Salario	income	2500000
-- 2	Mercado	expense	80000
-- 3	Arriendo	expense	800000
-- 4	Freelance	income	350000
-- 5	Internet	expense	100000
-- 6	Pendiente	expense	NULL
-- 7	Transporte	expense	20000
-- 8	Transferencia	transfer	200000

-- Parte 1 — SQL práctico
-- Pregunta 1 — CASE con varias condiciones
-- Necesitamos clasificar todas las transacciones según estas reglas, evaluadas en este orden:
-- Condición	Clasificación
-- Importe NULL	unknown
-- Ingreso con importe mayor o igual a 1.000.000	major_income
-- Gasto con importe mayor o igual a 500.000	major_expense
-- Cualquier otro caso	regular

-- Escribe una consulta que devuelva id, description y transaction_class, utilizando CASE.
-- Pregunta 2 — Conteo condicional
-- Necesitamos obtener una sola fila con:
-- - income_count: cantidad de transacciones de tipo income.
-- - expense_count: cantidad de transacciones de tipo expense.
-- - unknown_amounts: cantidad de transacciones cuyo importe es NULL.
-- Utiliza COUNT() con CASE para resolver los tres cálculos, sin WHERE, CTE ni subconsultas.
-- Pregunta 3 — CASE con GROUP BY
-- Queremos clasificar únicamente los gastos:
-- Condición	Categoría
-- amount IS NULL	unknown
-- amount < 100000	low
-- amount >= 100000	high

-- Escribe una consulta que devuelva:
-- - expense_level
-- - total_transactions
-- Debes utilizar CASE, COUNT, WHERE y GROUP BY.

-- Parte 2 — Debugging y razonamiento
-- Pregunta 4 — Error de orden en CASE
-- Un desarrollador escribe:
-- SELECT
--     description,
--     amount,
--     CASE
--         WHEN amount >= 100000 THEN 'medium'
--         WHEN amount >= 500000 THEN 'high'
--         ELSE 'low'
--     END AS amount_level
-- FROM transactions;


-- Responde:

-- A. ¿Qué problema lógico tiene?

-- B. ¿Qué clasificación recibiría Arriendo con esta consulta?

-- C. ¿Cómo corregirías el CASE para que los importes de al menos 500000 sean high, los de 100000 a menos de 500000 sean medium y los inferiores a 100000 sean low? Para este apartado puedes tratar los importes NULL como unknown.
-- Pregunta 5 — Interpretación de resultados
-- Analiza:
-- SELECT
--     COUNT(
--         CASE
--             WHEN movement_type = 'expense'
--                  AND amount >= 100000
--             THEN 1
--         END
--     ) AS significant_expenses
-- FROM transactions;


-- Responde:

-- A. ¿Qué valor devuelve significant_expenses?

-- B. ¿Qué transacciones está contando?

-- C. ¿Por qué no cuenta el registro con amount = NULL?
-- Pregunta 6 — Decisión técnica
-- Un compañero propone utilizar CASE para todo, incluso cuando solamente necesitamos recuperar las transacciones de tipo income.

-- Explica:

-- A. ¿Cuándo utilizarías WHERE en lugar de CASE?

-- B. ¿Cuándo aporta valor utilizar CASE dentro de SELECT?

-- C. ¿Por qué CASE no sustituye automáticamente a WHERE?

--1
select id, description,
CASE 
    WHEN amount >= 1000000 and movement_type = 'income' THEN 'major_income'
    when amount >= 500000 and movement_type = 'expense' then 'major_expense'  
    when amount is null then 'unknown'
    ELSE 'regular'
END as transaction_class
from transactions;
--2
SELECT
count(
    CASE 
        WHEN movement_type = 'income' THEN 1
    END
)as income_count,
count(
    CASE 
        WHEN movement_type = 'expense' THEN 1 
    END
)as expense_count,
COUNT(
    CASE
        WHEN amount IS NULL THEN 1
    END
    ) AS unknown_amounts
FROM transactions;


--3
select
CASE 
    WHEN amount < 100000 THEN 'low'
    when amount >= 100000 then 'high'  
    when amount is null then 'unknown'
END as expense_level,
count(*) as total_transactions

from transactions
where movement_type = 'expense'
GROUP BY expense_level;

--4
a. el primer problema es que al tener 100000 primero, todos los que se supone que
deben ser high entran a medium
tambien que los que son null quedaran como low
b. medium aunque es de 800000 entra al primer when
c. SELECT
    description,
    amount,
    CASE
        WHEN amount >= 500000 THEN 'high'
        WHEN amount >= 100000 THEN 'medium'
        when amount < 100000 then 'low'
        ELSE 'unknown'
    END AS amount_level
FROM transactions;
--5
a. devuelve 2
b. cuenta los expense mayores a 100000
c. no cuenta porque dice explicitamente que debe ser un numero mayor a 100000
--6
a. lo usaria cuando no necesito volverlo una columna, solo filtrar
b. cuando se necesita hacer comparaciones
c. porque where ya filtra, case se usa para mostrar informacion mas certera