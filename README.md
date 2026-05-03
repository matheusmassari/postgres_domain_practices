# PostgreSQL Practices

Repositório de práticas com PostgreSQL, organizado por domínios independentes. Cada domínio possui seu próprio container Docker com banco de dados isolado, schema dedicado e scripts de ingestão.

## Motivação

Consolidar em um único repositório diferentes contextos de estudo e prática com PostgreSQL — livros, cursos e benchmarks — mantendo cada domínio isolado no nível do banco de dados, mas compartilhando infraestrutura e ambiente Python.

## Estrutura

```
postgres_practices_datasets/
│
├── docker-compose.yml        # todos os containers PostgreSQL
├── pyproject.toml            # projeto uv único (ambiente Python compartilhado)
│
├── tpch/                     # TPC-H benchmark (queries analíticas, SF1)
│   ├── schema.sql
│   ├── indexes.sql
│   └── ingest.py
│
├── art_of_postgres/          # The Art of PostgreSQL — Dimitri Fontaine (2022)
│   └── ...
│
├── udemy/                    # Curso de PostgreSQL (Udemy)
│   └── ...
│
└── datasets/                 # Arquivos de dados brutos
    └── tpch/                 # Arquivos .tbl gerados pelo dbgen (SF1)
```

## Containers

| Container | Imagem | Porta | Banco | Domínio |
|---|---|---|---|---|
| `postgres18_practice` | postgres:18 | `54321` | `practice_db` | The Art of PostgreSQL |
| `postgres_udemy` | postgres:16 | `54322` | `udemy_db` | Curso Udemy |

## Subir os containers

```bash
docker compose up -d
```

## Conexão via DBeaver

Criar uma conexão PostgreSQL para cada container:

**postgres18_practice**
- Host: `localhost` / Port: `54321`
- Database: `practice_db` / User: `admin`

**postgres_udemy**
- Host: `localhost` / Port: `54322`
- Database: `udemy_db` / User: `admin`

## Ambiente Python

Gerenciado com [uv](https://github.com/astral-sh/uv). Instalar dependências:

```bash
uv sync
```

Executar um script de ingestão:

```bash
uv run tpch/ingest.py
```

## Domínios

### TPC-H
Benchmark padrão da indústria para cargas analíticas (OLAP). Schema com 8 tabelas relacionadas: pedidos, clientes, fornecedores, peças e itens de linha. Dados gerados com `dbgen` no scale factor 1 (~1GB).

### The Art of PostgreSQL
Práticas acompanhando o livro de Dimitri Fontaine (2022). Foco em SQL avançado, modelagem e recursos específicos do PostgreSQL.

### Udemy
Práticas de curso de PostgreSQL com foco em fundamentos e uso geral.
