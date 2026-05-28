-- TEMA: Scalar subqueries — subqueries que retornam um único valor

-- 1. Liste os pedidos cujo valor total está acima da média geral de todos os pedidos.
--    Mostre orderkey, custkey e totalprice.

select 
	o.o_orderkey, 
	o.o_custkey, 
	o.o_totalprice 
from orders o
where o.o_totalprice > (select avg(o.o_totalprice) from orders o);

-- 2. Liste os pedidos cujo valor total está acima da média geral.
--    Adicione uma coluna mostrando quanto cada pedido está acima da média.

select 
	o.o_orderkey,
	o.o_custkey,
	o.o_totalprice,
	o.o_totalprice - (select avg(o.o_totalprice) from orders o) as diff_above_avg
from orders o
where o.o_totalprice > (select avg(o.o_totalprice) from orders o);

-- 3. Liste os itens de lineitem com desconto acima do desconto médio geral.
--    Mostre orderkey, partkey, discount e a diferença para a média.

select 
	l.l_orderkey, 
	l.l_partkey, 
	l.l_discount,
	l.l_discount - (select avg(l.l_discount) from lineitem l) as diff_above_avg
from lineitem l 
where l.l_discount > (select avg(l.l_discount) from lineitem l);

-- 4. Para cada pedido, mostre o orderkey, totalprice e o percentual
--    que ele representa em relação ao valor máximo de todos os pedidos.
--    (dica: scalar subquery no SELECT para o valor máximo)

-- valor maximo de todos os pedidos: max(o.o_totalprice)
-- percentual de um valor em relacao a um valor maior se calcula assim: (valor / valor_maior) * 100

select 
	o.o_orderkey, 
	o.o_totalprice, 
	(o.o_totalprice / (select max(o.o_totalprice) from orders o)) * 100 as percentual
from orders o;

-- 5. Qual é o cliente com o maior número de pedidos?
--    Mostre o nome do cliente e a quantidade de pedidos.
--    (dica: subquery com MAX aplicado a um COUNT)


select c.c_name, count(*) as total_pedidos
from customer c 
join orders o on c.c_custkey = o.o_custkey
group by c.c_name 
having count(*) = (
select max(t.total_pedidos)
from (select
	o.o_custkey,
	count(*) as total_pedidos
from orders o
group by o.o_custkey) t);