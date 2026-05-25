-- TEMA: Múltiplos JOINs — encadeando 3 ou mais tabelas

-- 1. Liste o nome do cliente, o nome da sua nação e o nome da região.
--    (tabelas: customer → nation → region)

select 
	c.c_name, 
	n.n_name, 
	r.r_name    
from customer c
join nation n on c.c_nationkey  = n.n_nationkey
join region r on n.n_regionkey = r.r_regionkey;

-- 2. Liste cada pedido com o nome do cliente, nome da nação do cliente
--    e o valor total do pedido.
--    Ordene por valor total decrescente. Mostre os 20 maiores.
--    (tabelas: orders → customer → nation)

select 
	o.o_orderkey, 
	c.c_name, 
	n.n_name, 
	o.o_totalprice  
from orders o
join customer c on o.o_custkey = c.c_custkey 
join nation n on c.c_nationkey = n.n_nationkey
order by o.o_totalprice desc
limit 20;

-- 3. Liste os itens de lineitem com o nome da peça e o nome do fornecedor.
--    (tabelas: lineitem → partsupp → part + supplier)
--    Atenção: lineitem se conecta com partsupp por DUAS colunas:
--    l_partkey = ps_partkey AND l_suppkey = ps_suppkey

SELECT l.l_linenumber, p.p_name, s.s_name
FROM lineitem l
JOIN partsupp ps ON l.l_partkey = ps.ps_partkey
                 AND l.l_suppkey = ps.ps_suppkey
JOIN part     p  ON ps.ps_partkey = p.p_partkey
JOIN supplier s  ON ps.ps_suppkey = s.s_suppkey; 

-- 4. Mostre o nome do cliente, a data do pedido e o nome de cada peça
--    que ele pediu, junto com a quantidade.
--    (tabelas: customer → orders → lineitem → part)

select 
	c.c_name, 
	o.o_orderdate, 
	p.p_name, 
	l.l_quantity    
from customer c 
join orders o on c.c_custkey = o.o_custkey 
join lineitem l on o.o_orderkey = l.l_orderkey 
join part p on l.l_partkey = p.p_partkey;

-- 5. Para cada região, mostre o nome da região e a quantidade total
--    de clientes que pertencem a nações dessa região.
--    (tabelas: region → nation → customer)

select r.r_name, count(c.c_custkey) as customer_count
from region r 
join nation n on r.r_regionkey = n.n_regionkey 
join customer c on c.c_nationkey = n.n_nationkey 
group by r.r_name
order by r.r_name;








