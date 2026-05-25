-- TEMA: Totais acumulados e médias móveis

-- 1. Mostre a receita bruta mensal e o total acumulado desde o início.
--    Ordene cronologicamente.
--    (SUM OVER com ORDER BY e frame padrão)

-- 2. Mostre a receita bruta diária de 1995 e o acumulado do ano até cada dia.
--    (dica: filtre o ano no WHERE, acumule com SUM OVER ORDER BY dia)

-- 3. Para cada cliente, mostre o valor de cada pedido e o total acumulado
--    de quanto ele gastou até aquele pedido (ordenado por data).

-- 4. Mostre a receita bruta mensal de 1994 a 1996 com a média móvel
--    dos últimos 3 meses para cada mês.
--    (dica: ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)

-- 5. Mostre a receita bruta por nação e a porcentagem acumulada
--    que cada nação representa no total global, ordenado do maior para o menor.
--    (dica: SUM acumulado / SUM total — two window functions)
