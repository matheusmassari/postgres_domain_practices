# CTEs em PostgreSQL

## O que é uma CTE

CTE (Common Table Expression) é uma query nomeada temporária definida com a cláusula `WITH`, disponível apenas durante a execução da query principal. Funciona como uma tabela temporária que existe só para aquela consulta.

```sql
WITH receita_por_nacao AS (
    SELECT n.n_name, SUM(l.l_extendedprice * (1 - l.l_discount)) AS receita
    FROM lineitem l
    JOIN orders   o ON l.l_orderkey  = o.o_orderkey
    JOIN customer c ON o.o_custkey   = c.c_custkey
    JOIN nation   n ON c.c_nationkey = n.n_nationkey
    GROUP BY n.n_name
)
SELECT * FROM receita_por_nacao WHERE receita > 100000000;
```

---

## CTEs múltiplas

Você pode encadear múltiplas CTEs separadas por vírgula. Cada CTE pode referenciar as anteriores:

```sql
WITH
receita_por_cliente AS (
    SELECT o.o_custkey, SUM(l.l_extendedprice * (1 - l.l_discount)) AS receita
    FROM lineitem l
    JOIN orders o ON l.l_orderkey = o.o_orderkey
    GROUP BY o.o_custkey
),
clientes_acima_da_media AS (
    SELECT o_custkey, receita
    FROM receita_por_cliente
    WHERE receita > (SELECT AVG(receita) FROM receita_por_cliente)
)
SELECT c.c_name, cam.receita
FROM clientes_acima_da_media cam
JOIN customer c ON cam.o_custkey = c.c_custkey
ORDER BY cam.receita DESC;
```

---

## CTE vs Subquery vs View

| | CTE | Subquery no FROM | View |
|---|---|---|---|
| Reutilização na mesma query | Sim (múltiplas referências) | Não | Sim |
| Persistência | Não (só na query) | Não | Sim (no banco) |
| Legibilidade | Alta | Média | Alta |
| Recursão | Sim | Não | Não |
| Materialização | Depende (PostgreSQL decide) | Não | Não |

**Prefira CTE quando:**
- A lógica é referenciada mais de uma vez na query
- A query ficaria muito aninhada com subqueries
- Você quer nomear etapas intermediárias para legibilidade
- Precisa de recursão

**Prefira subquery quando:**
- É usada apenas uma vez e é simples
- Você quer garantir que não há materialização intermediária

---

## Materialização no PostgreSQL

No PostgreSQL 12+, CTEs são **não-materializadas por padrão** — o planner decide se computa a CTE uma vez ou a integra inline como subquery. Você pode forçar o comportamento:

```sql
WITH cte AS MATERIALIZED (...)      -- força materialização (computa uma vez)
WITH cte AS NOT MATERIALIZED (...)  -- força inline (pode ser recomputada)
```

Na prática, o planner geralmente toma a decisão correta. Use `EXPLAIN ANALYZE` para verificar.

---

## CTEs recursivas

CTEs recursivas processam dados hierárquicos ou geram sequências. Têm duas partes separadas por `UNION ALL`:

```sql
WITH RECURSIVE contagem AS (
    SELECT 1 AS n          -- parte inicial (âncora)
    UNION ALL
    SELECT n + 1           -- parte recursiva
    FROM contagem
    WHERE n < 10           -- condição de parada
)
SELECT * FROM contagem;
```

### Estrutura obrigatória:
1. **Parte âncora**: a query inicial, não recursiva
2. **UNION ALL**: separa as duas partes (UNION remove duplicatas, raramente desejado)
3. **Parte recursiva**: referencia a própria CTE
4. **Condição de parada**: evita recursão infinita

### Exemplo com hierarquia — gerando série de datas:

```sql
WITH RECURSIVE datas AS (
    SELECT DATE '1993-01-01' AS dia
    UNION ALL
    SELECT dia + 1 FROM datas WHERE dia < '1993-01-31'
)
SELECT * FROM datas;
```

---

## Padrão: refatorando subqueries em CTEs

**Antes — difícil de ler:**
```sql
SELECT *
FROM (
    SELECT n_name, AVG(receita) AS media_receita
    FROM (
        SELECT n.n_name, SUM(l.l_extendedprice * (1 - l.l_discount)) AS receita
        FROM lineitem l
        JOIN orders o   ON l.l_orderkey  = o.o_orderkey
        JOIN customer c ON o.o_custkey   = c.c_custkey
        JOIN nation n   ON c.c_nationkey = n.n_nationkey
        GROUP BY n.n_name, o.o_custkey
    ) t
    GROUP BY n_name
) t2
WHERE media_receita > 50000;
```

**Depois — legível:**
```sql
WITH
receita_por_cliente AS (
    SELECT n.n_name, o.o_custkey, SUM(l.l_extendedprice * (1 - l.l_discount)) AS receita
    FROM lineitem l
    JOIN orders   o ON l.l_orderkey  = o.o_orderkey
    JOIN customer c ON o.o_custkey   = c.c_custkey
    JOIN nation   n ON c.c_nationkey = n.n_nationkey
    GROUP BY n.n_name, o.o_custkey
),
media_por_nacao AS (
    SELECT n_name, AVG(receita) AS media_receita
    FROM receita_por_cliente
    GROUP BY n_name
)
SELECT * FROM media_por_nacao WHERE media_receita > 50000;
```
