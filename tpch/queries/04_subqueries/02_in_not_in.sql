-- TEMA: IN e NOT IN com subqueries

-- 1. Liste os clientes que pertencem a nações da região 'ASIA'.
--    Use IN com subquery — sem JOIN.
--    (dica: subquery em nation filtrando pela região, outra em region)

select * 
from customer c 
where c.c_nationkey in 
	(
		select n.n_nationkey as nation_key
		from nation n 
		where n.n_regionkey = 
			(select r.r_regionkey as region_key from region r where r.r_name = 'ASIA')
	);

-- 2. Liste os fornecedores que NÃO pertencem a nações da região 'EUROPE'.
--    Use NOT IN com subquery.

select * 
from supplier s 
where s.s_nationkey in (
	select n.n_nationkey  
	from nation n 
	where n.n_regionkey not in (
		select r.r_regionkey  from region r where r.r_name = 'EUROPE'
		)
	);

-- 3. Liste os pedidos feitos por clientes do segmento 'AUTOMOBILE'.
--    Use IN com subquery — sem JOIN direto em orders.

select * 
from orders o where o.o_custkey in (select c.c_custkey from customer c where c.c_mktsegment = 'AUTOMOBILE');

-- 4. Liste as peças que foram enviadas pelo modo 'AIR' em algum momento.
--    (tabelas: part, lineitem — use IN)

select * from part p where p.p_partkey in (select l.l_partkey from lineitem l where l.l_shipmode = 'AIR');

-- 5. Liste os clientes que nunca fizeram um pedido com status 'F'.
--    (dica: NOT IN ou NOT EXISTS — implemente com NOT IN aqui)
--    Reflita: esse resultado seria diferente se houvesse NULLs em o_custkey?

select * from customer c where c.c_custkey not in (select o.o_custkey from orders o where o.o_orderstatus = 'F');

-- Sobre a reflexão do ex 5: sim, o resultado seria diferente se houvesse NULLs em o_custkey. Se a subquery retornasse qualquer NULL, o NOT IN retornaria zero linhas — pois x
-- NOT IN (1, 2, NULL) é avaliado como NULL para qualquer x, nunca como TRUE. Na prática o_custkey é NOT NULL no TPC-H, então não há risco aqui — mas em dados reais esse é um
-- dos casos mais silenciosos e perigosos do SQL.