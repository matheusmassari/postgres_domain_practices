-- TEMA: Subqueries no FROM — derived tables

-- 1. Encontre as nações cujo ticket médio de pedidos está acima
--    da média geral dos tickets médios por nação.
--    (dica: calcule o ticket médio por nação em uma subquery no FROM,
--     depois filtre no WHERE externo)

-- 2. Para cada segmento de mercado, mostre o segmento,
--    o ticket médio e uma coluna indicando se está
--    acima ou abaixo da média geral dos segmentos.
--    (dica: subquery no FROM para calcular médias por segmento,
--     scalar subquery no SELECT para a média geral)

-- 3. Liste os 5 clientes com maior receita bruta,
--    mostrando o percentual que cada um representa
--    sobre o total de receita bruta de todos os clientes.
--    Receita bruta = extendedprice * (1 - discount)
--    (dica: subquery no FROM para receita por cliente,
--     scalar subquery para o total geral)

-- 4. Mostre por modo de envio (shipmode) a quantidade de itens,
--    a receita bruta e o ranking do shipmode por receita.
--    (dica: subquery no FROM calculando as métricas,
--     ORDER BY no exterior para o ranking visual)

-- 5. Para cada nação, mostre o nome, a receita bruta total
--    e a posição dela no ranking global de receita.
--    Inclua apenas as top 10 nações.
--    (dica: subquery no FROM + ORDER BY + LIMIT)
