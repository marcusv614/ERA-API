# ERA-API

## Índices e manutenção do banco

Adicionei um conjunto recomendado de índices para melhorar consultas frequentes relacionadas ao estoque e movimentações. Os comandos abaixo criam e removem esses índices.

Criar índices:

```sql
-- execute no container ou via psql conectado ao banco
\i create_indexes.sql
```

Remover índices (rollback):

```sql
DROP INDEX IF EXISTS idx_estoque_produto_id;
DROP INDEX IF EXISTS idx_estoque_localizacao_id;
DROP INDEX IF EXISTS idx_movimentacao_usuario_id;
DROP INDEX IF EXISTS idx_entrada_item_produto_id;
DROP INDEX IF EXISTS idx_retirada_item_produto_id;
DROP INDEX IF EXISTS idx_devolucao_item_produto_id;
DROP INDEX IF EXISTS idx_produto_categoria_id;
DROP INDEX IF EXISTS idx_entrada_usuario_id;
DROP INDEX IF EXISTS idx_retirada_usuario_responsavel_id;
```

Benchmark rápido (sem índices vs com índices):

1. Remova os índices usando os comandos acima.
2. Rode o script de benchmark gerado `benchmark_indexes.sql`:

```sh
PGPASSWORD=era123 psql -h localhost -p 5434 -U vini -d era_db_estoque -f benchmark_indexes.sql
```

O script medirá consultas com `EXPLAIN ANALYZE` sem índices e depois recriará os índices e medirá novamente.

OBS: O script de benchmark cria dados temporários (`bench_*`) e os remove ao final.

