-- TEMA: LEFT JOIN e RIGHT JOIN
-- LEFT JOIN: retorna todas as linhas da tabela da esquerda,
--            com NULL nas colunas da direita quando não há correspondência.
-- RIGHT JOIN: o inverso — todas as linhas da direita, NULLs na esquerda.

-- 1. Liste todos os clientes e seus pedidos.
--    Inclua clientes que nunca fizeram um pedido (o_orderkey será NULL).
--    (tabelas: customer, orders)

select * 
from customer c 
left join orders o on o.o_custkey = c.c_custkey;

-- 2. A partir do exercício anterior, filtre apenas os clientes
--    que NUNCA fizeram um pedido.
--    (dica: WHERE o_orderkey IS NULL)

select * 
from customer c 
left join orders o on o.o_custkey = c.c_custkey
where o.o_orderkey is null;

-- 3. Liste todas as nações e a quantidade de clientes em cada uma.
--    Inclua nações sem nenhum cliente cadastrado.
--    (tabelas: nation, customer)

select
	n.n_name as nation,
	count(c.c_custkey) as customer_count
from nation n left join customer c on n.n_nationkey = c.c_nationkey 
group by nation;

-- 4. Liste todas as peças (part) e, quando existir, o custo mínimo
--    de fornecimento disponível em partsupp.
--    Inclua peças sem nenhum fornecedor cadastrado.
--    (tabelas: part, partsupp)

select p.p_partkey, p.p_brand, min(ps.ps_supplycost) as min_supply_cost    
from part p 
left join partsupp ps on p.p_partkey = ps.ps_partkey
group by p.p_partkey, p.p_brand;

-- 5. Reescreva o exercício 3 usando RIGHT JOIN invertendo a ordem das tabelas.
--    O resultado deve ser idêntico ao do exercício 3.
--    Reflita: quando você usaria RIGHT JOIN no lugar de LEFT JOIN?

select
	n.n_name as nation,
	count(c.c_custkey) as customer_count
from customer c right join nation n on n.n_nationkey = c.c_nationkey 
group by nation;
