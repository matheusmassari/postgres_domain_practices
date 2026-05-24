-- TEMA: WHERE + GROUP BY + HAVING combinados
-- Tabelas sugeridas: orders, lineitem

-- Lembrete: WHERE filtra linhas ANTES do agrupamento.
--            HAVING filtra grupos DEPOIS do agrupamento.

-- 1. Entre os pedidos feitos a partir de 1996, quantos existem por status?
--    Mostre apenas os status com mais de 300.000 pedidos.

select 
    o.o_orderstatus as status, 
    count(*) as qtd_status
from orders o
where o.o_orderdate >= '1996-01-01'
group by o.o_orderstatus
having count(*) > 300000;

-- 2. Considerando apenas itens com desconto maior que 0,05,
--    qual é a receita bruta total por modo de envio (shipmode)?
--    Receita bruta = extendedprice * (1 - discount)
--    Mostre apenas os shipmodes com receita acima de 100.000.000.

select 
	l.l_shipmode as shipmode,
	sum(l.l_extendedprice  * (1 - l.l_discount)) as receita_bruta
from lineitem l
where l.l_discount > 0.05
group by shipmode
having sum(l.l_extendedprice  * (1 - l.l_discount)) > 100000000;

-- 3. Para pedidos com prioridade '1-URGENT' feitos entre 1993 e 1997,
--    mostre o valor total por ano.
--    Inclua apenas os anos com valor total acima de 50.000.000.

select 
	sum(o.o_totalprice),
	extract(year from o.o_orderdate) as year
from orders o
where o.o_orderpriority = '1-URGENT' and o.o_orderdate between '1993-01-01' and '1997-12-31'
group by year
having sum(o.o_totalprice) > 50000000
order by year;








