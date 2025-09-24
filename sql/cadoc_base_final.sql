
-- tabela pai dos itens detalhados
CREATE TABLE public.cadoc_6334_item (
    id serial primary key,
    sync_status int4 default 0,
    created_at timestamp default CURRENT_TIMESTAMP,
    updated_at timestamp default CURRENT_TIMESTAMP
);
CREATE INDEX idx_cadoc_6334_item_sync_status on cadoc_6334_item(sync_status);
CREATE INDEX idx_cadoc_6334_item_created_at on cadoc_6334_item(created_at);
CREATE INDEX idx_cadoc_6334_item_updated_at on cadoc_6334_item(updated_at);

-- tabela detalhamento de transacoes do gestao
CREATE TABLE public.cadoc_6334_transacao_gestao (
	cd_transacao_fin int8 NOT NULL,
	dt_processamento timestamp NULL,
    valor_transacao numeric(38, 2) NULL,
	bandeira varchar(255) NULL,
	codigo_estabelecimento int8 NULL,
	mcc varchar(4) NULL, 
    segmento int NULL, -- popular depois
	forma_captura varchar(255) NULL,
	funcao varchar(255) NULL,
	numero_parcelas int4 NULL,
	percentual_desconto numeric(38, 2) NULL,
	taxa_desconto_total numeric(38, 2) NULL,
    cadoc_item_id int8 NULL, -- popular depois
	CONSTRAINT transacao_financeira_pkey PRIMARY KEY (cd_transacao_fin),
    FOREIGN KEY (cadoc_item_id) REFERENCES cadoc_6334_item(id),
);
CREATE INDEX idx_cadoc_6334_transacao_gestao_cadoc_item_id on cadoc_6334_transacao_gestao(cadoc_item_id);
CREATE INDEX idx_cadoc_6334_transacao_gestao_dt_processamento on cadoc_6334_transacao_gestao(dt_processamento);
CREATE INDEX idx_cadoc_6334_transacao_gestao_codigo_estabelecimento on cadoc_6334_transacao_gestao(codigo_estabelecimento);


-- tabela detalhamento de transacoes do gestao
CREATE TABLE public.cadoc_6334_transacao_intercambio (
	cd_transacao_fin int8 NOT NULL,
    dt_processamento timestamp NULL,
    valor_transacao numeric(38, 2) NULL,
    percentual_desconto numeric(5, 2) NULL,
    taxa_intercambio_valor numeric(38, 2) NULL,
    bin int8 NULL,
    modalidade_cartao int4 NULL, -- popular depois
    produto_cartao int4 NULL, -- popular depois
    cadoc_item_id int8 NULL, -- popular depois
	CONSTRAINT transacao_financeira_pkey PRIMARY KEY (cd_transacao_fin),
    FOREIGN KEY (cadoc_item_id) REFERENCES cadoc_6334_item(id),
);
CREATE INDEX idx_cadoc_6334_transacao_intercambio_cadoc_item_id on cadoc_6334_transacao_intercambio(cadoc_item_id);
CREATE INDEX idx_cadoc_6334_transacao_intercambio_dt_processamento on cadoc_6334_transacao_intercambio(dt_processamento);


-- tabela detalhamento de estabelecimentos
CREATE TABLE public.cadoc_6334_estabelecimento (
    codigo_estabelecimento int8 NOT NULL,
    data_credenciamento DATETIME NULL,
    data_ultima_transacao DATETIME NULL,
    razao_social varchar(255) NULL,
    cnpj varchar(18) NULL,
    cpf varchar(14) NULL,
    uf varchar(2) NULL,
    tem_debito boolean NULL,
    tem_credito boolean NULL,
    tem_visa boolean NULL,
    tem_mastercard boolean NULL,
    tem_elo boolean NULL,
    mcc varchar(4) NULL,
    segmento int4 NULL, -- popular depois
    captura_manual boolean NULL,
    captura_eletronica boolean NULL,
    captura_remota boolean NULL,
    cadoc_item_id int8 NULL, -- popular depois
    CONSTRAINT estabelecimento_pkey PRIMARY KEY (codigo_estabelecimento),
    FOREIGN KEY (cadoc_item_id) REFERENCES cadoc_6334_item(id),
);
CREATE INDEX idx_cadoc_6334_estabelecimento_cadoc_item_id on cadoc_6334_estabelecimento(cadoc_item_id);


-- tabela detalhamento de terminais
CREATE TABLE public.cadoc_6334_terminal (
    codigo_terminal int8 NOT NULL,
    codigo_estabelecimento int8 NULL,
    tipo_terminal varchar(255) NULL, -- POS compartilhado, POS leitora, PDV
    cadoc_item_id int8 NULL, -- popular depois
    CONSTRAINT terminal_pkey PRIMARY KEY (codigo_terminal),
    FOREIGN KEY (codigo_estabelecimento) REFERENCES cadoc_6334_estabelecimento(codigo_estabelecimento),
);
CREATE INDEX idx_cadoc_6334_terminal_codigo_estabelecimento on cadoc_6334_terminal(codigo_estabelecimento);





