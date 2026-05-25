-- TEMA: PARTITION BY — janelas dentro de grupos

-- 1. Para cada pedido, mostre o valor total e quanto ele representa
--    do total de pedidos daquele cliente (percentual por cliente).

-- 2. Para cada item de lineitem, mostre o preço estendido e a média
--    dos preços estendidos dentro do mesmo pedido.
--    Adicione uma coluna indicando se o item está acima ou abaixo da média do pedido.

-- 3. Para cada nação, mostre o total de receita bruta por ano
--    e a participação percentual daquele ano dentro da nação.
--    (dica: SUM por ano / SUM total da nação — PARTITION BY nação)

-- 4. Mostre cada fornecedor com sua receita bruta total e o ranking
--    dentro da sua nação (do maior para o menor).
--    Inclua apenas o top 3 por nação.

-- 5. Para cada segmento de mercado, mostre o ticket médio por cliente
--    e a diferença de cada cliente em relação à média do seu segmento.
--    (dica: AVG OVER PARTITION BY mktsegment)
