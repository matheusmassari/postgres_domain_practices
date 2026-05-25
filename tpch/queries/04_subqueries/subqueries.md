# Subqueries em PostgreSQL

## O que é uma subquery

Uma subquery é uma consulta dentro de outra consulta. O resultado da subquery interna é usado pela query externa como se fosse um valor, uma lista ou uma tabela.

```sql
SELECT c_name
FROM customer
WHERE c_nationkey = (SELECT n_nationkey FROM nation WHERE n_name = 'BRAZIL');
```

A subquery `(SELECT n_nationkey ...)` é executada primeiro e retorna um valor, que a query externa usa no `WHERE`.

---

## Tipos por posição

### No WHERE — scalar subquery
Retorna um único valor e é usada em comparações:

```sql
SELECT o_orderkey, o_totalprice
FROM orders
WHERE o_totalprice > (SELECT AVG(o_totalprice) FROM orders);
```

### No WHERE — subquery com IN
Retorna uma lista de valores:

```sql
SELECT c_name
FROM customer
WHERE c_nationkey IN (
    SELECT n_nationkey FROM nation WHERE n_regionkey = 1
);
```

### No FROM — derived table
Retorna uma tabela que a query externa consulta:

```sql
SELECT avg_por_nacao.n_name, avg_por_nacao.media
FROM (
    SELECT n.n_name, AVG(o.o_totalprice) AS media
    FROM orders o
    JOIN customer c ON o.o_custkey   = c.c_custkey
    JOIN nation   n ON c.c_nationkey = n.n_nationkey
    GROUP BY n.n_name
) AS avg_por_nacao
WHERE avg_por_nacao.media > 150000;
```

### No SELECT — scalar subquery como coluna
Retorna um único valor por linha:

```sql
SELECT
    o_orderkey,
    o_totalprice,
    (SELECT AVG(o2.o_totalprice) FROM orders o2) AS media_geral,
    o_totalprice - (SELECT AVG(o2.o_totalprice) FROM orders o2) AS diferenca_da_media
FROM orders;
```

---

## Subqueries correlacionadas vs não-correlacionadas

### Não-correlacionada
A subquery é independente — executa uma vez e retorna sempre o mesmo resultado:

```sql
-- A subquery não depende de nada da query externa
SELECT o_orderkey, o_totalprice
FROM orders
WHERE o_totalprice > (SELECT AVG(o_totalprice) FROM orders);
```

### Correlacionada
A subquery referencia uma coluna da query externa — executa uma vez para cada linha:

```sql
-- A subquery usa c.c_custkey da query externa
SELECT c_name
FROM customer c
WHERE (
    SELECT COUNT(*) FROM orders o WHERE o.o_custkey = c.c_custkey
) > 20;
```

Subqueries correlacionadas são poderosas mas podem ser lentas em tabelas grandes — o PostgreSQL as executa uma vez por linha da query externa. CTEs e JOINs costumam ser alternativas mais eficientes.

---

## EXISTS e NOT EXISTS

`EXISTS` verifica se a subquery retorna ao menos uma linha. Não importa o valor retornado — só a existência.

```sql
-- Clientes que fizeram ao menos um pedido urgente
SELECT c_name
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.o_custkey   = c.c_custkey
      AND o.o_orderpriority = '1-URGENT'
);
```

`NOT EXISTS` — o inverso: linhas onde a subquery não retorna nada:

```sql
-- Clientes que nunca fizeram pedido urgente
SELECT c_name
FROM customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.o_custkey   = c.c_custkey
      AND o.o_orderpriority = '1-URGENT'
);
```

O `SELECT 1` é convencional — o valor retornado não importa para o `EXISTS`.

---

## IN vs EXISTS

Funcionalmente similares em muitos casos, mas com diferenças:

| | IN | EXISTS |
|---|---|---|
| Performance com NULLs | `IN (NULL, ...)` pode dar resultados inesperados | Não tem esse problema |
| Correlação | Geralmente não-correlacionado | Geralmente correlacionado |
| Semântica | "O valor está nessa lista?" | "Existe ao menos uma linha?" |

Prefira `EXISTS` quando a subquery pode retornar NULLs ou quando você está verificando existência sem se importar com o valor.

---

## NOT IN com NULLs — armadilha importante

```sql
-- Se a subquery retornar qualquer NULL, a query toda retorna vazio
SELECT c_name
FROM customer
WHERE c_nationkey NOT IN (SELECT n_nationkey FROM nation WHERE n_name = 'BRAZIL');
```

Se `n_nationkey` tiver algum NULL, `NOT IN` retorna `NULL` para todas as comparações, resultando em zero linhas. Use `NOT EXISTS` para evitar esse comportamento.

---

## Quando usar subquery vs JOIN vs CTE

| Situação | Preferir |
|---|---|
| Verificar existência | EXISTS |
| Filtrar por lista de IDs | IN ou JOIN |
| Resultado de agregação como filtro | Subquery no WHERE |
| Resultado de agregação como tabela | CTE ou subquery no FROM |
| Lógica reutilizada múltiplas vezes na query | CTE |
| Comparar cada linha com um valor calculado da própria tabela | Subquery correlacionada ou window function |
