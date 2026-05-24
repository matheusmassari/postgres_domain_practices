-- TEMA: Agregações com expressões calculadas
-- Tabelas sugeridas: lineitem

-- Fórmulas úteis do TPC-H:
--   Receita bruta    = extendedprice * (1 - discount)
--   Receita líquida  = extendedprice * (1 - discount) * (1 + tax)
--   Perda de receita = extendedprice * discount

-- 1. Qual é a receita bruta total, receita líquida total e perda total
--    por desconto — agrupados por returnflag e linestatus?
--    Ordene por returnflag e linestatus.
--    (esta é a base da Query 1 oficial do TPC-H)

select
	l_returnflag,
	l_linestatus,
	sum(l_extendedprice * (1 - l_discount )) as receita_bruta_total,
	sum(l_extendedprice * (1 - l_discount ) * (1 + l_tax)) as receita_liquida_total,
	sum(l_extendedprice * l_discount) as perda_de_receita
from lineitem
group by l_returnflag, l_linestatus 
order by l_returnflag, l_linestatus;

-- 2. Qual é o desconto médio por modo de envio (shipmode)?
--    Mostre também o impacto médio do desconto por item
--    (extendedprice * discount) por shipmode.

select 
	l_shipmode as shipmode
	avg(l_discount) as avg_discount, 
	avg(l_extendedprice * l_discount) as discount_impact_per_item, 
from lineitem
group by shipmode;

-- 3. Por mês de envio (shipdate), qual é a receita líquida total?
--    Mostre apenas os meses com receita acima de 500.000.000.
--    (dica: DATE_TRUNC('month', l_shipdate))

 SELECT
      DATE_TRUNC('month', l_shipdate)::date                       AS month,
      SUM(l_extendedprice * (1 - l_discount) * (1 + l_tax))      AS receita_liquida_total
  FROM lineitem
  GROUP BY DATE_TRUNC('month', l_shipdate)
  HAVING SUM(l_extendedprice * (1 - l_discount) * (1 + l_tax)) > 500000000
  ORDER BY month;










