----------------------------------------------------------
-- Tabelas detalhadas
----------------------------------------------------------
-- tabela pai dos itens detalhados
CREATE TABLE public.cadoc_6334_item (
    id BIGSERIAL primary key,
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
    cadoc_item_id BIGINT NULL, -- popular depois
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
    cadoc_item_id BIGINT NULL, -- popular depois
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
    cadoc_item_id BIGINT NULL, -- popular depois
    CONSTRAINT estabelecimento_pkey PRIMARY KEY (codigo_estabelecimento),
    FOREIGN KEY (cadoc_item_id) REFERENCES cadoc_6334_item(id),
);
CREATE INDEX idx_cadoc_6334_estabelecimento_cadoc_item_id on cadoc_6334_estabelecimento(cadoc_item_id);


-- tabela detalhamento de terminais
CREATE TABLE public.cadoc_6334_terminal (
    codigo_terminal int8 NOT NULL,
    codigo_estabelecimento int8 NULL,
    tipo_terminal varchar(255) NULL, -- POS compartilhado, POS leitora, PDV
    cadoc_item_id BIGINT NULL, -- popular depois
    CONSTRAINT terminal_pkey PRIMARY KEY (codigo_terminal),
    FOREIGN KEY (codigo_estabelecimento) REFERENCES cadoc_6334_estabelecimento(codigo_estabelecimento),
);
CREATE INDEX idx_cadoc_6334_terminal_codigo_estabelecimento on cadoc_6334_terminal(codigo_estabelecimento);


------------------------------------------
-- tabelas sumarizadas
-----------------------------------
-- tabela pai dos extratos detalhados
CREATE TABLE public.cadoc_6334 (
    id BIGSERIAL primary key,
    sync_status INT4 default 0,
    created_at timestamp default CURRENT_TIMESTAMP,
    updated_at timestamp default CURRENT_TIMESTAMP
);
CREATE INDEX idx_cadoc_6334_sync_status on cadoc_6334(sync_status);
CREATE INDEX idx_cadoc_6334_created_at on cadoc_6334(created_at);
CREATE INDEX idx_cadoc_6334_updated_at on cadoc_6334(updated_at);


-- Tabela de ranking cadoc 6334 e índices
CREATE TABLE public.cadoc_6334_ranking (
    Id BIGSERIAL PRIMARY KEY,
    CadocBaseId BIGINT NULL, -- popular depois
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    CodigoEstabelecimento VARCHAR(8) NOT NULL, -- ec
    Funcao VARCHAR(1) NOT NULL,   -- débito/crédito
    Bandeira NUMERIC(2, 0) NOT NULL, -- visa/master/elo
    FormaCaptura NUMERIC(1, 0) NOT NULL, -- tarja, chip, contactless, online
    NumeroParcelas NUMERIC(2, 0) NOT NULL, -- 1 a 12
    CodigoSegmento NUMERIC(3, 0) NOT NULL, -- mcc -> segmento
    ValorTransacoes NUMERIC(15, 2) NOT NULL,   -- valor transação
    QuantidadeTransacoes NUMERIC(12, 0) NOT NULL, -- qtde transações
    TaxaDescontoMedia NUMERIC(5, 2) NOT NULL, -- taxa redeflex
    FOREIGN KEY (CadocBaseId) REFERENCES cadoc_6334_base(Id)
);
CREATE INDEX idx_cadoc_6334_ranking_CadocBaseId ON cadoc_6334_ranking(CadocBaseId);
CREATE UNIQUE INDEX uk_cadoc_6334_ranking ON cadoc_6334_ranking(Ano, Trimestre, CodigoEstabelecimento, Funcao, Bandeira, FormaCaptura, NumeroParcelas, CodigoSegmento);


-- Tabela de desconto cadoc 6334 e índices
CREATE TABLE public.cadoc_6334_desconto (
    Id SERIAL PRIMARY KEY,
    CadocBaseId BIGINT NULL, -- popular depois
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    Funcao VARCHAR(1) NOT NULL,
    Bandeira NUMERIC(2, 0) NOT NULL,
    FormaCaptura NUMERIC(1, 0) NOT NULL,
    NumeroParcelas NUMERIC(2, 0) NOT NULL,
    CodigoSegmento NUMERIC(3, 0) NOT NULL,
    TaxaDescontoMedia NUMERIC(5, 2) NOT NULL,
    TaxaDescontoMinima NUMERIC(5, 2) NOT NULL,
    TaxaDescontoMaxima NUMERIC(5, 2) NOT NULL,
    DesvioPadraoTaxaDesconto NUMERIC(5, 2) NOT NULL,
    ValorTransacoes NUMERIC(15, 2) NOT NULL,
    QuantidadeTransacoes NUMERIC(12, 0) NOT NULL,
    FOREIGN KEY (CadocBaseId) REFERENCES cadoc_6334_base(Id)
);
CREATE INDEX idx_cadoc_6334_desconto_CadocBaseId ON cadoc_6334_desconto(CadocBaseId);
CREATE UNIQUE INDEX uk_cadoc_6334_desconto ON cadoc_6334_desconto(Ano, Trimestre, Funcao, Bandeira, FormaCaptura, NumeroParcelas, CodigoSegmento);

-- Tabela de intercâmbio cadoc 6334 e índices
CREATE TABLE public.cadoc_6334_intercam (
    Id SERIAL PRIMARY KEY,
    CadocBaseId BIGINT NULL, -- popular depois
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    Produto NUMERIC(2, 0) NOT NULL,
    ModalidadeCartao VARCHAR(1) NOT NULL,
    Funcao VARCHAR(1) NOT NULL,
    Bandeira NUMERIC(2, 0) NOT NULL,
    FormaCaptura NUMERIC(1, 0) NOT NULL,
    NumeroParcelas NUMERIC(2, 0) NOT NULL,
    CodigoSegmento NUMERIC(3, 0) NOT NULL,
    TarifaIntercambio NUMERIC(5, 2) NOT NULL,
    ValorTransacoes NUMERIC(15, 2) NOT NULL,
    QuantidadeTransacoes NUMERIC(12, 0) NOT NULL,
    FOREIGN KEY (CadocBaseId) REFERENCES cadoc_6334_base(Id)
);

CREATE INDEX idx_cadoc_6334_intercam_CadocBaseId ON cadoc_6334_intercam(CadocBaseId);
CREATE UNIQUE INDEX uk_cadoc_6334_intercam ON cadoc_6334_intercam(Ano, Trimestre, Produto, ModalidadeCartao, Funcao, Bandeira, FormaCaptura, NumeroParcelas, CodigoSegmento);

-- Tabela de conc. credenciamento cadoc 6334 e índices
CREATE TABLE public.cadoc_6334_conccred (
    Id SERIAL PRIMARY KEY,
    CadocBaseId BIGINT NULL, -- popular depois
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    Bandeira NUMERIC(2, 0) NOT NULL,
    Funcao VARCHAR(1) NOT NULL,
    QuantidadeEstabelecimentosCredenciados NUMERIC(9, 0) NOT NULL,
    QuantidadeEstabelecimentosAtivos NUMERIC(9, 0) NOT NULL,
    ValorTransacoes NUMERIC(15, 2) NOT NULL,
    QuantidadeTransacoes NUMERIC(12, 0) NOT NULL,
    FOREIGN KEY (CadocBaseId) REFERENCES cadoc_6334_base(Id)
);
CREATE INDEX idx_cadoc_6334_conccred_CadocBaseId ON cadoc_6334_conccred(CadocBaseId);
CREATE UNIQUE INDEX uk_cadoc_6334_conccred ON cadoc_6334_conccred(Ano, Trimestre, Bandeira, Funcao);


-- Tabela de infraestrutura cadoc 6334 e índices
CREATE TABLE public.cadoc_6334_infresta (
    Id SERIAL PRIMARY KEY,
    CadocBaseId BIGINT NULL, -- popular depois
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    Uf VARCHAR(2) NOT NULL,
    QuantidadeEstabelecimentosTotais NUMERIC(8, 0) NOT NULL,
    QuantidadeEstabelecimentosCapturaManual NUMERIC(8, 0) NOT NULL,
    QuantidadeEstabelecimentosCapturaEletronica NUMERIC(8, 0) NOT NULL,
    QuantidadeEstabelecimentosCapturaRemota NUMERIC(8, 0) NOT NULL,
    FOREIGN KEY (CadocBaseId) REFERENCES cadoc_6334_base(Id)
);
CREATE INDEX idx_cadoc_6334_infresta_CadocBaseId ON cadoc_6334_infresta(CadocBaseId);
CREATE UNIQUE INDEX uk_cadoc_6334_infresta ON cadoc_6334_infresta(Ano, Trimestre, Uf);

-- Tabela de infraestrutura terminais cadoc 6334 e índices
CREATE TABLE public.cadoc_6334_infrterm (
    Id SERIAL PRIMARY KEY,
    CadocBaseId BIGINT NULL, -- popular depois
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    Uf VARCHAR(2) NOT NULL,
    QuantidadePOSCompartilhados NUMERIC(8, 0) NOT NULL,
    QuantidadePOSLeitoraChip NUMERIC(8, 0) NOT NULL,
    QuantidadePDV NUMERIC(8, 0) NOT NULL,
    FOREIGN KEY (CadocBaseId) REFERENCES cadoc_6334_base(Id)
);
CREATE INDEX idx_cadoc_6334_infrterm_CadocBaseId ON cadoc_6334_infrterm(CadocBaseId);
CREATE UNIQUE INDEX uk_cadoc_6334_infrterm ON cadoc_6334_infrterm(Ano, Trimestre, Uf);

-- Tabela de segmentos cadoc 6334 e índices
CREATE TABLE public.cadoc_6334_segmento (
    Id SERIAL PRIMARY KEY,
    CadocBaseId BIGINT NULL, -- popular depois
    -- dados
    NomeSegmento VARCHAR(50) NOT NULL,
    DescricaoSegmento VARCHAR(255) NOT NULL,
    CodigoSegmento NUMERIC(3, 0) NOT NULL,
    FOREIGN KEY (CadocBaseId) REFERENCES cadoc_6334_base(Id)
);
CREATE INDEX idx_cadoc_6334_segmento_CadocBaseId ON cadoc_6334_segmento(CadocBaseId);
CREATE UNIQUE INDEX uk_cadoc_6334_segmento ON cadoc_6334_segmento(CodigoSegmento);

-- Tabela de lucro credenciamento cadoc 6334 e índices
CREATE TABLE public.cadoc_6334_lucrcred (
    Id SERIAL PRIMARY KEY,
    CadocBaseId BIGINT NULL, -- popular depois
    -- dados
    Ano NUMERIC(4, 0),
    Trimestre NUMERIC(1, 0) NOT NULL,
    ReceitaTaxaDescontoBruta NUMERIC(12, 2) NOT NULL,
    ReceitaAluguelEquipamentosConectividade NUMERIC(12, 2) NOT NULL,
    ReceitaOutras NUMERIC(12, 2) NOT NULL,
    CustoTarifaIntercambio NUMERIC(12, 2) NOT NULL,
    CustoMarketingPropaganda NUMERIC(12, 2) NOT NULL,
    CustoTaxasAcessoBandeiras NUMERIC(12, 2) NOT NULL,
    CustoRisco NUMERIC(12, 2) NOT NULL,
    CustoProcessamento NUMERIC(12, 2) NOT NULL,
    CustoOutros NUMERIC(12, 2) NOT NULL,
    FOREIGN KEY (CadocBaseId) REFERENCES cadoc_6334_base(Id)
);
CREATE INDEX idx_cadoc_6334_lucrcred_CadocBaseId ON cadoc_6334_lucrcred(CadocBaseId);
CREATE UNIQUE INDEX uk_cadoc_6334_lucrcred ON cadoc_6334_lucrcred(Ano, Trimestre);

-- Tabela de contatos cadoc 6334 e índices
CREATE TABLE public.cadoc_6334_contatos (
    Id SERIAL PRIMARY KEY,
    CadocBaseId BIGINT NULL, -- popular depois
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    TipoContato VARCHAR(1) NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Telefone VARCHAR(50) NOT NULL,
    FOREIGN KEY (CadocBaseId) REFERENCES cadoc_6334_base(Id)
);
CREATE INDEX idx_cadoc_6334_contatos_CadocBaseId ON cadoc_6334_contatos(CadocBaseId);
CREATE UNIQUE INDEX uk_cadoc_6334_contatos ON cadoc_6334_contatos(Ano, Trimestre, TipoContato, Nome);

------------------------------------------------------------------
-- RELACIONAMENTO ENTRE BASE E ITENS    
------------------------------------------------------------------
CREATE TABLE public.cadoc_6334_base_item (
    cadoc_base_id BIGINT NOT NULL,
    cadoc_item_id BIGINT NOT NULL,
    PRIMARY KEY (cadoc_base_id, cadoc_item_id),
    FOREIGN KEY (cadoc_base_id) REFERENCES cadoc_6334(id),
    FOREIGN KEY (cadoc_item_id) REFERENCES cadoc_6334_item(id)
);
CREATE INDEX idx_cadoc_6334_base_item_cadoc_base_id on cadoc_6334_base_item(cadoc_base_id);
CREATE INDEX idx_cadoc_6334_base_item_cadoc_item_id on cadoc_6334_base_item(cadoc_item_id);


----------------------------------------------------------------------
-- TABELAS DE APOIO
----------------------------------------------------------------------
-- Tabela base cadoc 6334 e índices


