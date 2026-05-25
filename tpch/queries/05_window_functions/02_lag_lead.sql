-- TEMA: LAG e LEAD — acessando linhas vizinhas

-- 1. Mostre a receita bruta mensal e a receita do mês anterior lado a lado.
--    Receita bruta = extendedprice * (1 - discount) — use lineitem e l_shipdate.
--    (dica: DATE_TRUNC por mês, LAG sobre o SUM)

-- 2. A partir do exercício anterior, adicione uma coluna com a variação
--    em valor absoluto e outra com a variação percentual em relação ao mês anterior.
--    Trate o caso onde o mês anterior é NULL (primeiro mês).

-- 3. Para cada cliente, mostre a data e o valor do pedido atual
--    e do pedido imediatamente anterior (ordenado por data).
--    Mostre apenas clientes que têm ao menos 2 pedidos.

-- 4. Mostre a receita bruta por ano e o crescimento em relação ao ano anterior.
--    Calcule também se o ano foi de crescimento ou queda.

-- 5. Para cada modo de envio (shipmode), mostre a quantidade de itens por mês
--    e a diferença em relação ao mês anterior dentro do mesmo shipmode.
--    (dica: PARTITION BY shipmode, ORDER BY mês)
