-- TEMA: ORDER BY — ordenação simples e múltipla
-- Tabelas sugeridas: customer, orders, supplier

-- 1. Liste todos os clientes ordenados por saldo (acctbal) do maior para o menor.

select * from customer
order by c_acctbal desc;

-- 2. Liste os pedidos ordenados por data de pedido (orderdate) crescente
--    e, em caso de empate, por valor total (totalprice) decrescente.

select * from orders
order by o_orderdate asc, o_totalprice desc;

-- 3. Liste os 10 itens de lineitem com maior valor estendido (extendedprice).

select * from lineitem 
order by l_extendedprice desc
limit 10;


-- 4. Liste os fornecedores ordenados pelo saldo (acctbal) crescente.
--    Mostre apenas os 20 primeiros, pulando os 5 primeiros.
--    (dica: LIMIT e OFFSET)

select * from supplier
order by s_acctbal asc
limit 20 offset 5;


