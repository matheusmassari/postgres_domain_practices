# JOINs em PostgreSQL

## Por que JOINs existem

Bancos relacionais armazenam dados em tabelas separadas para evitar repetição — isso se chama normalização. O nome da nação de um cliente não fica na tabela `customer`; fica na tabela `nation`, referenciada por uma chave (`c_nationkey`). O JOIN é o mecanismo que reconstrói essa informação na hora da consulta.

Sem JOIN você teria duas opções ruins: duplicar dados em todas as tabelas (desperdício e inconsistência) ou fazer múltiplas queries e juntar o resultado na aplicação (lento e trabalhoso).

---

## Anatomia de um JOIN

```sql
SELECT c.c_name, n.n_name
FROM customer c
JOIN nation n ON c.c_nationkey = n.n_nationkey;
```

- `FROM customer c` — tabela da esquerda (left table), alias `c`
- `JOIN nation n` — tabela da direita (right table), alias `n`
- `ON c.c_nationkey = n.n_nationkey` — condição de junção: como as linhas se relacionam

`JOIN` sem prefixo é equivalente a `INNER JOIN`. A palavra `INNER` é opcional.

---

## INNER JOIN

Retorna apenas as linhas que têm correspondência em **ambas** as tabelas. Se um cliente não tiver nação cadastrada, ele não aparece. Se uma nação não tiver clientes, ela não aparece.

```sql
SELECT c.c_name, n.n_name AS nacao
FROM customer c
INNER JOIN nation n ON c.c_nationkey = n.n_nationkey;
```

**Quando usar:** quando você quer apenas dados completos, com relacionamento garantido dos dois lados.

---

## LEFT JOIN

Retorna **todas** as linhas da tabela da esquerda. Para as linhas que não têm correspondência na tabela da direita, as colunas da direita aparecem como `NULL`.

```sql
SELECT c.c_name, o.o_orderkey
FROM customer c
LEFT JOIN orders o ON c.c_custkey = o.o_custkey;
```

Clientes sem pedidos aparecem com `o_orderkey = NULL`.

**Padrão clássico — encontrar ausências:**

```sql
-- Clientes que nunca fizeram um pedido
SELECT c.c_name
FROM customer c
LEFT JOIN orders o ON c.c_custkey = o.o_custkey
WHERE o.o_orderkey IS NULL;
```

A lógica: o LEFT JOIN traz todos os clientes. Onde não há pedido, `o_orderkey` é NULL. O `WHERE IS NULL` filtra apenas esses casos.

**Quando usar:** quando a tabela da esquerda é o seu ponto central e você quer preservar todos os seus registros, com ou sem correspondência.

---

## RIGHT JOIN

O espelho do LEFT JOIN — retorna **todas** as linhas da tabela da **direita**, com NULLs na esquerda onde não há correspondência.

```sql
SELECT c.c_name, n.n_name
FROM customer c
RIGHT JOIN nation n ON c.c_nationkey = n.n_nationkey;
```

Nações sem clientes aparecem com `c_name = NULL`.

Na prática, um RIGHT JOIN sempre pode ser reescrito como LEFT JOIN invertendo a ordem das tabelas — e é exatamente isso que a maioria dos desenvolvedores faz, pois LEFT JOIN é mais intuitivo de ler.

```sql
-- Equivalente ao RIGHT JOIN acima
SELECT c.c_name, n.n_name
FROM nation n
LEFT JOIN customer c ON c.c_nationkey = n.n_nationkey;
```

**Quando usar:** raramente em código novo. Útil quando você quer manter a ordem das tabelas de uma query existente mas precisa inverter a lógica de preservação.

---

## FULL OUTER JOIN

Retorna **todas** as linhas de **ambas** as tabelas. Onde não há correspondência de um lado, preenche com NULL.

```sql
SELECT n.n_name, c.c_name
FROM nation n
FULL OUTER JOIN customer c ON n.n_nationkey = c.c_nationkey;
```

Resultado: nações sem clientes (NULL no lado de customer) e clientes sem nação (NULL no lado de nation) aparecem todos.

**Quando usar:** para auditar integridade referencial, identificar registros órfãos em ambos os lados, ou comparar dois conjuntos de dados.

---

## Múltiplos JOINs

Você pode encadear quantos JOINs precisar. Cada JOIN adiciona uma tabela ao resultado.

```sql
-- cliente → nação → região
SELECT
    c.c_name    AS cliente,
    n.n_name    AS nacao,
    r.r_name    AS regiao
FROM customer c
JOIN nation n ON c.c_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey;
```

A ordem importa para legibilidade: siga a cadeia de relacionamentos de forma natural. O PostgreSQL otimiza a ordem de execução internamente independente de como você escreve.

---

## JOIN com condição composta

Algumas tabelas se relacionam por mais de uma coluna. No TPC-H, `lineitem` se conecta a `partsupp` por duas colunas simultaneamente:

```sql
SELECT l.l_orderkey, p.p_name, s.s_name
FROM lineitem l
JOIN partsupp ps ON l.l_partkey = ps.ps_partkey
                AND l.l_suppkey = ps.ps_suppkey
JOIN part     p  ON ps.ps_partkey = p.p_partkey
JOIN supplier s  ON ps.ps_suppkey = s.s_suppkey;
```

Se você omitir uma das condições do JOIN com `partsupp`, terá um produto cartesiano parcial — cada item de lineitem se juntaria com múltiplas linhas de partsupp, multiplicando as linhas do resultado incorretamente.

---

## Joining a mesma tabela duas vezes

Quando você precisa trazer informações da mesma tabela em papéis diferentes, usa aliases distintos para cada ocorrência.

No TPC-H, tanto clientes quanto fornecedores pertencem a nações. Para mostrar a nação do cliente e a nação do fornecedor na mesma query, você precisa fazer JOIN com `nation` duas vezes:

```sql
SELECT
    nc.n_name AS nacao_cliente,
    ns.n_name AS nacao_fornecedor,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS receita_bruta
FROM lineitem l
JOIN orders   o  ON l.l_orderkey  = o.o_orderkey
JOIN customer c  ON o.o_custkey   = c.c_custkey
JOIN nation   nc ON c.c_nationkey = nc.n_nationkey   -- nação do cliente
JOIN supplier s  ON l.l_suppkey   = s.s_suppkey
JOIN nation   ns ON s.s_nationkey = ns.n_nationkey   -- nação do fornecedor
GROUP BY nc.n_name, ns.n_name
ORDER BY receita_bruta DESC;
```

`nc` e `ns` são dois aliases para a mesma tabela `nation`, atuando em papéis diferentes.

---

## JOIN + GROUP BY

O padrão mais comum em análise: juntar tabelas para ter acesso às dimensões e agregar as métricas.

```sql
-- Receita bruta total por região
SELECT
    r.r_name                                            AS regiao,
    SUM(l.l_extendedprice * (1 - l.l_discount))        AS receita_bruta
FROM lineitem l
JOIN orders   o ON l.l_orderkey  = o.o_orderkey
JOIN customer c ON o.o_custkey   = c.c_custkey
JOIN nation   n ON c.c_nationkey = n.n_nationkey
JOIN region   r ON n.n_regionkey = r.r_regionkey
GROUP BY r.r_name
ORDER BY receita_bruta DESC;
```

**Regra:** toda coluna no SELECT que não está dentro de uma função de agregação precisa estar no GROUP BY.

---

## Armadilhas comuns

**1. Multiplicação de linhas**

Se a condição de JOIN não for seletiva o suficiente, uma linha da esquerda pode se juntar com várias da direita, multiplicando o resultado. Sempre verifique o volume esperado de linhas.

**2. JOIN sem condição (produto cartesiano)**

```sql
-- CUIDADO: sem ON, cada linha de A se junta com cada linha de B
SELECT * FROM customer, nation;  -- 150.000 × 25 = 3.750.000 linhas
```

Isso raramente é o que você quer. Sempre especifique a condição `ON`.

**3. NULL em condições de JOIN**

`NULL = NULL` é `NULL` (não `TRUE`) em SQL. Linhas com NULL na coluna de JOIN não se conectam com nenhuma outra linha. Se você precisa incluí-las, use `COALESCE` ou `IS NOT DISTINCT FROM`.

**4. Ambiguidade de colunas**

Quando duas tabelas têm colunas com o mesmo nome, qualificar com o alias da tabela é obrigatório:

```sql
-- Erro: column "n_name" is ambiguous
SELECT n_name FROM nation JOIN ...;

-- Correto
SELECT n.n_name FROM nation n JOIN ...;
```

---

## Resumo visual

```
INNER JOIN          LEFT JOIN           RIGHT JOIN          FULL OUTER JOIN
  A ∩ B               A                   B                   A ∪ B
  [A●B]             [A●b]               [a●B]               [A●B]
```

| Tipo | Preserva esquerda | Preserva direita |
|---|---|---|
| INNER | Não | Não |
| LEFT | Sim | Não |
| RIGHT | Não | Sim |
| FULL OUTER | Sim | Sim |
