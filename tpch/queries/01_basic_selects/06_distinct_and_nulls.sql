-- TEMA: DISTINCT, IS NULL, IS NOT NULL, COALESCE
-- Tabelas sugeridas: customer, orders, lineitem

-- 1. Liste todos os segmentos de mercado distintos existentes na tabela customer.

select distinct c_mktsegment from customer;


-- 2. Liste todas as combinações distintas de status de pedido (orderstatus)
--    e prioridade (orderpriority) da tabela orders.

select distinct o_orderstatus, o_orderpriority from orders;

-- 3. Verifique se existe algum cliente sem telefone cadastrado (c_phone nulo).

SELECT * FROM customer
WHERE c_phone IS NULL;


-- 4. Selecione o nome e o saldo dos clientes.
--    Para clientes com saldo negativo, exiba 0 no lugar do valor real.
--    (dica: CASE WHEN ou GREATEST)

select 
	c_name,
	case when c_acctbal < 0 then 0
	else c_acctbal
	end as c_acctbal 
from customer;

-- Outra opção

select 
	c_name,
	greatest(c_acctbal, 0) as c_acctbal
from customer;

-- 5. Conte quantos segmentos de mercado distintos existem.
--    (dica: COUNT + DISTINCT)

select COUNT(distinct c_mktsegment) as total_segments from customer;








