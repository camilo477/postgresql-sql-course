Módulo 02 — PostgreSQL y SQL

Día 17 | Bloque 17: Transacciones SQL y ACID

Parte 1 — ¿Qué es una transacción SQL?

Imagina que tenemos dos cuentas bancarias.
Cuenta A

$500.000
Cuenta principal

Cuenta B

$200.000
Cuenta de ahorros


Transferencia: $100.000


Nuevo saldo A$400.000


Nuevo saldo B$300.000




Para realizar esta transferencia necesitamos dos operaciones:
1. Descontar $100.000 de la cuenta A.
2. Sumar $100.000 a la cuenta B.

Parte 2 — BEGIN, COMMIT y ROLLBACK

1. BEGIN — Iniciar una transacción

BEGIN;


A partir de este momento, las operaciones siguientes pertenecen a una misma transacción, hasta que esta termine

2. COMMIT — Confirmar los cambios

COMMIT;

3. ROLLBACK — Deshacer los cambios

ROLLBACK;

BEGIN;

UPDATE lab_acid_accounts
SET balance = balance + 50000
WHERE id = 1;

ROLLBACK;

Si hubiéramos utilizado COMMIT en lugar de ROLLBACK, el cambio habría quedado confirmado.

Parte 3 — Propiedades ACID

Las transacciones se apoyan en cuatro propiedades fundamentales.
Propiedad	Significado	Ejemplo financiero
A — Atomicidad	La transacción se confirma completa o no se confirma	No queremos descontar dinero sin completar la transferencia
C — Consistencia	Se preservan las restricciones e invariantes garantizadas por la base de datos	Un CHECK puede impedir saldos negativos
I — Aislamiento	Controla cómo interactúan las transacciones concurrentes	Dos operaciones simultáneas sobre una cuenta
D — Durabilidad	Los cambios confirmados sobreviven a fallos del sistema, según las garantías de persistencia configuradas	Una transferencia confirmada no debe perderse tras reiniciar PostgreSQL

Parte 2 — SAVEPOINT y manejo de errores

1. ¿Qué ocurre cuando una sentencia falla?

Recuerda que nuestra tabla tiene esta restricción:
CHECK (balance >= 0)


Eso significa que PostgreSQL no permite almacenar saldos negativos.

PostgreSQL rechazará el UPDATE porque viola la restricción CHECK.

2. SAVEPOINT — Crear un punto de recuperación

BEGIN;

UPDATE lab_acid_accounts
SET balance = balance + 20000
WHERE id = 1;

SAVEPOINT before_second_update;

UPDATE lab_acid_accounts
SET balance = balance + 10000
WHERE id = 2;

ROLLBACK TO SAVEPOINT before_second_update;

COMMIT;

ROLLBACK TO SAVEPOINT nombre

3. SAVEPOINT ante un error real

También podemos utilizar un SAVEPOINT antes de una operación que podría fallar.
BEGIN;

SAVEPOINT before_risky_update;

UPDATE lab_acid_accounts
SET balance = -100000
WHERE id = 1;


La operación falla por el CHECK.

Sin embargo, como creamos un punto de recuperación, podemos ejecutar:
ROLLBACK TO SAVEPOINT before_risky_update;


Y la transacción vuelve a quedar disponible para ejecutar sentencias.

Parte 3 — Transferencias financieras seguras

1. ¿Cómo detectar operaciones incorrectas?

PostgreSQL permite utilizar RETURNING para observar qué filas modificó una sentencia:

UPDATE lab_acid_accounts
SET balance = balance - 50000
WHERE id = 1
RETURNING id, balance;

