Parte 1 — ¿Qué es CASE?

CASE es una expresión condicional de SQL.

Es parecido a utilizar if / elif / else en Python, aunque CASE es una expresión SQL y no una estructura de control de flujo equivalente en todos sus aspectos.

CASE
    WHEN condicion_1 THEN resultado_1
    WHEN condicion_2 THEN resultado_2
    ELSE resultado_por_defecto
END

2. Ejemplo financiero

Trabajaremos con nuestra tabla lab_aggregate_transactions, creada anteriormente en Fedora.
id	description	movement_type	amount
1	Salario	income	3000000
2	Freelance	income	500000
3	Mercado	expense	150000
4	Transporte	expense	20000
5	Internet	expense	90000
6	Pendiente	expense	NULL

Queremos clasificar los importes según estas reglas:
Condición	Clasificación
amount >= 500000	Alto
amount >= 100000	Medio
amount < 100000	Bajo
amount IS NULL	Sin importe

SELECT
    description,
    amount,
    CASE
        WHEN amount IS NULL THEN 'Sin importe'
        WHEN amount >= 500000 THEN 'Alto'
        WHEN amount >= 100000 THEN 'Medio'
        ELSE 'Bajo'
    END AS amount_level
FROM lab_aggregate_transactions;

3. El orden de las condiciones importa

CASE
    WHEN amount >= 100000 THEN 'Medio'
    WHEN amount >= 500000 THEN 'Alto'
    ELSE 'Bajo'
END

¿Qué ocurriría con un importe de 800000?

La primera condición ya es verdadera:
amount >= 100000


Por tanto, PostgreSQL devolvería 'Medio' y no llegaría a utilizar la segunda condición.

Bloque 14 — Parte 2: CASE con funciones de agregación

1. Agregaciones condicionales

SELECT
    SUM(
        CASE
            WHEN movement_type = 'income' THEN amount
            ELSE 0
        END
    ) AS total_income,
    SUM(
        CASE
            WHEN movement_type = 'expense' THEN amount
            ELSE 0
        END
    ) AS total_expense
FROM lab_aggregate_transactions;

2. CASE con GROUP BY

SELECT
    CASE
        WHEN amount IS NULL THEN 'unknown'
        WHEN amount >= 100000 THEN 'high'
        ELSE 'low'
    END AS amount_level,
    COUNT(*) AS total_transactions
FROM lab_aggregate_transactions
GROUP BY amount_level;