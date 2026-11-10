Parte 1 — DATE, TIMESTAMP y TIMESTAMPTZ

1. DATE — Una fecha sin hora

SELECT DATE '2026-11-09';
2026-11-09

2. TIMESTAMP — Fecha y hora sin zona horaria

SELECT TIMESTAMP '2026-11-09 14:30:00';
2026-11-09 14:30:00

3. TIMESTAMPTZ — Un instante en el tiempo

SELECT TIMESTAMPTZ '2026-11-09 14:30:00-05';
Aquí -05 indica que la hora proporcionada está cinco horas detrás de UTC.

¿Qué ocurre internamente?
HORA EN BOGOTÁ (UTC−5)
14:30
9 de noviembre de 2026
HORA UTC
19:30
9 de noviembre de 2026


Son dos representaciones del mismo instante. PostgreSQL almacena internamente los valores TIMESTAMPTZ normalizados a UTC y los muestra según la zona horaria de la sesión.

Parte 2 — Configuración temporal en PostgreSQL

1. Comparar fechas

created_at TIMESTAMP

podemos usar operadores ya conocidos
SELECT id, created_at, amount
FROM transactions
WHERE created_at >= TIMESTAMP '2026-10-01 00:00:00';

2. El problema de BETWEEN con TIMESTAMP

SELECT id, created_at, amount
FROM transactions
WHERE created_at BETWEEN '2026-10-01' AND '2026-10-31';

BETWEEN incluye ambos extremos. Sin embargo, cuando comparamos una columna TIMESTAMP con esos límites, el último equivale a:

2026-10-31 00:00:00

El problema del límite superior
31 oct · 00:00
Incluida


31 oct · 09:00
Excluida


31 oct · 23:59
Excluida

3. La solución: intervalo semiabierto

SELECT id, created_at, amount
FROM transactions
WHERE created_at >= TIMESTAMP '2026-10-01'
  AND created_at < TIMESTAMP '2026-11-01';

Parte 3 — INTERVAL

INTERVAL representa una duración o período de tiempo en PostgreSQL.

SELECT DATE '2026-11-09' + INTERVAL '7 days';

2026-11-16 00:00:00


SELECT TIMESTAMP '2026-11-09 10:00:00'
       + INTERVAL '2 hours';

2026-11-09 12:00:00



Bloque 16 — Parte 3: Zonas horarias y reportes mensuales

1. AT TIME ZONE

SELECT
    TIMESTAMPTZ '2026-11-09 14:30:00-05'
        AT TIME ZONE 'America/Bogota' AS bogota_time,

    TIMESTAMPTZ '2026-11-09 14:30:00-05'
        AT TIME ZONE 'UTC' AS utc_time;
Resultado:
bogota_time	utc_time
2026-11-09 14:30:00	

2. Reportes financieros mensuales

Imagina una tabla ficticia transactions con estas columnas:

id
movement_type
amount
created_at TIMESTAMPTZ

Necesitamos calcular cuánto gastó un usuario cada mes.

Podríamos escribir:

SELECT
    DATE_TRUNC(
        'month',
        created_at AT TIME ZONE 'America/Bogota'
    ) AS month,
    SUM(amount) AS total_expenses
FROM transactions
WHERE movement_type = 'expense'
GROUP BY
    DATE_TRUNC(
        'month',
        created_at AT TIME ZONE 'America/Bogota'
    )
ORDER BY month;

