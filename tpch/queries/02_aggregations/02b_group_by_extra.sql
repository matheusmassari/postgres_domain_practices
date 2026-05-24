-- TEMA: GROUP BY — exercícios complementares
-- Foco: DATE_TRUNC, CASE WHEN em grupos, contagem condicional, buckets, ROLLUP

-- 1. Quantos pedidos foram feitos por trimestre?
--    Mostre ano e trimestre (ex: 1995 Q1), ordenado cronologicamente.
--    (dica: EXTRACT YEAR e QUARTER)

select 
	extract(year from o.o_orderdate) as ano, 
	extract(quarter from o.o_orderdate) as trimestre,
	count(*) as quantidade_pedidos
from orders o
	group by ano, trimestre;

-- 2. Qual é a receita bruta total por mês de envio?
--    Receita bruta = extendedprice * (1 - discount)
--    Use DATE_TRUNC para truncar a data ao mês.
--    Ordene cronologicamente.

select 
	SUM(l.l_extendedprice  * (1 - l.l_discount)) as gross_month_revenue, 
	date_trunc('month', l.l_shipdate)::date as month,
	extract(year from l.l_shipdate) as year
from lineitem l
group by month, year 
order by year, month asc;

-- 3. Agrupe os clientes por faixa de saldo (acctbal):
--    'negativo'   → acctbal < 0
--    'baixo'      → entre 0 e 2500
--    'medio'      → entre 2500 e 7500
--    'alto'       → acima de 7500
--    Mostre quantos clientes existem em cada faixa.
--    (dica: CASE WHEN dentro do GROUP BY)

select
	case 
		when c.c_acctbal < 0 then 'negativo'
		when c.c_acctbal < 2500 then 'baixo'
		when c.c_acctbal < 7500 then 'medio'
		else 'alto'
	end as faixa,
	count(*) as qntd_clientes
from customer c 
group by faixa;


-- 4. Para cada modo de envio (shipmode), mostre:
--    - total de itens
--    - quantos itens foram devolvidos (returnflag = 'R')
--    - percentual de devolução
--    (dica: SUM(CASE WHEN ... THEN 1 ELSE 0 END))

SELECT 
    l.l_shipmode AS ship_mode,
    COUNT(*) AS total_items,
    
    SUM(
        CASE 
            WHEN l.l_returnflag = 'R' THEN 1
            ELSE 0
        END
    ) AS devolvidos,

    ROUND(
        100.0 * SUM(
            CASE 
                WHEN l.l_returnflag = 'R' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS percentual_devolucao

FROM lineitem l
GROUP BY l.l_shipmode;


-- 5. Qual é o ticket médio dos pedidos por segmento de mercado do cliente?
--    (tabelas: orders e customer — sem JOIN ainda)
--    Resolva usando apenas a tabela orders por enquanto:
--    agrupe por custkey e calcule a média de totalprice por cliente,
--    depois agregue novamente para ver a distribuição.
--    (dica: subquery ou CTE — use o que souber)

with ticket_medio_cliente as (
	select 
		o.o_custkey as cliente_id, 
		avg(o.o_totalprice) as ticket_medio 
	from orders o
	group by cliente_id
) select 
	round(avg(ticket_medio)) as ticket_medio_geral 
from ticket_medio_cliente;

-- 6. Quantos itens de lineitem foram enviados por ano e por modo de envio?
--    Ordene por ano e pelo total de itens decrescente dentro de cada ano.

select 
	count(*) as total_items, 
	extract(year from l.l_shipdate) as year,
	l.l_shipmode as ship_mode
from lineitem l 
group by year, ship_mode
order by year, total_items desc

-- 7. Mostre a evolução mensal da receita bruta em 1995.
--    Inclua apenas meses com receita acima de 1.500.000.000.

select 
	extract(month from l_shipdate) as mes,
	sum(l_extendedprice * (1 - l_discount)) as receita_bruta
from lineitem
where extract(year from l_shipdate) = 1995
group by mes
having sum(l_extendedprice * (1 - l_discount)) > 1500000000
order by mes;

-- 8. Para cada prioridade de pedido (orderpriority), mostre:
--    - quantidade de pedidos
--    - valor total
--    - valor médio
--    - maior e menor pedido
--    Ordene por valor total decrescente.

select 
	o.o_orderpriority as prioridade, 
	count(*) as qtd_pedidos, 
	sum(o.o_totalprice) as valor_total, 
	avg(o.o_totalprice) as valor_medio, 
	max(o.o_totalprice) as maior_pedido,
	min(o.o_totalprice ) as menor_pedido
from orders o
group by prioridade;


-- 9. Usando ROLLUP, mostre o total de pedidos agrupado por status e por ano,
--    incluindo os subtotais por status e o total geral.
--    (dica: GROUP BY ROLLUP(o_orderstatus, EXTRACT(YEAR FROM o_orderdate)))

select 
	o.o_orderstatus as status,
	count(*) as total_pedidos,
	extract(year from o.o_orderdate) as year
from orders o
group by rollup (status, year)
order by status, year

-- O problema do NULL ambíguo, e como resolver com GROUPING()
-- Tem uma armadilha aqui. Se a coluna o_orderstatus já tivesse valores NULL de verdade nos dados, 
-- você não conseguiria distinguir um NULL "real" de um NULL "gerado pelo ROLLUP como subtotal". 
-- Os dois apareceriam iguais.

SELECT
    CASE WHEN GROUPING(o_orderstatus) = 1 THEN 'TODOS OS STATUS'
         ELSE o_orderstatus END AS status,
    CASE WHEN GROUPING(EXTRACT(YEAR FROM o_orderdate)) = 1 THEN 'TODOS OS ANOS'
         ELSE EXTRACT(YEAR FROM o_orderdate)::text END AS ano,
    COUNT(*) AS total_pedidos
FROM orders
GROUP BY ROLLUP (o_orderstatus, EXTRACT(YEAR FROM o_orderdate))
ORDER BY GROUPING(o_orderstatus), o_orderstatus,
         GROUPING(EXTRACT(YEAR FROM o_orderdate)), EXTRACT(YEAR FROM o_orderdate);

-- 10. Classifique cada modo de envio (shipmode) pelo desconto médio concedido.
--     Mostre: shipmode, desconto médio, e uma coluna "classificacao" com:
--     'alto desconto'  → avg discount >= 0.06
--     'medio desconto' → entre 0.04 e 0.06
--     'baixo desconto' → abaixo de 0.04
--     (dica: CASE WHEN sobre o resultado agregado — use no SELECT, não no HAVING)

select 
	l.l_shipmode as shipmode,
	avg(l.l_discount) as avg_discount,
	case
		when avg(l.l_discount) >= 0.06 then 'alto desconto'
		when avg(l.l_discount) between 0.04 and 0.06 then 'medio desconto'
		else 'baixo desconto'
	end as classificacao
from lineitem l 
group by shipmode

