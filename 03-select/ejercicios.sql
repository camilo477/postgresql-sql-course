-- Ejercicio 2 — Escribe tus primeras consultas
-- Tenemos esta tabla de ejemplo:

-- accounts
-- id	name	balance	account_type	is_active
-- 1	Nequi	500000	digital	true
-- 2	Bancolombia	1500000	savings	true
-- 3	Efectivo	200000	cash	true
-- 4	Davivienda	800000	savings	false
-- Estos son datos ilustrativos para el ejercicio; todavía no los hemos insertado en PostgreSQL.

-- Escribe una consulta SQL para cada requisito:
-- 1. Recuperar únicamente los nombres de las cuentas.
-- 2. Recuperar el identificador, nombre y saldo de todas las cuentas.
-- 3. Recuperar todas las columnas de accounts.
-- 4. Recuperar únicamente balance y account_type, en ese orden.
-- 5. Calcular 150000 + 350000 utilizando SELECT, sin consultar ninguna tabla.
-- No utilices WHERE, ORDER BY ni otras herramientas que todavía no hemos estudiado.

-- 1. 
SELECT name FROM accounts;
-- 2.
SELECT id, name, balance FROM accounts;
-- 3.
SELECT * FROM accounts;
-- 4.
SELECT balance, account_type FROM accounts;
-- 5. 
SELECT 150000 + 350000

-- Ejercicio 4 — Escribe las consultas
-- 1. Recupera name, pero haz que aparezca con el alias category_name.
-- 2. Recupera id y name, con los alias category_id y category_name.
-- 3. Recupera id y una segunda columna calculada multiplicando id por 100. La columna calculada debe llamarse reference.
-- 4. Recupera name e is_active, utilizando los alias category y active.

-- 1.
SELECT 
    name AS category_name
FROM categories;
-- 2.
SELECT
    id AS category_id,
    name AS category_name
FROM categories;
-- 3.
SELECT
    id,
    id * 100 AS reference
FROM categories;
-- 4.
SELECT
    name AS category,
    is_active AS active
FROM categories;

-- Ejercicio 6 — DISTINCT
-- Utiliza la tabla categories de nuestra base finance_practice, con los seis registros de prueba.
-- 1. Escribe una consulta para obtener los valores únicos de is_active, utilizando el alias status.
-- 2. Escribe una consulta para obtener las combinaciones únicas de is_active y created_on.
-- 3. Con los seis registros del ejemplo, ¿cuántas filas devolvería la consulta del punto 2? Explica por qué.
-- 4. Responde la pregunta de debugging que quedó pendiente: ¿por qué SELECT name AS category_name FROM accounts; no garantiza que estemos consultando nombres de categorías?

-- 1.
SELECT DISTINCT is_active AS status FROM categories;
-- 2.
SELECT DISTINCT is_active, created_on FROM categories;

