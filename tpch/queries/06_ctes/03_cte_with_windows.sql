-- TEMA: CTEs + Window Functions — combinando os dois recursos

-- 1. Use uma CTE para calcular a receita bruta mensal.
--    Na query externa, adicione com window function:
--    - o total acumulado mês a mês
--    - a variação em relação ao mês anterior (LAG)

-- 2. Use uma CTE para calcular a receita por cliente.
--    Na query externa, use RANK() para rankear os clientes globalmente
--    e dentro de cada nação.
--    Mostre apenas os top 5 por nação.

-- 3. Use uma CTE para calcular a receita por fornecedor por ano.
--    Na query externa, use LAG para comparar cada ano com o anterior
--    dentro do mesmo fornecedor.
--    Mostre apenas fornecedores que tiveram queda de receita em algum ano.

-- 4. Use uma CTE para calcular o ticket médio por segmento.
--    Na query externa, calcule o PERCENT_RANK de cada segmento
--    e classifique como 'premium', 'medio' ou 'basico'.

-- 5. Pipeline completo com 3 CTEs + window function:
--    - CTE 1: receita bruta mensal por região
--    - CTE 2: variação mês a mês por região (LAG)
--    - CTE 3: rank de crescimento por mês entre regiões
--    Query final: mostre os meses em que cada região liderou o crescimento.
