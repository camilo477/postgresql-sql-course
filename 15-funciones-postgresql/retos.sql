-- Datos del examen
-- Utilizaremos nuestra tabla lab_aggregate_transactions:
-- id	description	movement_type	amount
-- 1	Salario	income	3000000
-- 2	Freelance	income	500000
-- 3	Mercado	expense	150000
-- 4	Transporte	expense	20000
-- 5	Internet	expense	90000
-- 6	Pendiente	expense	NULL


-- Parte 1 — SQL práctico
-- Pregunta 1 — Funciones de texto
-- Un usuario proporciona el siguiente nombre de una cuenta bancaria:
-- "   BANCO Principal   "


-- Escribe una única consulta, sin utilizar tablas, que devuelva:
-- - clean_name: el texto sin espacios iniciales ni finales y completamente en minúsculas.
-- - name_length: número de caracteres del texto después de limpiarlo.
-- Debes combinar LOWER(), TRIM() y LENGTH().
-- Pregunta 2 — CAST y ROUND
-- Recibimos un importe financiero desde un archivo CSV:
-- "125000.567"


-- El dato es texto y necesitamos obtener su representación numérica redondeada a dos decimales.

-- Escribe una consulta que:
-- - Convierta el texto a NUMERIC utilizando CAST.
-- - Redondee el resultado a dos decimales mediante ROUND.
-- - Utilice el alias final_amount.
-- No utilices ninguna tabla.
-- Pregunta 3 — COALESCE y agregaciones
-- Necesitamos conocer el total de gastos registrados en lab_aggregate_transactions.

-- Sin embargo, queremos garantizar que, si no existen importes para sumar, el resultado sea 0 en lugar de NULL.

-- Escribe una consulta que:
-- - Considere solamente movement_type = 'expense'.
-- - Calcule SUM(amount).
-- - Utilice COALESCE.
-- - Devuelva una columna llamada total_expenses.
-- Pregunta 4 — NULLIF y división segura
-- Tenemos una tabla ficticia llamada budgets:
-- id	budget_amount	spent_amount
-- 1	500000	150000
-- 2	0	80000
-- 3	200000	50000

-- Queremos calcular el porcentaje utilizado de cada presupuesto:
-- \[
-- \text{Porcentaje utilizado} = \frac{\text{spent\_amount}}{\text{budget\_amount}} \times 100
-- \]

-- Escribe una consulta que muestre:
-- - id
-- - used_percentage, redondeado a dos decimales.
-- Requisitos: utiliza NULLIF para evitar dividir entre cero y ROUND para el resultado. Utiliza un cálculo de tipo NUMERIC.

-- Si el presupuesto es cero, aceptamos que el porcentaje resultante sea NULL.

-- Parte 2 — Fechas y debugging
-- Pregunta 5 — EXTRACT y DATE_TRUNC
-- Tenemos esta fecha y hora:
-- 2026-10-29 17:45:30


-- Escribe una única consulta, sin utilizar tablas, que devuelva:
-- Columna	Requisito
-- transaction_year	Año
-- transaction_month	Número del mes
-- month_start	Inicio del mes, a las 00:00:00

-- Utiliza TIMESTAMP, EXTRACT() y DATE_TRUNC().
-- Pregunta 6 — Debugging SQL
-- Un desarrollador escribió esta consulta:
-- SELECT
--     TRIM(description) AS clean_description,
--     COALESCE(amount, 'Sin importe') AS display_amount,
--     ROUND(amount::TEXT, 2) AS rounded_amount
-- FROM lab_aggregate_transactions;


-- Su intención es:
-- - Mostrar la descripción sin espacios exteriores.
-- - Mostrar el importe original, utilizando 0 cuando sea NULL.
-- - Mostrar el importe redondeado a dos decimales.
-- Responde:

-- A. Identifica los dos problemas de tipos de datos que tiene la consulta.

-- B. Explica por qué PostgreSQL no puede utilizar esas expresiones tal como están escritas.

-- C. Escribe la consulta corregida, respetando los tres alias solicitados.

-- D. ¿La consulta corregida modifica permanentemente los importes NULL almacenado

--1
select 
lower(trim('   BANCO Principal   '))as clean_name,
length(lower(trim('   BANCO Principal   '))) as name_length;
--2
select round(cast('125000.567' as numeric)::numeric, 2) as final_amount;
--3
select coalesce(sum(amount), 0) as total_expenses
from lab_aggregate_transactions
where movement_type = 'expense';
--4
SELECT
    id,
    ROUND(
        (spent_amount::NUMERIC / NULLIF(budget_amount, 0)) * 100,
        2
    ) AS used_percentage
FROM budgets;
--5
SELECT
    extract(year from date '2026-10-29 17:45:30') as transaction_year,
    extract(month from date '2026-10-29 17:45:30') as transaction_month,
    DATE_TRUNC(
    'month',
    TIMESTAMP
    '2026-10-29 17:45:30') as month_start
;


--6
a. primero el coalesce debe devolvere 0 entonces seria COALESCE(amount, 'Sin importe') AS display_amount,
luego esta intentando redondear pasando a texto, debe ser numeric
b. porque debe devolver un numero el coalesce y el round usa numeric
c. SELECT
    TRIM(description) AS clean_description,
    COALESCE(amount, 0) AS display_amount,
    ROUND(amount::numeric, 2) AS rounded_amount
FROM lab_aggregate_transactions;
d. no modifica nada, solo muestra