-- Initial schema based on existing database
CREATE TABLE IF NOT EXISTS categoria (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT
);

CREATE TABLE IF NOT EXISTS usuario (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha_hash TEXT NOT NULL,
    cargo VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS localizacao (
    id BIGSERIAL PRIMARY KEY,
    rua VARCHAR(20) NOT NULL,
    ilha VARCHAR(20) NOT NULL,
    andar VARCHAR(20) NOT NULL,
    observacao TEXT,
    UNIQUE (rua, ilha, andar)
);

CREATE TABLE IF NOT EXISTS produto (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    nome VARCHAR(200) NOT NULL,
    descricao TEXT,
    categoria_id BIGINT NOT NULL REFERENCES categoria(id),
    unidade_medida VARCHAR(30) NOT NULL,
    estoque_minimo NUMERIC(10,2) DEFAULT 0,
    controla_serial BOOLEAN DEFAULT FALSE,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS estoque (
    id BIGSERIAL PRIMARY KEY,
    produto_id BIGINT NOT NULL REFERENCES produto(id),
    localizacao_id BIGINT NOT NULL REFERENCES localizacao(id),
    quantidade_atual NUMERIC(12,2)
);

-- additional tables simplified
CREATE TABLE IF NOT EXISTS entrada (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT REFERENCES usuario(id),
    data_entrada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    numero_nota VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS entrada_item (
    id BIGSERIAL PRIMARY KEY,
    entrada_id BIGINT NOT NULL REFERENCES entrada(id),
    produto_id BIGINT NOT NULL REFERENCES produto(id),
    quantidade NUMERIC(12,2) NOT NULL,
    valor_unitario NUMERIC(12,2)
);

CREATE TABLE IF NOT EXISTS retirada (
    id BIGSERIAL PRIMARY KEY,
    usuario_responsavel_id BIGINT REFERENCES usuario(id),
    data_retirada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    motivo TEXT,
    status VARCHAR(30) DEFAULT 'ABERTA'
);

CREATE TABLE IF NOT EXISTS retirada_item (
    id BIGSERIAL PRIMARY KEY,
    retirada_id BIGINT NOT NULL REFERENCES retirada(id),
    produto_id BIGINT NOT NULL REFERENCES produto(id),
    quantidade NUMERIC(12,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS devolucao (
    id BIGSERIAL PRIMARY KEY,
    retirada_id BIGINT REFERENCES retirada(id),
    usuario_id BIGINT REFERENCES usuario(id),
    data_devolucao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    observacao TEXT
);

CREATE TABLE IF NOT EXISTS devolucao_item (
    id BIGSERIAL PRIMARY KEY,
    devolucao_id BIGINT NOT NULL REFERENCES devolucao(id),
    produto_id BIGINT NOT NULL REFERENCES produto(id),
    quantidade NUMERIC(12,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS movimentacao (
    id BIGSERIAL PRIMARY KEY,
    usuario_id BIGINT REFERENCES usuario(id),
    produto_id BIGINT REFERENCES produto(id),
    tipo VARCHAR(50),
    quantidade NUMERIC(12,2),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_estoque_produto_id ON estoque(produto_id);
CREATE INDEX IF NOT EXISTS idx_estoque_localizacao_id ON estoque(localizacao_id);
