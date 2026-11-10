-- Ejercicio 1 — Transferencia con COMMIT

-- Escribe una transacción SQL que transfiera $100.000 de la cuenta 1 a la cuenta 2.

-- Requisitos:
-- - Comenzar con BEGIN.
-- - Descontar el dinero de la cuenta 1.
-- - Sumarlo a la cuenta 2.
-- - Confirmar los cambios mediante COMMIT.
-- - Consultar los saldos finales.
-- Resultado esperado después de confirmar:
-- Cuenta	Saldo
-- 1	400000.00
-- 2	300000.00

-- No necesitas utilizar funciones almacenadas ni Python.

--1
BEGIN;

UPDATE lab_acid_accounts
SET balance = balance - 100000
where id = 1;

update lab_acid_accounts
set balance = balance + 100000
where id = 2;

commit;

--2
begin;

update lab_acid_accounts
set balance = balance - 30000
where id = 1;
select balance from lab_acid_accounts where id = 1;

ROLLBACK;
select balance from lab_acid_accounts where id = 1;

--3
a. commit hace que se haga la transferencia y se guarde, rollback cancela el guardado
b. El riesgo principal es que la transferencia quede incompleta y se pierda la consistencia de los datos.
c. No. PostgreSQL no genera necesariamente un error cuando un UPDATE no encuentra ninguna fila. Y tampoco basta con usar BEGIN y COMMIT para garantizar que una transferencia sea correcta.


-- Ejercicio 4 — SAVEPOINT
-- Escribe una transacción que:
-- 1. Inicie con BEGIN.
-- 2. Sume $10.000 a la cuenta 1.
-- 3. Cree un SAVEPOINT llamado before_account_2.
-- 4. Sume $20.000 a la cuenta 2.
-- 5. Deshaga solamente el cambio de la cuenta 2 utilizando ROLLBACK TO SAVEPOINT.
-- 6. Confirme la transacción con COMMIT.
-- 7. Consulte los saldos finales.
-- Pregunta: ¿cuál debería ser el saldo final de cada cuenta?
-- Ejercicio 5 — Recuperarse de un error
-- Escribe una transacción que:
-- 1. Inicie con BEGIN.
-- 2. Cree un SAVEPOINT llamado before_invalid_update.
-- 3. Intente asignar -50000 como saldo de la cuenta 1.
-- 4. Recupere la transacción utilizando el SAVEPOINT.
-- 5. Consulte el saldo de la cuenta 1.
-- 6. Termine con ROLLBACK para que el ejercicio no modifique los datos permanentemente.
-- Ejecuta las sentencias en psql, preferiblemente una por una, y observa el error de restricción.
-- Ejercicio 6 — Razonamiento
-- A. ¿Cuál es la diferencia entre ROLLBACK y ROLLBACK TO SAVEPOINT?

-- B. Si hacemos un UPDATE, creamos un SAVEPOINT, hacemos otro UPDATE y después ejecutamos ROLLBACK TO SAVEPOINT, ¿qué ocurre con el primer UPDATE?

-- C. Si una transferencia de dinero tiene dos operaciones y falla la segunda, ¿sería correcto utilizar un SAVEPOINT para conservar la primera y luego confirmar la transacción? Justifica tu respuesta.

-- 📊 Progreso del Bloque 17
-- Tema	Estado
-- BEGIN, COMMIT y ROLLBACK	✅
-- Fundamentos ACID	✅
-- SAVEPOINT	🟡 En práctica
-- Errores en transacciones	🟡 En práctica
-- Transferencias seguras	⏳
-- Examen final de 6 preguntas	⏳

-- Tu turno: resuelve los ejercicios 4, 5 y 6.

-- Después revisaremos tus resultados y terminaremos con la parte de transferencias seguras antes del examen final.

--4
begin;
update lab_acid_accounts
set balance = balance + 10000
where id = 1;

savepoint before_account_2;

update lab_acid_accounts
set balance = balance + 20000
where id = 2;
rollback to savepoint before_account_2;
commit;
finance_practice=> select * from lab_acid_accounts;
 id |       name        |  balance  
----+-------------------+-----------
  2 | Cuenta de ahorros | 300000.00
  1 | Cuenta principal  | 430000.00

--5
begin;
savepoint before_invalid_update;
update lab_acid_accounts
set balance = -50000
where id = 1;
rollback to savepoint before_invalid_update;
select balance from lab_acid_accounts where id = 1;
ROLLBACK;

--6
a. rollback devuelve todo, rollback to savepoint solo hasta el savepoint que creamos
b. el primer update si se hace el segundo NO
c. yo creo que no porque aunque se haga la primera depende tambien de que
la segunda se haga y quedara a medias

-- Ejercicio 7 — Transferencia con validación
-- Utiliza lab_acid_accounts.

-- Escribe una transacción para transferir $50.000 de la cuenta 1 a la cuenta 2.

-- Requisitos:
-- - Utiliza BEGIN.
-- - Comprueba el saldo suficiente mediante una condición en el WHERE del descuento.
-- - Utiliza RETURNING id, balance en ambos UPDATE.
-- - Comprueba que cada operación modificó exactamente una fila.
-- - Confirma mediante COMMIT únicamente si ambas operaciones fueron correctas.
-- - Consulta los saldos finales.
-- Puedes ejecutar los comandos uno por uno en psql y decidir manualmente cuándo confirmar.

-- No necesitas procedimientos almacenados ni automatizar las comprobaciones todavía.
-- Ejercicio 8 — Fallo de transferencia
-- Imagina que queremos transferir $50.000 desde la cuenta 1 hacia una cuenta inexistente con id = 999.

-- Responde:

-- A. ¿Qué resultado esperarías del segundo UPDATE ... RETURNING?

-- B. ¿Debemos ejecutar COMMIT o ROLLBACK? ¿Por qué?

-- C. Si el descuento inicial se ejecutó correctamente pero después hacemos ROLLBACK, ¿qué ocurre con el saldo de la cuenta 1?

--7
BEGIN;
update lab_acid_accounts
set balance = balance - 50000
WHERE id = 1 AND balance >= 50000
RETURNING id, balance;

update lab_acid_accounts
set balance = balance + 50000
WHERE id = 2
RETURNING id, balance;
BEGIN
 id |  balance  
----+-----------
  1 | 380000.00
(1 row)

UPDATE 1
 id |  balance  
----+-----------
  2 | 350000.00
(1 row)

UPDATE 1

commit;

--8
a. daria 0
b. rollback porque la transferencia esta MAl
c. se devuelven los cambios