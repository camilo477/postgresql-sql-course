Parte 1 — ¿Qué es una subquery?

Una subquery (subconsulta) es una consulta SQL que se encuentra dentro de otra consulta.

2. Una consulta dentro de otra
Primero podemos calcular el ingreso máximo:
SELECT MAX(amount)
FROM lab_aggregate_transactions
WHERE movement_type = 'income';


Resultado:
max
3000000

Ahora podríamos escribir manualmente otra consulta para buscar ese importe.

Pero eso tiene un problema: si los datos cambian, el valor que escribimos manualmente podría quedar desactualizado.

En lugar de eso, utilizamos una subconsulta:
SELECT description, amount
FROM lab_aggregate_transactions
WHERE movement_type = 'income'
  AND amount = (
      SELECT MAX(amount)
      FROM lab_aggregate_transactions
      WHERE movement_type = 'income'
  );


Resultado:
description	amount
Salario	3000000

Parte 2: IN, EXISTS y NOT EXISTS

1. IN con subqueries

Pero ¿qué ocurre si los identificadores que necesitamos no los conocemos de antemano?

Podemos obtenerlos mediante otra consulta.

Imagina estas tablas:

customers
id	full_name
1	Carlos
2	María
3	Pedro

wallets
id	name	customer_id
10	Nequi	1
11	Bancolombia	1
12	Efectivo	2

Queremos encontrar los clientes que tienen al menos una cuenta financiera.

Podemos utilizar:
SELECT id, full_name
FROM customers
WHERE id IN (
    SELECT customer_id
    FROM wallets
);


La subconsulta obtiene los identificadores de los propietarios de cuentas.
Subquery → 1, 1, 2

Después, la consulta externa busca los clientes cuyos identificadores pertenecen a esos valores.

Resultado:
id	full_name
1	Carlos
2	María

Pedro no aparece porque no tiene ninguna cuenta.

2. EXISTS — Comprobar si existen registros
EXISTS permite comprobar si una subconsulta devuelve al menos una fila.

SELECT
    c.id,
    c.full_name
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM wallets AS w
    WHERE w.customer_id = c.id
);

¿Por qué SELECT 1?
SELECT 1


Es una convención habitual con EXISTS.

El valor seleccionado no importa para comprobar la existencia: lo importante es que la subconsulta devuelva al menos una fila.

3. Subqueries correlacionadas

WHERE w.customer_id = c.id

La subconsulta utiliza c.id, que pertenece a la consulta externa.

Esto se conoce como subquery correlacionada.

4. NOT EXISTS

También podemos utilizar:
WHERE NOT EXISTS (...)

Bloque 12 — Parte 3: Subqueries en FROM

1. ¿Para qué sirve?

SELECT
    summary.wallet_id,
    summary.total_amount
FROM (
    SELECT
        wallet_id,
        SUM(amount) AS total_amount
    FROM transactions
    GROUP BY wallet_id
) AS summary;

2. ¿Subquery o JOIN?

No son herramientas mutuamente excluyentes.
Necesidad	Alternativa habitual
Recuperar columnas de varias tablas relacionadas	JOIN
Comprobar si existe una relación	EXISTS
Comprobar pertenencia a un conjunto	IN
Comparar con un valor calculado	Subquery escalar
Consultar un resultado agregado intermedio	Subquery en FROM

