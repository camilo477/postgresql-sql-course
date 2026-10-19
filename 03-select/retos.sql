-- Bloque 03 — Mini reto acumulativo
-- Objetivo: Combinar todo lo aprendido sobre SELECT sin recibir pistas.

-- Este reto simula una tarea sencilla de consulta de datos financieros.
-- Contexto
-- Tenemos la siguiente tabla:

-- categories
-- id	name	is_active	created_on
-- 1	Alimentación	true	2026-10-01
-- 2	Transporte	true	2026-10-02
-- 3	Salario	true	2026-10-03
-- 4	Entretenimiento	false	2026-10-04
-- 5	Salud	true	2026-10-05
-- 6	Compras	false	2026-10-06
-- Parte A — Consultas SQL
-- Escribe una consulta SQL para cada requisito:

-- 1. Recuperar todas las columnas de la tabla categories.

-- 2. Recuperar únicamente name y created_on, utilizando los alias category_name y registration_date.

-- 3. Recuperar id, pero mostrarlo multiplicado por 1000 con el alias external_reference. También debes mostrar el nombre original de la categoría.

-- 4. Recuperar los valores únicos de is_active, mostrando la columna resultante como category_status.

-- 5. Recuperar las combinaciones únicas de name e is_active, utilizando los alias category_name y status.

-- 6. Crear una consulta que devuelva estos tres valores calculados, sin utilizar ninguna tabla:
-- - initial_balance: 1.500.000
-- - expense: 350.000
-- - remaining_balance: resultado de restar el gasto al saldo inicial.
-- No necesitas declarar variables. Utiliza expresiones SQL y alias.
-- Parte B — Razonamiento técnico
-- Responde con tus propias palabras:

-- 7. ¿Qué diferencia existe entre estas consultas?
-- SELECT DISTINCT is_active
-- FROM categories;


-- SELECT DISTINCT id, is_active
-- FROM categories;


-- ¿Cuántas filas devolvería cada una con los datos del ejemplo? Justifica.

-- 8. Un desarrollador escribe:
-- SELECT
--     name AS category_name,
--     id * 100 AS reference
-- FROM categories;


-- ¿Las columnas category_name y reference quedan guardadas permanentemente en PostgreSQL?

-- Explica qué está haciendo realmente esta consulta.

-- Parte C — Práctica en Fedora
-- Si ya tienes los seis registros de ejemplo insertados en finance_practice, ejecuta las consultas y compara los resultados con lo que esperabas.

-- Si todavía no los has insertado, puedes resolver el reto basándote en la tabla proporcionada. Después prepararemos los datos en PostgreSQL antes del examen.

-- No utilizaremos todavía WHERE, JOIN, GROUP BY ni ORDER BY.

