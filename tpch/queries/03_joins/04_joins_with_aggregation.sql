-- TEMA: JOIN + GROUP BY + HAVING — combinando relacionamentos com agregações

-- 1. Qual é o total de pedidos e o valor total por nação do cliente?
--    Ordene pelo valor total decrescente.
--    (tabelas: orders, customer, nation)

select 
	n.n_name as nation,
	count(o.o_orderkey) as total_de_pedidos,
	sum(o.o_totalprice) as total_price
from orders o 
join customer c on o.o_custkey = c.c_custkey 
join nation n on c.c_nationkey = n.n_nationkey
group by nation
order by total_price desc;

-- 2. Qual é a receita bruta total por região?
--    Receita bruta = extendedprice * (1 - discount)
--    (tabelas: lineitem, orders, customer, nation, region)

select 
	r.r_name as region, 
	sum(l.l_extendedprice * (1 - l.l_discount)) as receita_bruta 
from lineitem l 
join orders o on l.l_orderkey = o.o_orderkey 
join customer c on o.o_custkey = c.c_custkey 
join nation n on c.c_nationkey = n.n_nationkey 
join region r on n.n_regionkey = r.r_regionkey
group by region;

-- 3. Quais clientes têm mais de 15 pedidos?
--    Mostre o nome do cliente, a nação e a quantidade de pedidos.
--    (tabelas: orders, customer, nation)

select 
	c.c_name as customer,
	n.n_name as nation,
	count(o.o_orderkey) as qtd_pedidos
from customer c 
join orders o on c.c_custkey = o.o_custkey 
join nation n on n.n_nationkey = c.c_nationkey 
group by customer, nation 
having count(o.o_orderkey) > 15;

-- 4. Qual é o ticket médio por segmento de mercado?
--    Agora com JOIN — use customer para trazer o segmento.
--    (tabelas: orders, customer)

select 
	c.c_mktsegment as segment, 
	avg(o.o_totalprice) as ticket_medio
from customer c 
join orders o on c.c_custkey = o.o_custkey
group by segment;

-- 5. Quais fornecedores têm receita bruta total acima de 4.000.000?
--    Mostre o nome do fornecedor, a nação e a receita total.
--    Receita bruta = extendedprice * (1 - discount)
--    (tabelas: lineitem, supplier, nation)

SELECT
    s.s_name AS supplier_name,
    n.n_name AS nation,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS receita_bruta
FROM lineitem l
JOIN supplier s ON l.l_suppkey   = s.s_suppkey
JOIN nation   n ON s.s_nationkey = n.n_nationkey
GROUP BY supplier_name, nation
HAVING SUM(l.l_extendedprice * (1 - l.l_discount)) > 4000000
ORDER BY receita_bruta DESC;