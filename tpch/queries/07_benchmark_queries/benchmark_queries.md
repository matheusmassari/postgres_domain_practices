# TPC-H Benchmark Queries

## O que são as 22 queries

O TPC-H define 22 queries de negócio que representam decisões analíticas típicas em um sistema de suporte à decisão. Cada query foi projetada para testar uma combinação diferente de capacidades do banco:

- Joins complexos entre múltiplas tabelas
- Subqueries correlacionadas e não-correlacionadas
- Agregações com HAVING
- Ordenação e limitação de resultados
- Operações sobre datas
- CASE WHEN para lógica condicional

Ao escrever todas as 22 queries, você estará praticando a interseção de tudo que estudou nos capítulos anteriores.

---

## As 22 queries e o que cada uma testa

| Query | Nome | Conceitos principais |
|---|---|---|
| Q01 | Pricing Summary Report | GROUP BY, agregações, CASE, ORDER BY |
| Q02 | Minimum Cost Supplier | Subquery correlacionada, múltiplos JOINs, ORDER BY |
| Q03 | Shipping Priority | JOIN, GROUP BY, filtro de data, LIMIT |
| Q04 | Order Priority Checking | EXISTS, GROUP BY, HAVING, CASE |
| Q05 | Local Supplier Volume | JOIN de 6 tabelas, GROUP BY, filtro de data |
| Q06 | Forecasting Revenue Change | Filtros simples, SUM com condições |
| Q07 | Volume Shipping | JOIN com nation duas vezes, CASE para ano |
| Q08 | National Market Share | Subquery, JOIN complexo, CASE, GROUP BY |
| Q09 | Product Type Profit Measure | JOIN de 6 tabelas, LIKE, GROUP BY, ORDER BY |
| Q10 | Returned Item Reporting | JOIN, GROUP BY, HAVING, ORDER BY, LIMIT |
| Q11 | Important Stock Identification | GROUP BY, HAVING com subquery |
| Q12 | Shipping Modes and Order Priority | JOIN, CASE, GROUP BY |
| Q13 | Customer Distribution | LEFT JOIN, GROUP BY duplo |
| Q14 | Promotion Effect | CASE dentro de SUM, filtro de data |
| Q15 | Top Supplier | CTE (ou view), JOIN, ORDER BY |
| Q16 | Parts/Supplier Relationship | NOT IN com subquery, GROUP BY, HAVING |
| Q17 | Small-Quantity-Order Revenue | Subquery correlacionada com AVG |
| Q18 | Large Volume Customer | IN com subquery de GROUP BY + HAVING |
| Q19 | Discounted Revenue | WHERE complexo com OR e múltiplas condições |
| Q20 | Potential Part Promotion | IN aninhado, subquery correlacionada |
| Q21 | Suppliers Who Kept Orders Waiting | EXISTS + NOT EXISTS combinados |
| Q22 | Global Sales Opportunity | CASE, subquery, GROUP BY, NOT EXISTS |

---

## Como abordar cada query

1. **Leia o enunciado** no arquivo da query
2. **Identifique as tabelas** necessárias e o caminho de JOINs
3. **Escreva sua versão** sem olhar a referência
4. **Execute e verifique** o resultado
5. **Compare com a referência** oficial (disponível em tpc.org)

---

## Resultado esperado (SF1)

Cada query tem um resultado de referência para SF1. Após escrever sua versão, verifique se os números batem — é a melhor forma de confirmar que a lógica está correta.

---

## Parâmetros de substituição

As queries oficiais usam parâmetros gerados aleatoriamente (marcados como `:1`, `:2` etc.). Nos exercícios aqui, os parâmetros já estão fixados com valores específicos para facilitar a verificação.
