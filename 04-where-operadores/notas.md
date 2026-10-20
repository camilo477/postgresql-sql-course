Objetivos del Bloque 04

Parte 1 — Introducción a WHERE

1. ¿Qué es WHERE?
WHERE es una cláusula SQL que permite filtrar filas de acuerdo con una condición.

SELECT *
FROM categories
WHERE id = 2;

2. Operadores de comparación

Operador	Significado	Ejemplo
=	Igual	id = 3
<>	Diferente	id <> 3
>	Mayor que	id > 3
<	Menor que	id < 3
>=	Mayor o igual	id >= 3
<=	Menor o igual	id <= 3

SELECT id, name
FROM categories
WHERE id > 4;

3. Comparaciones con texto

SELECT id, name
FROM categories
WHERE name = 'Salario';

4. Comparaciones con BOOLEAN

SELECT id, name
FROM categories
WHERE is_active = TRUE;

o tambien

SELECT id, name
FROM categories
WHERE is_active;

Bloque 04 — Parte 2: AND, OR y NOT

1. AND — Ambas condiciones deben cumplirse

SELECT id, name
FROM categories
WHERE is_active = TRUE
  AND id > 2;

2. OR — Al menos una condición debe cumplirse

SELECT id, name
FROM categories
WHERE id = 1
   OR id = 4;

3. NOT — Negación de una condición

SELECT id, name
FROM categories
WHERE NOT (id > 3);

4. Precedencia de operadores

SELECT id, name
FROM categories
WHERE is_active = TRUE
   OR id = 4
  AND id > 2;

Qué condición evalúa primero PostgreSQL?

La precedencia de los operadores lógicos es:
Prioridad	Operador
1 — Mayor	NOT
2	AND
3 — Menor	OR
Esto significa que AND tiene prioridad sobre OR.

Bloque 04 — Parte 3: IN, NOT IN y BETWEEN

1. IN — Buscar dentro de un conjunto

Imagina que queremos recuperar las categorías con identificadores 1, 3 y 5.

SELECT id, name
FROM categories
WHERE id IN (1, 3, 5);

SELECT id, name
FROM categories
WHERE name IN ('Salario', 'Transporte');

2. NOT IN — Excluir valores

SELECT id, name
FROM categories
WHERE id NOT IN (1, 3, 5);

3. BETWEEN — Consultar rangos

SELECT id, name
FROM categories
WHERE id BETWEEN 2 AND 5;

Por tanto, devuelve las categorías con identificadores 2, 3, 4 y 5.

con fechas

SELECT id, name, created_on
FROM categories
WHERE created_on BETWEEN '2026-10-02' AND '2026-10-04';

Bloque 04 — Parte 4: LIKE e ILIKE

1. LIKE — Búsqueda mediante patrones

LIKE permite buscar texto utilizando patrones.

SELECT id, name
FROM categories
WHERE name LIKE 'S%';

Con nuestros datos devolvería:
id	name
3	Salario
5	Salud
Caracteres especiales
Carácter	Significado
%	Cualquier secuencia de cero o más caracteres
_	Exactamente un carácter

-- Comienza con S
WHERE name LIKE 'S%'

-- Termina en porte
WHERE name LIKE '%porte'

-- Contiene la secuencia alu
WHERE name LIKE '%alu%'

2. ILIKE — Búsqueda sin distinguir mayúsculas

PostgreSQL dispone de ILIKE, que realiza comparaciones de patrones sin distinguir mayúsculas y minúsculas, de acuerdo con la configuración regional aplicable.

SELECT id, name
FROM categories
WHERE name ILIKE 's%';

La diferencia fundamental:
Operador	Comportamiento habitual
LIKE 's%'	Busca nombres que empiecen con s minúscula
ILIKE 's%'	También encuentra nombres que empiecen con S mayúscula

Bloque 04 — Parte 5: IS NULL e IS NOT NULL

1. ¿Qué significa NULL?

En SQL, NULL representa la ausencia de un valor.

accounts
id	name	balance	description
1	Nequi	500000	Cuenta principal
2	Bancolombia	1200000	NULL
3	Efectivo	150000	Dinero físico
4	Davivienda	800000	NUL

Esto no significa que su descripción sea un texto vacío: su valor es NULL.

2. IS NULL

Si queremos consultar las cuentas que no tienen descripción, utilizamos:

SELECT id, name
FROM accounts
WHERE description IS NULL;

3. IS NOT NULL

Ahora queremos recuperar las cuentas que sí tienen descripción:

SELECT id, name
FROM accounts
WHERE description IS NOT NULL;

4. ¿Por qué no utilizar = NULL?

Esta consulta es sintácticamente válida, pero no encontrará las filas con descripción NULL.

Porque SQL utiliza una lógica de tres valores:

Resultado lógico	Significado
TRUE	Verdadero
FALSE	Falso
UNKNOWN	Desconocido

Al comparar un valor con NULL usando =, el resultado es UNKNOWN, incluso cuando ambos operandos son NULL.

5. NULL y los valores booleanos

Imagina nuestra tabla categories con estos registros:
id	name	is_active
1	Alimentación	true
2	Transporte	false
3	Salario	NULL
4	Entretenimiento	true
5	Salud	NULL

SELECT id, name
FROM categories
WHERE is_active = FALSE;

Obtenemos únicamente:
id	name
2	Transporte

WHERE NOT is_active Esta condición no incluye los registros con NULL, porque NOT UNKNOWN sigue siendo UNKNOWN.

6. Cuidado con NOT IN y NULL

WHERE id NOT IN (1, 2, 3)


Pero observa:
WHERE id NOT IN (1, 2, NULL)


Si un identificador vale 5, sabemos que no coincide con 1 ni 2, pero no podemos determinar si es diferente de ese valor desconocido.

Por eso, el resultado lógico es UNKNOWN y la fila no pasa el filtro.

