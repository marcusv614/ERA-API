-- Benchmark de índices: cria dados temporários, mede sem índices, recria índices e mede novamente
\echo '=== BENCHMARK DE ÍNDICES ==='

-- 1) Preparar dados de referência mínimos
INSERT INTO categoria (nome, descricao) VALUES ('bench_categoria','categoria para benchmark') ON CONFLICT DO NOTHING;
INSERT INTO localizacao (rua, ilha, andar, observacao) VALUES ('bench_rua','bench_ilha','bench_andar','benchmark') ON CONFLICT DO NOTHING;
INSERT INTO usuario (nome, email, senha_hash) VALUES ('bench_user','bench@local','benchhash') ON CONFLICT DO NOTHING;

-- 2) Inserir produtos e estoque (apenas se ainda não existirem)
\echo 'Populando produtos e estoque de benchmark (pode demorar alguns segundos)...'
DO $$
BEGIN
    IF (SELECT COUNT(*) FROM produto WHERE codigo LIKE 'bench_%') = 0 THEN
        INSERT INTO produto (codigo, nome, descricao, categoria_id, unidade_medida)
        SELECT 'bench_' || g, 'Produto Bench ' || g, 'Descrição Bench', (SELECT id FROM categoria WHERE nome='bench_categoria'), 'UN'
        FROM generate_series(1,5000) g;

        INSERT INTO estoque (produto_id, localizacao_id, quantidade_atual)
        SELECT p.id, (SELECT id FROM localizacao WHERE rua='bench_rua' AND ilha='bench_ilha' AND andar='bench_andar'), (random()*100)::integer
        FROM produto p
        WHERE p.codigo LIKE 'bench_%';
    END IF;
END$$;

-- Escolher um produto de teste
\set TEST_PROD_ID '''(SELECT id FROM produto WHERE codigo LIKE 'bench_%' ORDER BY id LIMIT 1)'''
-- psql variable workaround: we'll compute an id in a subquery in the EXPLAINs

-- 3) Remover índices existentes (os criados pelo script anterior)
\echo 'Dropando índices temporariamente...'
DROP INDEX IF EXISTS idx_estoque_produto_id;
DROP INDEX IF EXISTS idx_estoque_localizacao_id;
DROP INDEX IF EXISTS idx_movimentacao_usuario_id;
DROP INDEX IF EXISTS idx_entrada_item_produto_id;
DROP INDEX IF EXISTS idx_retirada_item_produto_id;
DROP INDEX IF EXISTS idx_devolucao_item_produto_id;
DROP INDEX IF EXISTS idx_produto_categoria_id;
DROP INDEX IF EXISTS idx_entrada_usuario_id;
DROP INDEX IF EXISTS idx_retirada_usuario_responsavel_id;

-- 4) Benchmark sem índices
\echo '\n--- Execuções SEM índices ---'
\echo 'EXPLAIN ANALYZE SELECT * FROM estoque WHERE produto_id = (SELECT id FROM produto WHERE codigo LIKE ''bench_%'' ORDER BY id LIMIT 1);'
EXPLAIN ANALYZE SELECT * FROM estoque WHERE produto_id = (SELECT id FROM produto WHERE codigo LIKE 'bench_%' ORDER BY id LIMIT 1);

\echo 'EXPLAIN ANALYZE SELECT COUNT(*) FROM estoque WHERE produto_id = (SELECT id FROM produto WHERE codigo LIKE ''bench_%'' ORDER BY id LIMIT 1);'
EXPLAIN ANALYZE SELECT COUNT(*) FROM estoque WHERE produto_id = (SELECT id FROM produto WHERE codigo LIKE 'bench_%' ORDER BY id LIMIT 1);

\echo 'EXPLAIN ANALYZE SELECT * FROM produto p JOIN estoque e ON p.id = e.produto_id WHERE p.codigo LIKE ''bench_%'' LIMIT 100;'
EXPLAIN ANALYZE SELECT * FROM produto p JOIN estoque e ON p.id = e.produto_id WHERE p.codigo LIKE 'bench_%' LIMIT 100;

-- 5) Recriar índices (comandos inline)
\echo '\n--- Recriando índices ---'
CREATE INDEX IF NOT EXISTS idx_estoque_produto_id ON estoque(produto_id);
CREATE INDEX IF NOT EXISTS idx_estoque_localizacao_id ON estoque(localizacao_id);
CREATE INDEX IF NOT EXISTS idx_movimentacao_usuario_id ON movimentacao(usuario_id);
CREATE INDEX IF NOT EXISTS idx_entrada_item_produto_id ON entrada_item(produto_id);
CREATE INDEX IF NOT EXISTS idx_retirada_item_produto_id ON retirada_item(produto_id);
CREATE INDEX IF NOT EXISTS idx_devolucao_item_produto_id ON devolucao_item(produto_id);
CREATE INDEX IF NOT EXISTS idx_produto_categoria_id ON produto(categoria_id);
CREATE INDEX IF NOT EXISTS idx_entrada_usuario_id ON entrada(usuario_id);
CREATE INDEX IF NOT EXISTS idx_retirada_usuario_responsavel_id ON retirada(usuario_responsavel_id);

-- 6) Benchmark com índices
\echo '\n--- Execuções COM índices ---'
EXPLAIN ANALYZE SELECT * FROM estoque WHERE produto_id = (SELECT id FROM produto WHERE codigo LIKE 'bench_%' ORDER BY id LIMIT 1);
EXPLAIN ANALYZE SELECT COUNT(*) FROM estoque WHERE produto_id = (SELECT id FROM produto WHERE codigo LIKE 'bench_%' ORDER BY id LIMIT 1);
EXPLAIN ANALYZE SELECT * FROM produto p JOIN estoque e ON p.id = e.produto_id WHERE p.codigo LIKE 'bench_%' LIMIT 100;

-- 7) Limpeza de dados de benchmark
\echo '\n--- Limpando dados de benchmark ---'
DELETE FROM estoque WHERE produto_id IN (SELECT id FROM produto WHERE codigo LIKE 'bench_%');
DELETE FROM produto WHERE codigo LIKE 'bench_%';
DELETE FROM usuario WHERE email = 'bench@local';
DELETE FROM categoria WHERE nome = 'bench_categoria';
DELETE FROM localizacao WHERE rua = 'bench_rua' AND ilha = 'bench_ilha' AND andar = 'bench_andar';

\echo '=== FIM DO BENCHMARK ==='
