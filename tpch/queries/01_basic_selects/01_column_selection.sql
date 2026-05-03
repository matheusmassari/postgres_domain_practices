-- TEMA: Seleção de colunas e aliases
-- Tabelas sugeridas: customer, nation, region

-- 1. Selecione apenas o nome e o saldo (acctbal) de todos os clientes.

select c_name, c_acctbal
from customer;

-- 2. Selecione o nome e o saldo dos clientes, renomeando as colunas
--    para "cliente" e "saldo".

select 
	c_name as cliente, 
	c_acctbal as saldo
from customer;


-- 3. Selecione todas as colunas de region.

select * from region;

-- 4. Selecione o nome do cliente e o segmento de mercado (mktsegment),
--    criando uma terceira coluna calculada que concatene os dois:
--    ex: "Customer#000000001 - BUILDING"

select 
    c_name,
    c_mktsegment, concat(c_name, ' - ', c_mktsegment) as name_and_segment
from customer; 









