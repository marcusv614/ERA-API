-- ==========================================
-- Script de Testes do Banco de Dados ERA
-- ==========================================

-- 1. TESTE DE CONEXÃO E INFORMAÇÕES GERAIS
\echo '====== 1. INFORMAÇÕES DO BANCO DE DADOS ======'
SELECT version();
SELECT current_database();
SELECT current_user;

-- 2. LISTAR TODAS AS TABELAS
\echo '\n====== 2. TABELAS DO BANCO ======'
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_name;

-- 3. LISTAR TODAS AS FUNÇÕES
\echo '\n====== 3. FUNÇÕES DO BANCO ======'
SELECT routine_name, routine_type
FROM information_schema.routines
WHERE routine_schema = 'public'
ORDER BY routine_name;

-- 4. LISTAR TODOS OS TRIGGERS
\echo '\n====== 4. TRIGGERS DO BANCO ======'
SELECT trigger_name, event_object_table, event_manipulation
FROM information_schema.triggers
WHERE trigger_schema = 'public'
ORDER BY trigger_name;

-- 5. LISTAR SEQUÊNCIAS
\echo '\n====== 5. SEQUÊNCIAS ======'
SELECT sequence_name
FROM information_schema.sequences
WHERE sequence_schema = 'public'
ORDER BY sequence_name;

-- 6. LISTAR ÍNDICES
\echo '\n====== 6. ÍNDICES ======'
SELECT indexname, tablename
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;

-- 7. LISTAR CONSTRAINTS
\echo '\n====== 7. CONSTRAINTS ======'
SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'public'
ORDER BY table_name, constraint_name;

-- 8. VERIFICAR INTEGRIDADE DE CHAVES ESTRANGEIRAS
\echo '\n====== 8. CHAVES ESTRANGEIRAS ======'
SELECT 
    constraint_name,
    table_name,
    column_name,
    referenced_table_name,
    referenced_column_name
FROM information_schema.key_column_usage
WHERE table_schema = 'public' 
AND referenced_table_name IS NOT NULL
ORDER BY table_name;

-- 9. STATUS DAS VIEWS
\echo '\n====== 9. VIEWS ======'
SELECT table_name
FROM information_schema.views
WHERE table_schema = 'public'
ORDER BY table_name;

-- 10. RESUMO GERAL
\echo '\n====== 10. RESUMO ======'
\echo 'Número de tabelas:'
SELECT COUNT(*) 
FROM information_schema.tables 
WHERE table_schema = 'public';

\echo 'Número de funções:'
SELECT COUNT(*) 
FROM information_schema.routines 
WHERE routine_schema = 'public';

\echo 'Número de triggers:'
SELECT COUNT(*) 
FROM information_schema.triggers 
WHERE trigger_schema = 'public';
