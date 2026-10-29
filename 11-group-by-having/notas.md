Parte 1 — Entendiendo GROUP BY

Queremos obtener dos resultados separados, uno por cada movement_type.

Aquí es donde utilizamos GROUP BY.

2. ¿Cómo funciona GROUP BY?

SELECT
    movement_type,
    COUNT(*) AS total_transactions
FROM lab_aggregate_transactions
GROUP BY movement_type;

Resultado esperado:
movement_type	total_transactions
income	2
expense	4

3. GROUP BY con otras agregaciones

Por regla general, cuando utilizamos GROUP BY, una columna del SELECT debe:
- Aparecer en el GROUP BY.
- Estar dentro de una función de agregación.

4. Diferencia entre WHERE y GROUP BY

SELECT
    movement_type,
    COUNT(*) AS total_transactions
FROM lab_aggregate_transactions
WHERE amount IS NOT NULL
GROUP BY movement_type;

Bloque 11 — Parte 2: GROUP BY con varias columnas

GROUP BY wallet_id, movement_type
PostgreSQL crea un grupo por cada combinación diferente de cuenta y tipo de movimiento.


Parte 3: HAVING

Mostrar únicamente los tipos de movimiento que tengan por lo menos tres transacciones.

SELECT
    movement_type,
    COUNT(*) AS total_transactions
FROM lab_aggregate_transactions
GROUP BY movement_type
HAVING COUNT(*) >= 3;

2. WHERE vs. HAVING

Podemos utilizar ambos en una misma consulta.

El orden de las cláusulas es:
SELECT ...
FROM ...
WHERE ...
GROUP BY ...
HAVING ...
ORDER BY ...;

Bloque 11 — Parte 4: GROUP BY con JOIN

Primero: necesitamos elegir correctamente los JOIN para no excluir a los clientes sin cuentas o sin transacciones.

Segundo: debemos contar las transacciones utilizando su identificador, porque COUNT(*) podría contar filas conservadas por un LEFT JOIN aunque no tengan transacciones relacionadas.