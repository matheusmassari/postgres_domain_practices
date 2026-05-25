-- TEMA: IN e NOT IN com subqueries

-- 1. Liste os clientes que pertencem a nações da região 'ASIA'.
--    Use IN com subquery — sem JOIN.
--    (dica: subquery em nation filtrando pela região, outra em region)

-- 2. Liste os fornecedores que NÃO pertencem a nações da região 'EUROPE'.
--    Use NOT IN com subquery.

-- 3. Liste os pedidos feitos por clientes do segmento 'AUTOMOBILE'.
--    Use IN com subquery — sem JOIN direto em orders.

-- 4. Liste as peças que foram enviadas pelo modo 'AIR' em algum momento.
--    (tabelas: part, lineitem — use IN)

-- 5. Liste os clientes que nunca fizeram um pedido com status 'F'.
--    (dica: NOT IN ou NOT EXISTS — implemente com NOT IN aqui)
--    Reflita: esse resultado seria diferente se houvesse NULLs em o_custkey?
