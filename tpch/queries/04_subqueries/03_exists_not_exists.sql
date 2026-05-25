-- TEMA: EXISTS e NOT EXISTS

-- 1. Liste os clientes que fizeram ao menos um pedido com valor acima de 300.000.
--    Use EXISTS.

-- 2. Liste os clientes que NUNCA fizeram um pedido.
--    Use NOT EXISTS.
--    Compare o resultado com o LEFT JOIN + IS NULL do capítulo anterior.

-- 3. Liste os fornecedores que fornecem ao menos uma peça do tipo 'ECONOMY ANODIZED STEEL'.
--    (tabelas: supplier, partsupp, part — use EXISTS)

-- 4. Liste as peças que foram pedidas por clientes de ao menos duas regiões diferentes.
--    (dica: subquery com COUNT DISTINCT de regiões)

-- 5. Liste os clientes que fizeram pedidos urgentes ('1-URGENT')
--    mas NUNCA fizeram pedidos de baixa prioridade ('5-LOW').
--    (dica: EXISTS + NOT EXISTS combinados)
