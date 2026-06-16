-- ==========================================
-- TESTES COMPLETOS DO BANCO DE DADOS ERA
-- ==========================================
-- Script para validar integridade, funções e triggers

\echo '====== RELATÓRIO DE TESTES DO BANCO DE DADOS ======'
\echo ''

-- 1. TESTE DE INTEGRIDADE DE DADOS
\echo '## 1. VERIFICAÇÃO DE INTEGRIDADE DE DADOS'
\echo ''

-- Verificar referências órfãs em entrada_item
\echo 'Validando entrada_item...'
SELECT COUNT(*) as "Entrada Items sem entrada" 
FROM entrada_item ei 
WHERE NOT EXISTS (SELECT 1 FROM entrada e WHERE e.id = ei.entrada_id);

-- Verificar referências órfãs em retirada_item
\echo 'Validando retirada_item...'
SELECT COUNT(*) as "Retirada Items sem retirada" 
FROM retirada_item ri 
WHERE NOT EXISTS (SELECT 1 FROM retirada r WHERE r.id = ri.retirada_id);

-- Verificar referências órfãs em devolucao_item
\echo 'Validando devolucao_item...'
SELECT COUNT(*) as "Devolucao Items sem devolucao" 
FROM devolucao_item di 
WHERE NOT EXISTS (SELECT 1 FROM devolucao d WHERE d.id = di.devolucao_id);

\echo ''
\echo '## 2. TESTES DE TRIGGERS'
\echo ''

-- Verificar se o trigger de entrada está funcionando
\echo 'Verificando trigger de entrada_estoque...'
SELECT COUNT(*) as "Triggers de entrada" FROM information_schema.triggers 
WHERE trigger_name = 'trg_entrada_estoque' AND event_manipulation = 'INSERT';

-- Verificar se o trigger de retirada está funcionando
\echo 'Verificando trigger de retirada_estoque...'
SELECT COUNT(*) as "Triggers de retirada" FROM information_schema.triggers 
WHERE trigger_name = 'trg_retirada_estoque' AND event_manipulation = 'INSERT';

-- Verificar se o trigger de devolução está funcionando
\echo 'Verificando trigger de devolucao_estoque...'
SELECT COUNT(*) as "Triggers de devolução" FROM information_schema.triggers 
WHERE trigger_name = 'trg_devolucao_estoque' AND event_manipulation = 'INSERT';

\echo ''
\echo '## 3. TESTES DE FUNÇÕES'
\echo ''

-- Listar funções definidas
\echo 'Funções do banco:'
SELECT routine_name 
FROM information_schema.routines 
WHERE routine_schema = 'public' 
AND routine_type = 'FUNCTION'
ORDER BY routine_name;

\echo ''
\echo '## 4. ESTATÍSTICAS DO BANCO'
\echo ''

\echo 'Estatísticas por tabela:'
SELECT 
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as tamanho,
    (SELECT COUNT(*) FROM information_schema.tables 
     WHERE table_schema='public' 
     AND table_name=tablename) as existe
FROM pg_tables 
WHERE schemaname = 'public'
ORDER BY tablename;

\echo ''
\echo '## 5. CONTAGEM DE REGISTROS'
\echo ''

\echo 'Quantos registros em cada tabela:'
SELECT 
    'usuario' as tabela, COUNT(*) as registros FROM usuario
UNION ALL
SELECT 'categoria', COUNT(*) FROM categoria
UNION ALL
SELECT 'produto', COUNT(*) FROM produto
UNION ALL
SELECT 'localizacao', COUNT(*) FROM localizacao
UNION ALL
SELECT 'ativo', COUNT(*) FROM ativo
UNION ALL
SELECT 'nota_fiscal', COUNT(*) FROM nota_fiscal
UNION ALL
SELECT 'entrada', COUNT(*) FROM entrada
UNION ALL
SELECT 'entrada_item', COUNT(*) FROM entrada_item
UNION ALL
SELECT 'retirada', COUNT(*) FROM retirada
UNION ALL
SELECT 'retirada_item', COUNT(*) FROM retirada_item
UNION ALL
SELECT 'devolucao', COUNT(*) FROM devolucao
UNION ALL
SELECT 'devolucao_item', COUNT(*) FROM devolucao_item
UNION ALL
SELECT 'estoque', COUNT(*) FROM estoque
UNION ALL
SELECT 'movimentacao', COUNT(*) FROM movimentacao
ORDER BY tabela;

\echo ''
\echo '## 6. VALIDAÇÃO DE CONSTRAINTS'
\echo ''

-- Verificar todas as constraints
SELECT 
    'Primary Keys' as tipo,
    COUNT(*) as quantidade
FROM information_schema.table_constraints
WHERE table_schema = 'public'
AND constraint_type = 'PRIMARY KEY'
UNION ALL
SELECT 'Foreign Keys', COUNT(*)
FROM information_schema.table_constraints
WHERE table_schema = 'public'
AND constraint_type = 'FOREIGN KEY'
UNION ALL
SELECT 'Unique', COUNT(*)
FROM information_schema.table_constraints
WHERE table_schema = 'public'
AND constraint_type = 'UNIQUE'
UNION ALL
SELECT 'Check', COUNT(*)
FROM information_schema.table_constraints
WHERE table_schema = 'public'
AND constraint_type = 'CHECK';

\echo ''
\echo '====== FIM DO RELATÓRIO ======'
