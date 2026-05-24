-- TEMA: GROUP BY — agrupamento simples e múltiplo
-- Tabelas sugeridas: orders, lineitem, customer

-- 1. Quantos pedidos existem por status (orderstatus)?

select 
	o_orderstatus, 
	count(*) as total_by_status
from orders
	group by o_orderstatus;

-- 2. Qual é o valor total de pedidos por prioridade (orderpriority)?
--    Ordene do maior para o menor valor total.

select 
	o_orderpriority,
	sum(o_totalprice) as total_price
from orders
	group by o_orderpriority 
	order by total_price desc;


-- 3. Qual é a quantidade média de itens (quantity) por modo de envio (shipmode)
--    na tabela lineitem?

select 
	l_shipmode, 
	avg(l_quantity) as average_qnty  
from lineitem
group by l_shipmode;


-- 4. Quantos pedidos foram feitos por ano?
--    (dica: EXTRACT(YEAR FROM o_orderdate))

select
	extract(year from o_orderdate) as year,
	count(*) as orders_qnty
from orders
group by year;


-- 5. Qual é o valor total e a quantidade de pedidos por status e por ano?
--    Ordene por ano crescente e status.

select 
	sum(o_totalprice) total_yearly_price,
	count(*) as order_qnty,
	o_orderstatus as status,
	extract(year from o_orderdate) as year
from orders
group by status, year
order by year asc;







