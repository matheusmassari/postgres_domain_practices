-- TEMA: JOIN + GROUP BY + HAVING — combinando relacionamentos com agregações

-- 1. Qual é o total de pedidos e o valor total por nação do cliente?
--    Ordene pelo valor total decrescente.
--    (tabelas: orders, customer, nation)

-- 2. Qual é a receita bruta total por região?
--    Receita bruta = extendedprice * (1 - discount)
--    (tabelas: lineitem, orders, customer, nation, region)

-- 3. Quais clientes têm mais de 15 pedidos?
--    Mostre o nome do cliente, a nação e a quantidade de pedidos.
--    (tabelas: orders, customer, nation)

-- 4. Qual é o ticket médio por segmento de mercado?
--    Agora com JOIN — use customer para trazer o segmento.
--    (tabelas: orders, customer)

-- 5. Quais fornecedores têm receita bruta total acima de 4.000.000?
--    Mostre o nome do fornecedor, a nação e a receita total.
--    Receita bruta = extendedprice * (1 - discount)
--    (tabelas: lineitem, supplier, nation)
