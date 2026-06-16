-- ==========================================
-- TESTES FUNCIONAIS COM DADOS DE EXEMPLO
-- ==========================================
-- Este script testa as funções e triggers com dados reais

\echo '====== INICIANDO TESTES FUNCIONAIS ======'
\echo ''

-- Preparar dados de teste
\echo '## PASSO 1: Inserir dados de teste'
\echo ''

-- Inserir um usuário
INSERT INTO usuario (nome, email) VALUES ('Teste Admin', 'admin@test.com') ON CONFLICT DO NOTHING;

-- Inserir categorias
INSERT INTO categoria (descricao) VALUES ('Eletrônicos'), ('Livros'), ('Roupas') ON CONFLICT DO NOTHING;

-- Inserir localização
INSERT INTO localizacao (descricao, endereco) VALUES ('Prateleira A', 'Galpão 1'), ('Prateleira B', 'Galpão 2') ON CONFLICT DO NOTHING;

-- Inserir produtos
INSERT INTO produto (nome, categoria_id, descricao, valor_unitario, ativo_id) 
SELECT 'Notebook', id, 'Notebook para testes', 2500.00, 1 FROM categoria WHERE descricao = 'Eletrônicos'
ON CONFLICT DO NOTHING;

INSERT INTO produto (nome, categoria_id, descricao, valor_unitario, ativo_id) 
SELECT 'Clean Code', id, 'Livro de programação', 89.90, 1 FROM categoria WHERE descricao = 'Livros'
ON CONFLICT DO NOTHING;

\echo 'Dados iniciais inseridos.'
\echo ''

-- Testes de Entrada (com trigger fn_entrada_estoque)
\echo '## PASSO 2: Teste de ENTRADA (Trigger: fn_entrada_estoque)'
\echo ''

-- Criar uma entrada
INSERT INTO entrada (usuario_id, data_entrada, numero_nota) 
SELECT id, NOW(), 'NF-001' FROM usuario WHERE nome = 'Teste Admin'
RETURNING id INTO entrada_id;

-- Verificar o ID (usando uma abordagem alternativa)
\set entrada_id 1

INSERT INTO entrada_item (entrada_id, produto_id, quantidade, valor_unitario) 
SELECT 
    (SELECT id FROM entrada ORDER BY id DESC LIMIT 1),
    (SELECT id FROM produto WHERE nome = 'Notebook'),
    5,
    2500.00
ON CONFLICT DO NOTHING;

\echo 'Entrada registrada. Verificando se trigger atualizou estoque...'
SELECT 
    e.id,
    p.nome as produto,
    e.quantidade_atual as quantidade_em_estoque,
    l.descricao as localizacao
FROM estoque e
JOIN produto p ON e.produto_id = p.id
JOIN localizacao l ON e.localizacao_id = l.id
WHERE p.nome = 'Notebook';

\echo ''
\echo '## PASSO 3: Teste de RETIRADA (Trigger: fn_retirada_estoque)'
\echo ''

-- Criar uma retirada
INSERT INTO retirada (usuario_id, data_retirada, motivo)
SELECT id, NOW(), 'Venda' FROM usuario WHERE nome = 'Teste Admin'
ON CONFLICT DO NOTHING;

-- Inserir item de retirada
INSERT INTO retirada_item (retirada_id, produto_id, quantidade, valor_unitario)
SELECT 
    (SELECT id FROM retirada ORDER BY id DESC LIMIT 1),
    (SELECT id FROM produto WHERE nome = 'Notebook'),
    2,
    2500.00
ON CONFLICT DO NOTHING;

\echo 'Retirada registrada. Verificando estoque atualizado...'
SELECT 
    e.id,
    p.nome as produto,
    e.quantidade_atual as quantidade_em_estoque
FROM estoque e
JOIN produto p ON e.produto_id = p.id
WHERE p.nome = 'Notebook';

\echo ''
\echo '## PASSO 4: Teste de Erro - Retirada com Estoque Insuficiente'
\echo ''

-- Tentar retirar mais do que existe (deve falhar)
\echo 'Tentando retirar 10 unidades quando só existem 3...'
BEGIN;
INSERT INTO retirada (usuario_id, data_retirada, motivo)
SELECT id, NOW(), 'Teste Erro' FROM usuario WHERE nome = 'Teste Admin'
ON CONFLICT DO NOTHING;

INSERT INTO retirada_item (retirada_id, produto_id, quantidade, valor_unitario)
SELECT 
    (SELECT id FROM retirada ORDER BY id DESC LIMIT 1),
    (SELECT id FROM produto WHERE nome = 'Notebook'),
    10,
    2500.00
ON CONFLICT DO NOTHING;
COMMIT;

\echo 'ESPERADO: Erro de estoque insuficiente'
\echo ''

\echo '## PASSO 5: Teste de DEVOLUÇÃO (Trigger: fn_devolucao_estoque)'
\echo ''

-- Criar uma devolução
INSERT INTO devolucao (usuario_id, data_devolucao, motivo)
SELECT id, NOW(), 'Produto com defeito' FROM usuario WHERE nome = 'Teste Admin'
ON CONFLICT DO NOTHING;

-- Inserir item de devolução
INSERT INTO devolucao_item (devolucao_id, produto_id, quantidade, valor_unitario)
SELECT 
    (SELECT id FROM devolucao ORDER BY id DESC LIMIT 1),
    (SELECT id FROM produto WHERE nome = 'Notebook'),
    1,
    2500.00
ON CONFLICT DO NOTHING;

\echo 'Devolução registrada. Verificando estoque atualizado...'
SELECT 
    e.id,
    p.nome as produto,
    e.quantidade_atual as quantidade_em_estoque
FROM estoque e
JOIN produto p ON e.produto_id = p.id
WHERE p.nome = 'Notebook';

\echo ''
\echo '====== FIM DOS TESTES FUNCIONAIS ======'
