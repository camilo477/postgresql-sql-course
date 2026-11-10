-- Pregunta 1 — Propiedades ACID
-- Explica brevemente con tus palabras qué significan:

-- A. Atomicidad

-- B. Consistencia

-- C. Aislamiento

-- D. Durabilidad

-- Después responde: ¿qué propiedad ACID está directamente relacionada con la necesidad de confirmar o deshacer conjuntamente ambas operaciones de una transferencia bancaria?
-- Pregunta 2 — Transferencia SQL
-- Escribe una transacción para transferir $25.000 desde la cuenta 2 hacia la cuenta 1.

-- Requisitos:
-- - Iniciar con BEGIN.
-- - Descontar $25.000 de la cuenta 2.
-- - Comprobar que la cuenta tiene saldo suficiente mediante el WHERE.
-- - Sumar $25.000 a la cuenta 1.
-- - Utilizar RETURNING id, balance en ambas operaciones.
-- - Indicar cuándo corresponde ejecutar COMMIT y cuándo ROLLBACK.
-- No necesitas implementar una función automática; puedes indicar la decisión manualmente, como hiciste en el laboratorio.
-- Pregunta 3 — ROLLBACK
-- Analiza este código sin ejecutarlo:
-- BEGIN;

-- UPDATE lab_acid_accounts
-- SET balance = balance + 20000
-- WHERE id = 1;

-- ROLLBACK;

-- SELECT balance
-- FROM lab_acid_accounts
-- WHERE id = 1;


-- A. ¿Qué saldo devolverá la última consulta, suponiendo que la cuenta 1 empieza con $380.000 y no hay otras modificaciones?

-- B. ¿Por qué?

-- C. ¿Qué habría ocurrido si utilizáramos COMMIT en lugar de ROLLBACK?
-- Pregunta 4 — SAVEPOINT y errores
-- Analiza este escenario:
-- BEGIN;

-- UPDATE lab_acid_accounts
-- SET balance = balance + 10000
-- WHERE id = 1;

-- SAVEPOINT before_invalid_update;

-- UPDATE lab_acid_accounts
-- SET balance = -50000
-- WHERE id = 2;


-- El último UPDATE viola la restricción CHECK.

-- Responde:

-- A. ¿En qué estado queda la transacción inmediatamente después del error?

-- B. ¿Qué comando permitiría regresar al SAVEPOINT y continuar trabajando?

-- C. Si después de recuperarnos ejecutamos COMMIT, ¿qué ocurrirá con el primer UPDATE, que sumó $10.000 a la cuenta 1?
-- Pregunta 5 — Debugging de una transferencia
-- Un desarrollador escribe:
-- BEGIN;

-- UPDATE lab_acid_accounts
-- SET balance = balance - 100000
-- WHERE id = 1;

-- UPDATE lab_acid_accounts
-- SET balance = balance + 100000
-- WHERE id = 999;

-- COMMIT;


-- Responde:

-- A. Identifica el problema principal.

-- B. ¿PostgreSQL necesariamente generará un error en el segundo UPDATE?

-- C. ¿Qué riesgo produce ejecutar COMMIT?

-- D. Explica qué comprobación debería realizar el desarrollador antes de confirmar.
-- Pregunta 6 — Diseño y razonamiento profesional
-- Imagina que estamos construyendo la futura aplicación financiera con Python y PostgreSQL.

-- Un usuario solicita transferir $200.000 entre dos cuentas.

-- Responde:

-- A. ¿Por qué no sería suficiente ejecutar dos consultas UPDATE independientes?

-- B. ¿Por qué una transacción que finaliza correctamente con COMMIT no garantiza por sí sola que la transferencia sea válida desde el punto de vista del negocio?

-- C. Si dos usuarios intentan retirar dinero simultáneamente de la misma cuenta, ¿qué propiedad ACID resulta especialmente importante y qué problema necesitamos evitar?

-- No necesitas explicar todavía los mecanismos de bloqueo o los niveles de aislamiento. Los estudiaremos en el Bloque 18.

--1
A — Atomicidad	La transacción se confirma completa o no se confirma	No queremos descontar dinero sin completar la transferencia
C — Consistencia	Se preservan las restricciones e invariantes garantizadas por la base de datos	Un CHECK puede impedir saldos negativos
I — Aislamiento	Controla cómo interactúan las transacciones concurrentes	Dos operaciones simultáneas sobre una cuenta
D — Durabilidad	Los cambios confirmados sobreviven a fallos del sistema, según las garantías de persistencia configuradas	Una transferencia confirmada no debe perderse tras reiniciar PostgreSQL

atomicidad, porque garantiza que ambas operaciones de una transferencia se ejecuten como una sola unidad

--2
begin;
update lab_acid_accounts
set balance = balance - 25000
where id = 2 and balance >= 25000
returning id,balance;

update lab_acid_accounts
set balance = balance + 25000
where id = 1
returning id,balance;

COMMIT; si ambos UPDATE devuelven exactamente UPDATE 1.
ROLLBACK; si cualquiera devuelve UPDATE 0 o modifica una cantidad inesperada de filas.

--3
 devolvera 380000 porque se hizo ROLLBACK con commit si cambiaria y terminaria en 400000
--4
a. queda en error o abortada
b. ROLLBACK TO SAVEPOINT before_invalid_update;
c. el primer update se conserva y se confirma con el commit
--5
a. El problema es que se descuentan $100.000 de la cuenta 1, pero se intenta transferir ese dinero a la cuenta 999
que no existe, ademas no se valida si la cuenta 1 tiene saldo suficiente
b. no, si la cuenta no existe solo manda update 0
c. se confirmarían los cambios aunque la transferencia estuviera incompleta. La cuenta 1 perdería $100.000, pero la cuenta de destino no recibiría el dinero.
d. ebe verificar que ambos UPDATE hayan modificado exactamente una fila, utilizando RETURNING id, balance o revisando el resultado UPDATE 1.

--6
a. debemos ver si la cuenta tiene el dinero y si existen las cuentas
b. porque puede mandar update 0 o solo aher la mitad
c. aislamiento , permite controlar como interactuan las transacciones simultaneas