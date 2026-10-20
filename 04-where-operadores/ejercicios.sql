-- Ejercicio 2 — Escribe tus consultas
-- Utiliza nuestra tabla categories.

-- Escribe una consulta SQL para cada requisito:

-- 1. Recuperar id y name de la categoría cuyo identificador sea exactamente 3.

-- 2. Recuperar todas las columnas de las categorías cuyo identificador sea mayor que 3.

-- 3. Recuperar los nombres de las categorías cuyo identificador sea menor o igual a 4.

-- 4. Recuperar id y name de todas las categorías cuyo identificador sea diferente de 2.

-- 5. Recuperar únicamente los nombres de las categorías que estén inactivas.

-- 6. Recuperar id y name de las categorías cuyo identificador sea mayor o igual a 4. Utiliza el alias category_name para el nombre.

--1
select id, name FROM categories where id=3; 
--2
select * from categories where id > 3;
--3
select name from categories where id <= 4;
--4
select id, name from categories where id != 2;
--5
select name from categories where not is_active;
--6 
select id, name as category_name from categories where id >=4;

-- Ejercicio 3 — AND, OR y NOT
-- Utilizaremos nuestros mismos datos.

-- categories
-- id	name	is_active
-- 1	Alimentación	true
-- 2	Transporte	true
-- 3	Salario	true
-- 4	Entretenimiento	false
-- 5	Salud	true
-- 6	Compras	false
-- Escribe las consultas SQL que resuelvan estos requisitos:
-- 1. Recuperar id y name de las categorías activas cuyo identificador sea mayor que 3.
-- 2. Recuperar todas las columnas de las categorías cuyo id sea igual a 2 o igual a 5.
-- 3. Recuperar los nombres de las categorías inactivas cuyo identificador sea mayor o igual a 4.
-- 4. Recuperar id y name de todas las categorías cuyo identificador no sea mayor que 3, utilizando obligatoriamente NOT.
-- 5. Recuperar los nombres de las categorías que estén activas o tengan un identificador menor que 3.

--1
select id, name from categories where is_active = true and id > 3;
--2
select * from categories where id = 2 or id = 5;
--3
select name from categories where is_active = FALSE and id >= 4;
--4
select id, name from categories where not id > 3;
--5
select name from categories where is_active = true or id < 3;

-- Ejercicio 5 — IN, NOT IN y BETWEEN
-- Utilizaremos nuestra tabla de práctica:
-- id	name	is_active	created_on
-- 1	Alimentación	true	2026-10-01
-- 2	Transporte	true	2026-10-02
-- 3	Salario	true	2026-10-03
-- 4	Entretenimiento	false	2026-10-04
-- 5	Salud	true	2026-10-05
-- 6	Compras	false	2026-10-06
-- Parte A — Escribe el SQL
-- 1. Recupera id y name de las categorías cuyos identificadores sean 1, 3 o 6. Utiliza obligatoriamente IN.

-- 2. Recupera todas las columnas de las categorías cuyos identificadores no sean 2, 4 ni 6. Utiliza NOT IN.

-- 3. Recupera id y name de las categorías cuyo identificador esté entre 2 y 5, incluyendo ambos extremos. Utiliza BETWEEN.

-- 4. Recupera los nombres de las categorías que sean Salario o Transporte utilizando IN.

-- 5. Recupera id y name de las categorías que estén activas y cuyo identificador esté entre 2 y 5.

-- 6. Recupera name y created_on de las categorías creadas entre el 2 y el 5 de octubre de 2026, incluyendo ambos días.

--1
select id, name from categories where id in (1,3, 6);
--2
select * from categories where id not in (2,4,6);
--3
select id, name from categories where id BETWEEN 2 and 5;
--4
select name from categories where name in ( 'Salario', 'Transporte');
--5
select id, name from categories where is_active = true and id BETWEEN 2 and 5;
--6
select name, created_on from categories where created_on  BETWEEN '2026-10-2' and'2026-10-5'; 

-- Ejercicio 7 — LIKE e ILIKE
-- Continuamos utilizando esta tabla:
-- id	name
-- 1	Alimentación
-- 2	Transporte
-- 3	Salario
-- 4	Entretenimiento
-- 5	Salud
-- 6	Compras
-- Escribe las consultas SQL para los siguientes requisitos:
-- 1. Recuperar id y name de las categorías cuyos nombres comiencen con la letra S mayúscula. Utiliza LIKE.
-- 2. Recuperar solamente los nombres de las categorías que terminen en porte.
-- 3. Recuperar id y name de las categorías cuyo nombre contenga la secuencia ten.
-- 4. Recuperar los nombres que comiencen con s, sin importar si la letra está en mayúscula o minúscula. Utiliza ILIKE.
-- 5. Recuperar las categorías cuyo nombre tenga exactamente cinco caracteres, comience con S y termine con ud. Utiliza el comodín _.

--1
select id, name from categories where name like 'S%';
--2 
select name from categories where name like '%porte';
--3
select id, name from categories where name like '%ten%';
--4
select name from categories where name ilike 's%';
--5
select * from categories where name like 'S__ud';

-- Ejercicio 9 — IS NULL e IS NOT NULL
-- Utilizaremos esta tabla ficticia. No necesitas modificar los registros de tu PostgreSQL.

-- accounts
-- id	name	balance	description
-- 1	Nequi	500000	Principal
-- 2	Bancolombia	1200000	NULL
-- 3	Efectivo	150000	Ahorros
-- 4	Davivienda	800000	NULL
-- 5	Nu	300000	NULL
-- Escribe una consulta SQL para cada requisito:
-- 1. Recuperar id y name de las cuentas cuya descripción sea NULL.
-- 2. Recuperar los nombres de las cuentas que tengan una descripción registrada.
-- 3. Recuperar todas las columnas de las cuentas cuya descripción sea NULL y cuyo saldo sea mayor que 500000.
-- 4. Recuperar id y name de las cuentas que tengan descripción o cuyo saldo sea mayor que 1000000.
-- 5. Recuperar los nombres de las cuentas que no tengan descripción y cuyo identificador esté entre 2 y 4, incluyendo ambos extremos.

--1
select id, name from acoounts where description is null;
--2
select name from accounts where description is not null;
--3
select * from accounts where description is null and balance > 500000;
--4
select id,name from accounts where description is not null or balance > 1000000;
--5
select name from accounts where description is null and id BETWEEN 2 and 4;