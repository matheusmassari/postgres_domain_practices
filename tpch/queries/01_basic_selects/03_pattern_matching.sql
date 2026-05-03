-- TEMA: LIKE, ILIKE e busca por padrões
-- Tabelas sugeridas: customer, part, supplier


-- 1. Selecione os clientes cujo nome começa com "Customer#00000001".

select * from customer
where c_name like 'Customer#00000001%';

-- 2. Selecione as peças (part) cujo tipo contém a palavra "STEEL".

select * from part
where p_type like '%STEEL%';

-- 3. Selecione os fornecedores (supplier) cujo comentário termina
--    com a palavra "requests.".

select * from supplier
where s_comment like '%requests';

-- 4. Selecione as peças cujo container começa com "LG".
--    Repita a query usando ILIKE e veja se o resultado muda.

select * from part
where p_container ilike 'lg%';









