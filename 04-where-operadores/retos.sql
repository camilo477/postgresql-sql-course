-- Mini reto acumulativo
-- Ya terminamos la teoría de este bloque. Ahora quiero comprobar que puedes combinar todos los operadores sin ayuda.
-- Contexto: cuentas financieras
-- Tenemos esta tabla ficticia accounts:

-- Los siguientes datos son para el ejercicio; no necesitas crear esta tabla en Fedora.
-- id	name	balance	is_active	description
-- 1	Nequi	500000	true	Principal
-- 2	Bancolombia	1200000	true	NULL
-- 3	Efectivo	150000	false	Ahorros
-- 4	Davivienda	800000	false	NULL
-- 5	Nu	300000	true	NULL
-- 6	Nequi Ahorro	700000	NULL	Secundaria
-- También tenemos una columna created_on con las fechas del 1 al 6 de octubre de 2026, respectivamente.
-- Parte A — Escribe las consultas
-- No te daré pistas. Debes interpretar cada requisito y construir las condiciones.
-- 1. Recupera id y name de las cuentas activas cuyo saldo esté entre 500000 y 1000000, incluyendo ambos valores. Utiliza BETWEEN.
-- 2. Recupera id y name de las cuentas que no tengan descripción o estén inactivas.
-- 3. Recupera el nombre y saldo de las cuentas cuyo nombre empiece por n, sin distinguir mayúsculas, y cuyo identificador no sea 1, 2 ni 3.
-- 4. Recupera id y name de las cuentas creadas entre el 2 y el 5 de octubre de 2026, incluyendo ambos días, cuyo estado (is_active) no sea NULL.
-- 5. Recupera id y name de las cuentas que cumplan ambas condiciones: que su saldo sea mayor que 600000 o su descripción sea NULL; y que su estado is_active no sea NULL. Utiliza paréntesis para representar correctamente la lógica.
-- Parte B — Razonamiento sin ejecutar
-- Pregunta 6. ¿Qué identificadores devuelve esta consulta? Justifica.
-- SELECT id, name
-- FROM accounts
-- WHERE (is_active = TRUE OR description IS NULL)
--   AND balance >= 500000;


-- Pregunta 7. ¿Qué sucede con esta consulta?
-- SELECT id, name
-- FROM accounts
-- WHERE is_active NOT IN (TRUE, NULL);


-- ¿Cuántas filas devuelve y por qué? Presta especial atención al comportamiento de NULL.

-- Pregunta 8. ¿Qué diferencia existe entre estas dos condiciones?
-- WHERE balance BETWEEN 500000 AND 1000000


-- WHERE balance > 500000 AND balance < 1000000


-- Explica qué sucede con una cuenta que tenga exactamente 500000 de saldo.
--1.
select id,name from accounts where is_active = true and balance BETWEEN 500000 and 1000000;
--2
select id, name from accounts where description is null or is_active = false;
--3
select name, balance from accounts where name ilike 'n%' and id not in (1,2,3);
--4
SELECT id, name 
FROM accounts 
WHERE created_at BETWEEN '2026-10-02' AND '2026-10-05' 
  AND is_active = true;
--5
select id, name from accounts where (balance > 600000 or description is null) and is_active is not null;