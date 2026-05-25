# Window Functions em PostgreSQL

## O que são window functions

Window functions calculam valores sobre um conjunto de linhas relacionadas à linha atual — sem colapsar o resultado como o `GROUP BY` faz. Cada linha mantém sua identidade no resultado.

```sql
-- GROUP BY: colapsa em 1 linha por grupo
SELECT o_custkey, SUM(o_totalprice) FROM orders GROUP BY o_custkey;

-- Window function: mantém todas as linhas, adiciona o total como coluna
SELECT o_orderkey, o_custkey, o_totalprice,
       SUM(o_totalprice) OVER (PARTITION BY o_custkey) AS total_cliente
FROM orders;
```

---

## Anatomia: a cláusula OVER

```sql
função() OVER (
    PARTITION BY coluna    -- divide em grupos (opcional)
    ORDER BY coluna        -- ordena dentro do grupo (obrigatório para rank/lag/lead)
    ROWS/RANGE BETWEEN ... -- define o frame (opcional)
)
```

- **Sem PARTITION BY**: a janela é a tabela inteira
- **Com PARTITION BY**: a janela reinicia para cada grupo
- **ORDER BY dentro do OVER**: define a ordem para ranking e acumulações

---

## Funções de ranking

### ROW_NUMBER
Número sequencial único por linha — sem empates:

```sql
SELECT
    o_custkey,
    o_orderkey,
    o_totalprice,
    ROW_NUMBER() OVER (PARTITION BY o_custkey ORDER BY o_totalprice DESC) AS rn
FROM orders;
```

### RANK
Permite empates — pula posições após empate (1, 2, 2, 4):

```sql
RANK() OVER (ORDER BY o_totalprice DESC)
```

### DENSE_RANK
Permite empates — não pula posições (1, 2, 2, 3):

```sql
DENSE_RANK() OVER (ORDER BY o_totalprice DESC)
```

### Padrão clássico: top N por grupo

```sql
SELECT * FROM (
    SELECT
        o_custkey,
        o_orderkey,
        o_totalprice,
        ROW_NUMBER() OVER (PARTITION BY o_custkey ORDER BY o_totalprice DESC) AS rn
    FROM orders
) t
WHERE rn <= 3;  -- top 3 pedidos por cliente
```

---

## LAG e LEAD

Acessam o valor de uma linha anterior (LAG) ou posterior (LEAD) na janela:

```sql
LAG(coluna, offset, default)  OVER (ORDER BY ...)
LEAD(coluna, offset, default) OVER (ORDER BY ...)
```

```sql
SELECT
    DATE_TRUNC('month', o_orderdate)::date AS mes,
    SUM(o_totalprice)                       AS receita,
    LAG(SUM(o_totalprice)) OVER (ORDER BY DATE_TRUNC('month', o_orderdate)) AS receita_mes_anterior,
    SUM(o_totalprice) - LAG(SUM(o_totalprice)) OVER (ORDER BY DATE_TRUNC('month', o_orderdate)) AS variacao
FROM orders
GROUP BY mes
ORDER BY mes;
```

---

## Funções de agregação como window functions

Qualquer função de agregação pode ser usada com `OVER`:

```sql
SUM(o_totalprice)   OVER (PARTITION BY o_custkey ORDER BY o_orderdate)  -- acumulado
AVG(o_totalprice)   OVER (PARTITION BY o_custkey)                        -- média do cliente
COUNT(*)            OVER (PARTITION BY o_custkey)                        -- total de pedidos do cliente
MAX(o_totalprice)   OVER ()                                              -- máximo global
```

### Total acumulado (running total)

```sql
SELECT
    o_orderdate,
    o_totalprice,
    SUM(o_totalprice) OVER (ORDER BY o_orderdate) AS acumulado
FROM orders;
```

### Média móvel (moving average)

```sql
SELECT
    o_orderdate,
    o_totalprice,
    AVG(o_totalprice) OVER (
        ORDER BY o_orderdate
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW  -- média das últimas 7 linhas
    ) AS media_movel_7
FROM orders;
```

---

## Frame clause: ROWS vs RANGE

O frame define quais linhas participam do cálculo para cada linha:

```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW  -- do início até a linha atual
ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING          -- 2 antes + atual + 2 depois
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW -- padrão quando ORDER BY existe
```

`ROWS` conta linhas físicas. `RANGE` considera o valor — útil quando há empates de datas.

---

## NTILE, PERCENT_RANK e CUME_DIST

```sql
NTILE(4)       OVER (ORDER BY o_totalprice)  -- divide em quartis (1, 2, 3, 4)
PERCENT_RANK() OVER (ORDER BY o_totalprice)  -- posição percentual (0 a 1)
CUME_DIST()    OVER (ORDER BY o_totalprice)  -- distribuição acumulada (0 a 1)
```

---

## FIRST_VALUE e LAST_VALUE

```sql
FIRST_VALUE(o_totalprice) OVER (PARTITION BY o_custkey ORDER BY o_orderdate)
LAST_VALUE(o_totalprice)  OVER (
    PARTITION BY o_custkey ORDER BY o_orderdate
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING  -- necessário para LAST_VALUE
)
```

`LAST_VALUE` requer o frame explícito pois por padrão o frame vai só até a linha atual.

---

## Window functions vs GROUP BY

| | GROUP BY | Window Function |
|---|---|---|
| Linhas no resultado | Uma por grupo | Uma por linha original |
| Acesso às colunas originais | Só colunas agrupadas | Todas as colunas |
| Pode combinar com GROUP BY | — | Sim (window function é calculada depois do GROUP BY) |

---

## Ordem de execução

Window functions são calculadas **depois** do `WHERE`, `GROUP BY` e `HAVING`, mas **antes** do `ORDER BY` final e `LIMIT`. Por isso você não pode usar uma window function no `WHERE` diretamente — precisa de uma subquery ou CTE.

```sql
-- ERRO: não pode filtrar por window function no WHERE
SELECT *, ROW_NUMBER() OVER (...) AS rn FROM orders WHERE rn = 1;

-- CORRETO: envolva em subquery ou CTE
SELECT * FROM (
    SELECT *, ROW_NUMBER() OVER (...) AS rn FROM orders
) t WHERE rn = 1;
```
