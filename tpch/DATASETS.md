# TPC-H Datasets

Os arquivos `.tbl` não estão versionados por serem ~1GB. Gere-os localmente com o `dbgen`.

## Gerando os dados (SF1 ~1GB)

**1. Clone e compile o dbgen:**

```bash
git clone https://github.com/electrum/tpch-dbgen /tmp/tpch-dbgen
cd /tmp/tpch-dbgen
make
```

**2. Gere os arquivos e mova para o projeto:**

```bash
./dbgen -s 1 -f
mv *.tbl ~/SoftwareDevelopment/postgres_practices_datasets/datasets/tpch/
```

O flag `-s 1` define o scale factor (SF1 = ~1GB). Para outros volumes: `-s 0.1` (~100MB), `-s 10` (~10GB).

## Arquivos gerados

| Arquivo | Tamanho (SF1) | Tabela |
|---|---|---|
| `region.tbl` | ~400B | region |
| `nation.tbl` | ~2KB | nation |
| `supplier.tbl` | ~1.3MB | supplier |
| `customer.tbl` | ~23MB | customer |
| `part.tbl` | ~23MB | part |
| `partsupp.tbl` | ~113MB | partsupp |
| `orders.tbl` | ~164MB | orders |
| `lineitem.tbl` | ~725MB | lineitem |

## Carregando no banco

```bash
# 1. Execute schema.sql no DBeaver (cria as tabelas)
# 2. Rode a ingestão
uv run tpch/ingest.py
# 3. Execute indexes.sql no DBeaver (FKs e índices)
```
