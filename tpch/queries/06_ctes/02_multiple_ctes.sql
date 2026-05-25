-- TEMA: Múltiplas CTEs — encadeando etapas de transformação

-- 1. Com duas CTEs:
--    - CTE 1: receita bruta total por cliente
--    - CTE 2: média de receita por segmento de mercado (usando a CTE 1)
--    Query final: mostre segmento e média, ordenado pela média decrescente.

-- 2. Com três CTEs:
--    - CTE 1: receita bruta por nação
--    - CTE 2: receita bruta por região (agrupando a CTE 1)
--    - CTE 3: participação percentual de cada nação dentro de sua região
--    Query final: mostre região, nação e percentual — ordenado por região e percentual desc.

-- 3. Com duas CTEs:
--    - CTE 1: top 100 clientes por receita bruta
--    - CTE 2: total de pedidos desses top 100 clientes
--    Query final: mostre o nome do cliente, a receita e o total de pedidos.

-- 4. Com duas CTEs:
--    - CTE 1: ticket médio por cliente
--    - CTE 2: clientes cujo ticket médio está acima da média global
--    Query final: mostre nome do cliente, nação, ticket médio.
--    (tabelas necessárias: orders, customer, nation)

-- 5. Com três CTEs replicando a lógica da Query 18 do TPC-H:
--    - CTE 1: quantidade total por pedido (SUM de l_quantity por orderkey)
--    - CTE 2: pedidos com quantidade total acima de 300
--    - CTE 3: dados do cliente para esses pedidos
--    Query final: nome do cliente, orderkey, orderdate, totalprice, quantidade total.
--    Ordene por totalprice decrescente, limite 10.
