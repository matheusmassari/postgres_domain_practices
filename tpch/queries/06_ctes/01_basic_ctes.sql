-- TEMA: CTEs básicas — organizando queries em etapas nomeadas

-- 1. Use uma CTE para calcular a receita bruta por cliente,
--    depois filtre apenas os clientes acima da média geral.
--    Mostre o nome do cliente e a receita.

-- 2. Use uma CTE para calcular o total de pedidos e o valor total
--    por nação. Na query externa, filtre apenas nações com mais de 6.000 pedidos.

-- 3. Use uma CTE para encontrar o pedido de maior valor de cada cliente.
--    Na query externa, mostre o nome do cliente, o orderkey e o valor.

-- 4. Refatore a query abaixo usando CTE:
--
--    SELECT s_name, total
--    FROM (
--        SELECT s.s_suppkey, s.s_name,
--               SUM(l.l_extendedprice * (1 - l.l_discount)) AS total
--        FROM lineitem l
--        JOIN supplier s ON l.l_suppkey = s.s_suppkey
--        GROUP BY s.s_suppkey, s.s_name
--    ) t
--    WHERE total > 4000000
--    ORDER BY total DESC;

-- 5. Use uma CTE para calcular a receita bruta por modo de envio por mês.
--    Na query externa, mostre apenas os meses em que o modo 'MAIL'
--    teve receita acima de 50.000.000.
