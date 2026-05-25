-- TEMA: Scalar subqueries — subqueries que retornam um único valor

-- 1. Liste os pedidos cujo valor total está acima da média geral de todos os pedidos.
--    Mostre orderkey, custkey e totalprice.

-- 2. Liste os pedidos cujo valor total está acima da média geral.
--    Adicione uma coluna mostrando quanto cada pedido está acima da média.

-- 3. Liste os itens de lineitem com desconto acima do desconto médio geral.
--    Mostre orderkey, partkey, discount e a diferença para a média.

-- 4. Para cada pedido, mostre o orderkey, totalprice e o percentual
--    que ele representa em relação ao valor máximo de todos os pedidos.
--    (dica: scalar subquery no SELECT para o valor máximo)

-- 5. Qual é o cliente com o maior número de pedidos?
--    Mostre o nome do cliente e a quantidade de pedidos.
--    (dica: subquery com MAX aplicado a um COUNT)
