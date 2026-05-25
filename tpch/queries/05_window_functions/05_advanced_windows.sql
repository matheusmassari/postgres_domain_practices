-- TEMA: NTILE, PERCENT_RANK, FIRST_VALUE, LAST_VALUE

-- 1. Divida os clientes em 4 quartis pelo saldo (acctbal).
--    Mostre o nome, saldo e o quartil de cada cliente.
--    (NTILE(4) OVER ORDER BY acctbal)

-- 2. Para cada pedido, calcule o PERCENT_RANK do seu valor total
--    entre todos os pedidos. Mostre apenas os pedidos no top 1%.
--    (PERCENT_RANK > 0.99)

-- 3. Para cada cliente, mostre o primeiro e o último pedido que ele fez
--    (por data) usando FIRST_VALUE e LAST_VALUE.
--    Inclua o valor de cada um.
--    (lembre-se do frame necessário para LAST_VALUE)

-- 4. Classifique os fornecedores em decis (10 grupos) pelo total
--    de receita bruta gerada. Mostre a receita média de cada decil.
--    (dica: NTILE(10) em subquery, depois GROUP BY decil)

-- 5. Para cada mês de 1995, mostre a receita bruta e a distribuição
--    acumulada (CUME_DIST) daquele mês em relação a todos os meses
--    da série histórica.
