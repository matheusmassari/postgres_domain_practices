-- TEMA: INNER JOIN — retorna apenas linhas com correspondência em ambas as tabelas
-- O INNER JOIN é o JOIN padrão: se não houver match, a linha é excluída dos dois lados.

-- 1. Liste o nome de cada cliente junto com o nome da sua nação.
--    (tabelas: customer, nation)

select c.c_name, n.n_name
from customer c
join nation n 
on c.c_nationkey = n.n_nationkey;

-- 2. Liste cada pedido com o nome do cliente que o fez.
--    Mostre: order key, nome do cliente, data do pedido e valor total.
--    (tabelas: orders, customer)

select o.o_orderkey, c.c_name, o.o_orderdate, o.o_totalprice   
from orders o 
join customer c 
on o.o_custkey = c.c_custkey; 

-- 3. Liste o nome de cada fornecedor junto com o nome da sua nação e região.
--    (tabelas: supplier, nation, region)

select
	s.s_name,
	n.n_name, 
	r.r_name 
from supplier s 
join nation n on s.s_nationkey = n.n_nationkey
join region r on n.n_regionkey = r.r_regionkey;

-- 4. Liste os itens de lineitem com o nome da peça correspondente.
--    Mostre: orderkey, nome da peça, quantidade e preço estendido.
--    (tabelas: lineitem, part)

select 
	l.l_orderkey, 
	p.p_name, 
	l.l_quantity, 
	l.l_extendedprice     
from lineitem l 
join part p on l.l_partkey = p.p_partkey; 

-- 5. Liste o nome do cliente, o status do pedido e o valor total,
--    mas apenas para clientes do segmento 'BUILDING'.
--    (tabelas: orders, customer)

select c.c_name, o.o_orderstatus, o.o_totalprice 
from orders o 
join customer c on o.o_custkey = c.c_custkey 
where c.c_mktsegment = 'BUILDING';









