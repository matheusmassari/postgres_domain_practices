-- TEMA: FULL OUTER JOIN e padrões avançados

-- FULL OUTER JOIN: retorna todas as linhas de ambas as tabelas.
-- Onde não há correspondência, preenche com NULL dos dois lados.

-- 1. Faça um FULL OUTER JOIN entre nation e customer.
--    Mostre nações sem clientes E clientes sem nação cadastrada.
--    (No TPC-H todos os clientes têm nação — reflita sobre o que aparece no resultado)

select * 
from customer c 
full outer join nation n on c.c_nationkey = n.n_nationkey
where c.c_custkey is null
or n.n_nationkey is null;

-- 2. Liste os fornecedores e os clientes que pertencem à mesma nação.
--    Mostre: nome da nação, nome do fornecedor, nome do cliente.
--    (tabelas: nation, supplier, customer)
--    (dica: junte supplier e customer separadamente à nation)

 SELECT
     n.n_name AS nation,
     s.s_name AS supplier,
     c.c_name AS customer
 FROM nation n
 JOIN supplier s ON s.s_nationkey = n.n_nationkey
 JOIN customer c ON c.c_nationkey = n.n_nationkey;

-- 3. Encontre peças que nunca foram pedidas por nenhum cliente.
--    (tabelas: part, lineitem — LEFT JOIN + IS NULL)
 
 SELECT p.p_partkey, p.p_name
 FROM part p
 LEFT JOIN lineitem l ON p.p_partkey = l.l_partkey
 WHERE l.l_orderkey IS NULL;

-- 4. Liste os 10 clientes com maior receita bruta gerada em pedidos,
--    incluindo o nome da nação de cada um.
--    Receita bruta = extendedprice * (1 - discount)
--    (tabelas: customer, orders, lineitem, nation)

SELECT
     c.c_name                                         AS customer,
     n.n_name                                         AS nation,
     SUM(l.l_extendedprice * (1 - l.l_discount))     AS receita_bruta
FROM lineitem l
JOIN orders   o ON l.l_orderkey  = o.o_orderkey
JOIN customer c ON o.o_custkey   = c.c_custkey
JOIN nation   n ON c.c_nationkey = n.n_nationkey
GROUP BY c.c_custkey, c.c_name, n.n_name
ORDER BY receita_bruta DESC
LIMIT 10;
 
-- 5. Para cada par (nação do cliente, nação do fornecedor),
--    mostre a receita bruta total das transações entre eles.
--    Ordene pela receita decrescente. Mostre os 10 maiores pares.
--    (tabelas: lineitem, orders, customer, nation c_nation,
--              supplier, nation s_nation)
--    (dica: você vai precisar fazer JOIN com a tabela nation duas vezes
--     usando aliases diferentes: ex. nation nc e nation ns)

  SELECT
      nc.n_name                                        AS nacao_cliente,
      ns.n_name                                        AS nacao_fornecedor,
      SUM(l.l_extendedprice * (1 - l.l_discount))     AS receita_bruta
  FROM lineitem l
  JOIN orders   o  ON l.l_orderkey  = o.o_orderkey
  JOIN customer c  ON o.o_custkey   = c.c_custkey
  JOIN nation   nc ON c.c_nationkey = nc.n_nationkey
  JOIN supplier s  ON l.l_suppkey   = s.s_suppkey
  JOIN nation   ns ON s.s_nationkey = ns.n_nationkey
  GROUP BY nc.n_name, ns.n_name
  ORDER BY receita_bruta DESC
  LIMIT 10;