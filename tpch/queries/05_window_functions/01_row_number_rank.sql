-- TEMA: ROW_NUMBER, RANK, DENSE_RANK

-- 1. Para cada cliente, numere seus pedidos em ordem cronológica.
--    Mostre custkey, orderkey, orderdate e o número sequencial.
--    (ROW_NUMBER particionado por custkey, ordenado por orderdate)

-- 2. Rankeie todos os clientes pela receita bruta total que geraram.
--    Mostre o rank, o nome do cliente e a receita bruta.
--    Receita bruta = extendedprice * (1 - discount)
--    (dica: calcule a receita por cliente primeiro, depois aplique RANK)

-- 3. Para cada nação, liste os 3 clientes com maior saldo (acctbal).
--    Mostre nação, nome do cliente, saldo e posição dentro da nação.
--    (dica: ROW_NUMBER particionado por nationkey, filtrado por rn <= 3)

-- 4. Rankeie as peças (part) pelo preço de varejo (retailprice) usando
--    RANK e DENSE_RANK. Mostre os dois lado a lado para observar a diferença
--    quando há empates.

-- 5. Para cada segmento de mercado, liste o cliente com o maior saldo.
--    Mostre segmento, nome do cliente e saldo.
--    (dica: ROW_NUMBER particionado por mktsegment, filtrado por rn = 1)
