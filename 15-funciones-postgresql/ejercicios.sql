-- Ejercicio 1 — LOWER y UPPER
-- Escribe una consulta que recupere:
-- Columna	Requisito
-- description	Descripción original
-- lower_description	Descripción en minúsculas
-- upper_description	Descripción en mayúsculas

-- Debes resolverlo utilizando una sola sentencia SELECT.

select 
description,
lower(description) as lower_description,
upper(description) as upper_description
from lab_aggregate_transactions;

-- Ejercicio 2 — Combinar TRIM y LENGTH
-- Un usuario proporciona el siguiente nombre de cuenta:
-- "   Bancolombia   "


-- Escribe una única consulta SQL que devuelva:
-- - clean_name: nombre sin espacios iniciales ni finales.
-- - name_length: cantidad de caracteres después de eliminar los espacios.
-- No necesitas consultar ninguna tabla. Utiliza SELECT directamente con el texto proporcionado.

SELECT
    TRIM('   Bancolombia   ') AS clean_name,
    LENGTH(TRIM('   Bancolombia   ')) AS name_length;

-- Ejercicio 4 — CAST
-- Escribe una consulta sin utilizar ninguna tabla que:
-- 1. Convierta el texto '250000.75' a NUMERIC(12,2) utilizando CAST.
-- 2. Convierta el texto '42' a INTEGER utilizando ::.
-- 3. Devuelva las columnas con los alias converted_amount y converted_integer.
-- Todo en un único SELECT.

select cast('250000.75' as numeric(12,2)) as converted_amount,
'42'::INTEGER as converted_integer
;

-- Ejercicio 5 — COALESCE
-- Utiliza nuestra tabla lab_aggregate_transactions.

-- Queremos mostrar todas las transacciones con estas columnas:
-- Columna	Requisito
-- description	Descripción original
-- amount	Importe original, incluso cuando sea NULL
-- display_amount	Importe, sustituyendo NULL por 0

-- Utiliza COALESCE sin modificar los datos originales.

select description, amount, coalesce(amount, 0)
from lab_aggregate_transactions;

-- Ejercicio 6 — NULLIF y razonamiento
-- A. Escribe una consulta que convierta el valor 0 en NULL mediante NULLIF, utilizando el alias safe_divisor.

-- B. ¿Qué devuelve NULLIF(500, 0)?

-- C. ¿Cuál es la diferencia entre COALESCE y NULLIF?

-- D. Si una transacción tiene amount = NULL, ¿consideras que siempre debemos sustituirlo por cero? Justifica tu decisión desde el punto de vista financiero.

a. select nullif(0,0) as safe_divisor;
b. devuelve 500
c. coalsce trae un numero por defecto si el valor es null, nullif hace una comparacion, si ambos son iguales da NULL
d. no siempre, a veces no se requiere 0, tal ves en numeros

-- Ejercicio 7 — ROUND
-- Escribe una única consulta SQL que devuelva:
-- 1. El número 98765.678 redondeado a dos decimales, con alias rounded_amount.
-- 2. El número 150000.555 redondeado a cero decimales, con alias rounded_integer.
-- Utiliza ROUND() y convierte explícitamente los valores a NUMERIC cuando sea necesario

select round(98765.678::numeric,2) as rounded_amount,
round(150000.555::numeric) as rounded_integer
;

-- Ejercicio 8 — EXTRACT y DATE_TRUNC
-- Tenemos esta fecha y hora:
-- 2026-11-05 14:30:00


-- Escribe una única consulta que devuelva:
-- - transaction_year: año de la fecha.
-- - transaction_month: número del mes.
-- - month_start: fecha y hora truncadas al inicio del mes.
-- Utiliza EXTRACT, DATE_TRUNC y el tipo TIMESTAMP.

select
    extract(year from date '2026-11-05 14:30:00') as transaction_year,
    extract(month from date '2026-11-05 14:30:00') as transaction_month,
    DATE_TRUNC(
    'month',
    TIMESTAMP
    '2026-11-05 14:30:00') as month_start
;

9.
a. round es para redondear numeros entero o decimal mas cercano, truncar lo elimina de la parte decimal
b. porque solo extrae el mes, no el año
c. no se modifica select solo es para mostrar informacion