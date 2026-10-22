-- Bloque 05 — Mini reto acumulativo

-- Ahora quiero comprobar que puedes combinar lo aprendido en los bloques 03, 04 y 05.

-- Objetivo: resolver consultas financieras utilizando SELECT, WHERE, ORDER BY, LIMIT y OFFSET sin recibir pistas.
-- Contexto: historial de transacciones
-- Tenemos la siguiente tabla ficticia transactions:
-- id	description	amount	created_on
-- 1	Mercado	150000	2026-10-15
-- 2	Transporte	20000	2026-10-16
-- 3	Salario	3000000	2026-10-15
-- 4	Arriendo	800000	2026-10-17
-- 5	Restaurante	60000	2026-10-16
-- 6	Internet	90000	2026-10-15
-- No necesitas crear esta tabla todavía. Puedes resolver los ejercicios utilizando estos datos.
-- Parte A — Consultas SQL
-- 1. Últimas transacciones

-- Recupera las tres transacciones más recientes.

-- Requisitos:
-- - Mostrar id, description y created_on.
-- - Ordenar por fecha descendente.
-- - Resolver empates con id DESC.
-- - Devolver únicamente tres registros.
-- 2. Historial paginado con filtros

-- Un usuario quiere consultar la segunda página de sus transacciones cuyo importe sea estrictamente mayor que 50000.

-- Requisitos:
-- - Mostrar id, description y amount.
-- - Ordenar por created_on DESC, resolviendo empates con id DESC.
-- - Mostrar dos registros por página.
-- 3. Transacciones de menor importe

-- Recupera las dos transacciones de menor importe cuyo valor sea estrictamente mayor que 20000.

-- Requisitos:
-- - Mostrar id, description y amount.
-- - Ordenar por importe ascendente.
-- - Resolver empates mediante id ASC.
-- 4. Segunda página por importe

-- Necesitamos consultar transacciones ordenadas de mayor a menor importe.

-- Requisitos:
-- - Mostrar id, description y amount.
-- - Ordenar por amount DESC, con id DESC para empates.
-- - Mostrar tres registros por página.
-- - Recuperar la segunda página.
-- 5. Mayor transacción

-- Escribe una consulta que recupere únicamente la transacción con el importe más alto.

-- Debes mostrar description y amount. En caso de empate, utiliza id DESC.

-- Parte B — Razonamiento técnico
-- 6. Interpretación de paginación

-- Analiza:
-- SELECT id, description
-- FROM transactions
-- ORDER BY created_on DESC, id DESC
-- LIMIT 2 OFFSET 2;


-- Responde:

-- a. ¿Qué página representa si mostramos dos registros por página?

-- b. ¿Cuántas filas devuelve?

-- c. ¿Qué identificadores devuelve y en qué orden?

-- 7. Debugging de una consulta

-- Un desarrollador quiere recuperar las dos transacciones más recientes, pero escribe:
-- SELECT id, description, created_on
-- FROM transactions
-- LIMIT 2;


-- Responde:

-- a. ¿La consulta es sintácticamente correcta?

-- b. ¿Garantiza que devuelve las dos transacciones más recientes?

-- c. ¿Cómo la corregirías para obtener un resultado determinista?

-- 8. Pregunta de entrevista

-- Imagina que tenemos una tabla con un millón de transacciones.

-- Nuestra API utiliza:
-- SELECT id, description, amount
-- FROM transactions
-- ORDER BY id DESC
-- LIMIT 20 OFFSET 900000;


-- Explica por qué un OFFSET tan grande podría afectar al rendimiento y qué trabajo debe realizar PostgreSQL para devolver esos 20 registros.

--1
select id, description, created_on from transactions order by created_on desc, id desc limit 3;
--2
select id, description, amount from transactions where amount > 50000 order by created_on desc, id desc limit 2 offset 2;
--3
select id, description, amount from transactions where amount > 20000 order by amount asc, id asc limit 2;
--4
select id, description, amount from transactions ORDER BY amount desc, id desc limit 3 offset 3;
--5 
select description, amount from transactions order by amount desc, id desc limit 1;
--6
a. en este caso es la segunda pagina
b. devuelve 2 filas ADD
c. devuelve id y description
--7
a. es sintacticamente correcta
b. no, porque no esta organizada
c. primero ordenaria por created_on desc para ver la mas reciente
SELECT id, description, created_on
FROM transactions
ORDER BY created_on desc, id desc
LIMIT 2;
--8
postgres debera calcular todos los campos para hacer el limit y el offset

select id, description, created_on from transactions order by created_on desc, id desc limit 3;
select id, description, amount from transactions where amount > 20000 order by amount asc, id asc limit 2;
select id, description, amount from transactions order by amount desc, id desc limit 3 offset 3;
select id, description, created_on from transactions order by created_on desc, id desc limit 2 offset 4;
select id, description, amount from transactions where amount >= 90000 order by created_on asc, id asc limit 2 offset 2;