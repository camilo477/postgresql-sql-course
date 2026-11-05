Parte 1 — Funciones de texto

1. LOWER() — Convertir a minúsculas

LOWER() convierte los caracteres de un texto a minúsculas según las reglas de conversión de caracteres aplicables.

SELECT LOWER('BANCOLOMBIA');

SELECT
    description,
    LOWER(description) AS lowercase_description
FROM lab_aggregate_transactions;

2. UPPER() — Convertir a mayúsculas

SELECT UPPER('Nequi');

SELECT
    name
FROM categories
WHERE UPPER(name) = 'SALARIO';

3. TRIM() — Eliminar espacios de los extremos

"   Nequi   "
SELECT TRIM('   Nequi   ');
Nequi

TRIM elimina los espacios iniciales y finales, no los espacios entre palabras.

4. LENGTH() — Longitud del texto

SELECT LENGTH('Nequi');

5

Bloque 15 — Parte 2: CAST, COALESCE y NULLIF

1. CAST — Conversión de tipos

Imagina que recibimos este valor desde un archivo CSV:

"150000.50"

Aunque representa una cantidad monetaria, está almacenado como texto.

Para trabajar con él como número podemos utilizar CAST.

CAST(valor AS tipo_dato)

SELECT CAST('150000.50' AS NUMERIC(12,2));

SELECT '150000.50'::NUMERIC(12,2);

2. COALESCE — Reemplazar valores NULL

SELECT SUM(amount)
FROM transactions
WHERE movement_type = 'expense';

Si no existen importes no nulos para sumar, SUM() devuelve NULL.

SELECT
    COALESCE(SUM(amount), 0) AS total_expenses
FROM transactions
WHERE movement_type = 'expense';

3. NULLIF — Convertir una coincidencia en NULL

NULLIF(valor1, valor2)

Su comportamiento es:
- Si los dos valores son iguales, devuelve NULL.
- Si son diferentes, devuelve el primer valor.

SELECT NULLIF(100, 100);

Resultado: NULL.

SELECT NULLIF(100, 50);

Resultado: 100.

Bloque 15 — Parte 3: ROUND y funciones básicas de fechas

1. ROUND — Redondear números

SELECT ROUND(150000.567::NUMERIC, 2);

150000.57

SELECT ROUND(150000.567::NUMERIC);
150001

2. EXTRACT — Extraer partes de una fecha

2026-11-05
SELECT EXTRACT(YEAR FROM DATE '2026-11-05');

SELECT
    EXTRACT(YEAR FROM DATE '2026-11-05') AS year,
    EXTRACT(MONTH FROM DATE '2026-11-05') AS month,
    EXTRACT(DAY FROM DATE '2026-11-05') AS day;

3. DATE_TRUNC — Truncar fechas

SELECT DATE_TRUNC(
    'month',
    TIMESTAMP '2026-11-05 14:30:00'
);

2026-11-01 00:00:00

