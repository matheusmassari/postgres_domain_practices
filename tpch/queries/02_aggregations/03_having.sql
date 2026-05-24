-- TEMA: HAVING — filtrando grupos
-- Tabelas sugeridas: orders, lineitem, customer, partsupp

-- 1. Liste os clientes (custkey) que fizeram mais de 20 pedidos.

select 
	o.o_custkey as cliente_id, 
	count(*) as qtd_pedidos 
from orders o 
group by cliente_id
having count(*) > 20;

-- 2. Liste os modos de envio (shipmode) cuja quantidade média de itens
--    seja superior a 25.

select 
	l_shipmode, 
	avg(l_quantity) as quantidade_media_items 
from lineitem 
group by l_shipmode
having avg(l_quantity) > 25;

-- 3. Liste os anos em que o valor total de pedidos ultrapassou 170.000.000.

select 
	sum(o.o_totalprice), 
	extract(year from o.o_orderdate)::text as year
from orders o
group by year
having sum(o.o_totalprice) > 170000000;

-- 4. Liste os segmentos de mercado (mktsegment) com mais de 30.000 clientes.

select 
	c.c_mktsegment as segment,
	count(c.c_custkey) as customer_amount 
from customer c 
group by segment
having count(c.c_custkey) > 30000;

-- 5. Liste os fornecedores (suppkey) que fornecem mais de 3 peças distintas
--    com custo de fornecimento (supplycost) acima de 500.
--    (tabela: partsupp)

 SELECT
      ps_suppkey    AS supplier_key,
      COUNT(*)      AS parts_above_500
 FROM partsupp
 WHERE ps_supplycost > 500
 GROUP BY ps_suppkey
 HAVING COUNT(*) > 3;













