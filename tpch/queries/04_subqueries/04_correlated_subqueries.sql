-- TEMA: Subqueries correlacionadas — a subquery referencia a query externa

-- 1. Liste os pedidos cujo valor total está acima da média dos pedidos
--    do mesmo cliente.
--    (a subquery calcula a média por cliente usando o custkey da query externa)

-- 2. Liste os clientes cujo total de pedidos está acima da média
--    de pedidos dos clientes da mesma nação.
--    (dica: duas correlações — uma para o total do cliente, outra para a média da nação)

-- 3. Para cada fornecedor, mostre o nome e o custo de fornecimento
--    da peça mais cara que ele fornece.
--    (tabela: supplier, partsupp — subquery correlacionada com MAX)

-- 4. Liste os itens de lineitem cujo preço estendido está acima
--    da média dos itens do mesmo pedido.
--    (a subquery calcula a média por orderkey da query externa)

-- 5. Reescreva o exercício 1 usando JOIN + GROUP BY em vez de subquery correlacionada.
--    Compare a legibilidade e reflita sobre qual você prefere.
