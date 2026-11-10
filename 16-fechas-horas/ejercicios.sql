-- Ejercicio 1 — Elección de tipos
-- Estamos diseñando una tabla para nuestra aplicación de finanzas personales.

-- Elige DATE, TIMESTAMP o TIMESTAMPTZ para cada campo y explica brevemente por qué.
-- Campo	Requisito
-- payment_due_date	Día en que vence una factura
-- created_at	Instante exacto en que se creó una transacción
-- meeting_local_time	Fecha y hora prevista de una reunión local, sin zona definida
-- last_login	Instante exacto del último inicio de sesión

-- Ejercicio 2 — SQL práctico
-- Sin consultar ninguna tabla, escribe una única sentencia SELECT que devuelva:
-- - invoice_date: el 15 de noviembre de 2026, como DATE.
-- - scheduled_at: el 15 de noviembre de 2026 a las 14:30, como TIMESTAMP.
-- - transaction_at: el mismo día a las 14:30 con desplazamiento UTC−5, como TIMESTAMPTZ.
-- Debes utilizar literales tipados explícitamente.

--1
payment_due_date	Día en que vence una factura
usaria date, solo se ncesita la fecha

created_at	Instante exacto en que se creó una transacción
usaria TIMESTAMPTZ, es el isntante exacto con hora y fecha

meeting_local_time	Fecha y hora prevista de una reunión local, sin zona definida
TIMESTAMP pues muestra fecha y hora

last_login	Instante exacto del último inicio de sesión
TIMESTAMPTZ porque es un instante exacto

--2
SELECT
    DATE '2026-11-15' AS invoice_date,
    TIMESTAMP '2026-11-15 14:30:00' AS scheduled_at,
    TIMESTAMPTZ '2026-11-15 14:30:00-05:00' AS transaction_at;

--3
a. la diferencia es que timestamp es sin zona horario especifica, timestamptz es con zona horaria
b. si, con timestamptz
c. porque no sabriamos el momento exacto cuando el usuario lo hizo

-- Ejercicio 4 — Rango mensual
-- Escribe una consulta que recupere id, created_at y amount de todas las transacciones realizadas durante octubre de 2026.

-- Requisitos: utiliza >= y <, no utilices BETWEEN y ordena por created_at ASC.
-- Ejercicio 5 — INTERVAL
-- Escribe una única consulta SQL, sin tablas, que calcule:
-- - next_payment_date: 15 días después de 2026-11-09.
-- - previous_week: 7 días antes de 2026-11-09.
-- Debes utilizar DATE e INTERVAL.
-- Ejercicio 6 — Razonamiento
-- A. ¿Por qué esta condición puede excluir transacciones realizadas durante el último día de octubre?
-- WHERE created_at BETWEEN '2026-10-01' AND '2026-10-31'


-- B. ¿Cuántos registros de nuestra tabla de ejemplo cumplen el rango completo de octubre?

-- C. ¿Qué diferencia existe entre restar INTERVAL '1 month' y INTERVAL '30 days'?

--4
select id, created_at, amount
from transactions
where created_at >= timestamp '2026-10-01'
and created_at < timestamp '2026-11-01'
ORDER BY created_at ASC;

--5
SELECT
    DATE '2026-11-09' + INTERVAL '15 days' AS next_payment_date,
    DATE '2026-11-09' - INTERVAL '7 days' AS previous_week;

2026-11-09 12:00:00

--6
a. porque toma los extermos entonces no cuenta 2026-10-31 00:01 por ejemplo
b. 1 2 3 4
c.INTERVAL '1 month' tiene en cuenta los meses del calendario, cuya duración varía. En cambio, INTERVAL '30 days' siempre resta 30 días, independientemente del mes.