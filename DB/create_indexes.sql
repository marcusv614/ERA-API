-- Índices recomendados para melhorar performance nas consultas de estoque e movimentações

CREATE INDEX IF NOT EXISTS idx_estoque_produto_id ON estoque(produto_id);
CREATE INDEX IF NOT EXISTS idx_estoque_localizacao_id ON estoque(localizacao_id);
CREATE INDEX IF NOT EXISTS idx_movimentacao_usuario_id ON movimentacao(usuario_id);

CREATE INDEX IF NOT EXISTS idx_entrada_item_produto_id ON entrada_item(produto_id);
CREATE INDEX IF NOT EXISTS idx_retirada_item_produto_id ON retirada_item(produto_id);
CREATE INDEX IF NOT EXISTS idx_devolucao_item_produto_id ON devolucao_item(produto_id);

-- Índices adicionais úteis
CREATE INDEX IF NOT EXISTS idx_produto_categoria_id ON produto(categoria_id);
CREATE INDEX IF NOT EXISTS idx_entrada_usuario_id ON entrada(usuario_id);
CREATE INDEX IF NOT EXISTS idx_retirada_usuario_responsavel_id ON retirada(usuario_responsavel_id);
