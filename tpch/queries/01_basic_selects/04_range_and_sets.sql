-- TEMA: BETWEEN, IN e NOT IN
-- Tabelas sugeridas: orders, lineitem, customer, nation

-- 1. Selecione os pedidos feitos entre '1995-01-01' e '1995-12-31'.

select * from orders
where o_orderdate between '1995-01-01' and '1995-12-31';

-- 2. Selecione os itens de lineitem com desconto entre 0.05 e 0.08 (inclusive).

select * from lineitem
where l_discount between 0.05 and 0.08;

-- 3. Selecione os clientes que pertencem às nações de nationkey 1, 5, 10 e 15.

select * from customer
where c_nationkey in ('1', '5', '10', '15');

-- 4. Selecione os pedidos cujo status NÃO está em ('F', 'P').

select * from orders 
where o_orderstatus not in ('F', 'P');

-- 5. Selecione as peças com tamanho (size) entre 10 e 20
--    que sejam do tipo "ECONOMY ANODIZED STEEL" ou "LARGE BRUSHED BRASS".

select * from part
where p_size between 10 and 20 and p_type in ('ECONOMY ANODIZED STEEL', 'LARGED BRUSHED BRASS');









