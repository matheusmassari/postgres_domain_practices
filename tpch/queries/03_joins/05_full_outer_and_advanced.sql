-- TEMA: FULL OUTER JOIN e padrões avançados

-- FULL OUTER JOIN: retorna todas as linhas de ambas as tabelas.
-- Onde não há correspondência, preenche com NULL dos dois lados.

-- 1. Faça um FULL OUTER JOIN entre nation e customer.
--    Mostre nações sem clientes E clientes sem nação cadastrada.
--    (No TPC-H todos os clientes têm nação — reflita sobre o que aparece no resultado)

-- 2. Liste os fornecedores e os clientes que pertencem à mesma nação.
--    Mostre: nome da nação, nome do fornecedor, nome do cliente.
--    (tabelas: nation, supplier, customer)
--    (dica: junte supplier e customer separadamente à nation)

-- 3. Encontre peças que nunca foram pedidas por nenhum cliente.
--    (tabelas: part, lineitem — LEFT JOIN + IS NULL)

-- 4. Liste os 10 clientes com maior receita bruta gerada em pedidos,
--    incluindo o nome da nação de cada um.
--    Receita bruta = extendedprice * (1 - discount)
--    (tabelas: customer, orders, lineitem, nation)

-- 5. Para cada par (nação do cliente, nação do fornecedor),
--    mostre a receita bruta total das transações entre eles.
--    Ordene pela receita decrescente. Mostre os 10 maiores pares.
--    (tabelas: lineitem, orders, customer, nation c_nation,
--              supplier, nation s_nation)
--    (dica: você vai precisar fazer JOIN com a tabela nation duas vezes
--     usando aliases diferentes: ex. nation nc e nation ns)
