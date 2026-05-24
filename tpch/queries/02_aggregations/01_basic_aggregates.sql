-- TEMA: COUNT, SUM, AVG, MIN, MAX
-- Tabelas sugeridas: orders, lineitem, customer, supplier

-- 1. Quantos pedidos existem no total?
select count(*) as total_pedidos from orders;

-- 2. Qual é o valor total de todos os pedidos (soma de totalprice)?
select sum(o_totalprice ) valor_total from orders; 

-- 3. Qual é o valor médio, mínimo e máximo dos pedidos?
select 
	avg(o_totalprice) as valor_medio,
	min(o_totalprice) as valor_minimo,
	max(o_totalprice) as valor_maximo,
	percentile_cont(0.5) within group (order by o_totalprice) as mediana
from orders;


-- 4. Quantos clientes distintos fizeram pelo menos um pedido?
--    (dica: COUNT DISTINCT na tabela orders)

select count(distinct (o_custkey)) from orders;


-- 5. Qual é a soma total de receita bruta dos itens de lineitem?
--    Receita bruta = extendedprice * (1 - discount)

select 
	sum((l_extendedprice * (1 - l_discount ))) as total_gross_revenue 
from lineitem;



