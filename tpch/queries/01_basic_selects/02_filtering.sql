-- TEMA: Filtragem com WHERE — comparações e operadores lógicos
-- Tabelas sugeridas: customer, orders, lineitem

-- 1. Selecione todos os pedidos (orders) com valor total acima de 200.000.

select * from orders
where o_totalprice > 200000;

-- 2. Selecione os clientes do segmento "AUTOMOBILE" com saldo negativo.
select * 
from customer
where c_mktsegment in ('AUTOMOBILE') and c_acctbal < 0;

-- 3. Selecione os itens de lineitem onde o desconto é maior que 0.05
--    e a quantidade é maior que 30.

select * from lineitem
where l_discount > 0.05 and l_quantity > 30;

-- 4. Selecione os pedidos com status diferente de 'F' (finalizado)
--    e com prioridade 'URGENT' ou '1-URGENT'.

select * from orders 
where o_orderstatus <> 'F'
and o_orderpriority in ('URGENT', '1-URGENT');


-- 5. Selecione os clientes que NÃO pertencem aos segmentos
--    "AUTOMOBILE" e "BUILDING".

select * from customer
where c_mktsegment not in ('AUTOMOBILE', 'BUILDING');










