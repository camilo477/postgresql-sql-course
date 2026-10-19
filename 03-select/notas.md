Parte 1 — SELECT y FROM

1. ¿Qué es SELECT?

SELECT es una instrucción SQL que permite recuperar información.

SELECT name
FROM categories;

id	name	is_active
1	Alimentación	true
2	Transporte	true
3	Entretenimiento	false
4	Salario	true

da

name
Alimentación
Transporte
Entretenimiento
Salario

2. Seleccionar varias columnas

SELECT id, name
FROM categories;

Resultado:
id	name
1	Alimentación
2	Transporte
3	Entretenimiento
4	Salario

3. SELECT *

El símbolo * significa que queremos recuperar todas las columnas.

4. SELECT sin FROM

SELECT 10 + 5;

Resultado:
?column?
15

No necesitamos consultar una tabla para evaluar una expresión.

SELECT current_database();

Parte 3 — Alias con AS

1. ¿Qué es un alias?

Un alias permite asignar un nombre temporal a una columna dentro del resultado de una consulta.

ejemplo
SELECT name AS category_name
FROM categories;

2. Alias para varias columnas

SELECT
    id AS category_id,
    name AS category_name
FROM categories;

3. Expresiones dentro de SELECT

SELECT
    id,
    id * 10 AS calculated_value
FROM categories;

La columna calculated_value solamente existe en el resultado, no en la estructura real de categories.

Bloque 03 — Parte 4: DISTINCT

1. ¿Qué es DISTINCT?

DISTINCT permite obtener filas únicas dentro del resultado de una consulta.

Imagina que tenemos estos registros en categories:
id	name	is_active
1	Alimentación	true
2	Transporte	true
3	Salario	true
4	Entretenimiento	false
5	Salud	true
6	Compras	false

SELECT is_active
FROM categories;

Obtendríamos seis filas, incluyendo valores repetidos.

SELECT DISTINCT is_active
FROM categories;

Obtendríamos únicamente dos valores diferentes:

is_active
true
false

Importante: DISTINCT no elimina registros de la tabla. Solamente elimina las filas duplicadas del resultado de la consulta.

2. DISTINCT con varias columnas

SELECT DISTINCT name, is_active
FROM categories;

En este caso, PostgreSQL no aplica DISTINCT únicamente a name.

Lo aplica a la combinación completa de las columnas seleccionadas.

Lo aplica a la combinación completa de las columnas seleccionadas.

Por ejemplo, estas dos filas se consideran diferentes:
name	is_active
Alimentación	true
Alimentación	false
Aunque tienen el mismo nombre, el valor de is_active es diferente.

