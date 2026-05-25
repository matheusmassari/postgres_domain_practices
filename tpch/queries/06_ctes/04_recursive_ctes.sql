-- TEMA: CTEs recursivas — sequências e hierarquias

-- 1. Gere uma sequência de números de 1 a 50 usando CTE recursiva.

-- 2. Gere todos os dias do mês de janeiro de 1995 usando CTE recursiva.
--    Mostre a data e o dia da semana correspondente.
--    (dica: TO_CHAR(data, 'Day'))

-- 3. Gere todos os meses entre 1993-01-01 e 1998-12-01.
--    Para cada mês, mostre a data e a receita bruta de lineitem naquele mês.
--    Use LEFT JOIN para incluir meses sem receita (receita = 0).
--    (dica: CTE recursiva para as datas, LEFT JOIN com subquery de receita)

-- 4. Gere os 12 meses de 1996 e calcule a receita bruta acumulada mês a mês.
--    Inclua meses com receita zero no acumulado.

-- 5. Calcule a série de Fibonacci até o 20º termo usando CTE recursiva.
--    (dica: a parte recursiva some os dois últimos valores —
--     use duas colunas: termo_atual e termo_anterior)
