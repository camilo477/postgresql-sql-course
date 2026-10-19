Database.
Schema.
Table.
Row.
Column.

1. Database

Una database es una base de datos administrada por PostgreSQL.

PostgreSQL
│
├── finance
├── ecommerce
└── inventory

son varias bases de datos con propios objetos como tablas y esquemas

2. Schema

Un schema es un espacio de nombres que permite organizar objetos dentro de una base de datos.

PostgreSQL
│
└── finance (database)
    │
    ├── public (schema)
    │   ├── accounts
    │   └── transactions
    │
    └── reports (schema)
        └── monthly_summary

postgresql permite SELECT * FROM public.accounts;

y tambien SELECT * FROM accounts;

3. Table

Una tabla organiza información en filas y columnas.

| id | name | balance |
|---|---|---|
| 1 | Nequi | 500000 |
| 2 | Bancolombia | 1200000 |
| 3 | Efectivo | 150000 |

4. Column

Una columna representa un atributo de los datos almacenados.

id       → INTEGER
name     → TEXT
balance  → NUMERIC

5. Row

Una fila representa un registro de la tabla.


1 | Nequi | 500000

primary key

La columna id puede funcionar como Primary Key (PK).

No admite valores NULL.
No permite valores duplicados.

6. Primary Key vs. Foreign Key

Una foreign key es una restricción que establece una relación entre tablas, haciendo que los valores de una columna (o conjunto de columnas) referencien valores existentes de una clave candidata de otra tabla

tabla users

| id (PK) | name |
|---|---|
| 1 | Carlos |
| 2 | María |

tabla accounts

| id (PK) | name | user_id (FK) |
|---|---|---|
| 1 | Nequi | 1 |
| 2 | Bancolombia | 1 |
| 3 | Nequi | 2 |

A esto lo llamamos una relación uno a muchos (1:N).

Un usuario puede tener muchas cuentas, mientras que cada cuenta pertenece a un único usuario, según las reglas de este ejemplo.

TIPOS DE DATOS

7. INTEGER

Almacena números enteros.

8. TEXT

Almacena texto de longitud variable.

9. NUMERIC

Permite representar números decimales exactos.

NUMERIC(12, 2) 

12: cantidad total máxima de dígitos.
2: cantidad de dígitos después del punto decimal.

10. BOOLEAN

TRUE
FALSE

11. DATE

Almacena fechas.

12. TIMESTAMP

Almacena fecha y hora.

12. 1 TIMESTAMPTZ: representa un instante absoluto y permite convertir su visualización entre zonas horarias.

PSQL

psql --version ver la version y saber si esta instalado

pg_isready Este comando comprueba si un servidor PostgreSQL acepta conexiones en la dirección y puerto indicados o, si no especificas ninguno, en los valores predeterminados.

psql -d postgres Este comando intenta conectarse a la base de datos llamada postgres, utilizando los valores de conexión predeterminados.

\l Muestra las bases de datos existentes.

\dn Muestra los schemas de la base de datos actual.

\dt Muestra las tablas visibles según el search_path de la sesión.

\conninfo Muestra información sobre la conexión actual.

SELECT current_database(), current_user; Esto permite consultar el nombre de la base de datos actual y el usuario de PostgreSQL conectado.

\q para salir