------------------------------------------------------------------------
-- BASE PRINCIPAL CADOC 6334
--------------------------------------------------------------------------

-- Tabela base cadoc base e indices
CREATE TABLE cadoc_6334_base (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    -- controle
    SyncStatus INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
);
create index idx_cadoc_6334_base_SyscStatus on cadoc_6334_base(SyncStatus);
create index idx_cadoc_6334_base_CreatedAt on cadoc_6334_base(CreatedAt);
create index idx_cadoc_6334_base_UpdatedAt on cadoc_6334_base(UpdatedAt);

-- Tabela de ranking cadoc 6334 e indices
CREATE TABLE cadoc_6334_ranking (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CadocBaseId INT NOT NULL,
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    CodigoEstabelecimento NVARCHAR(8) NOT NULL, -- ec
    Funcao NVARCHAR(1) NOT NULL,   -- debito/credito
    Bandeira NUMERIC(2, 0) NOT NULL, -- visa/master/elo
    FormaCaptura NUMERIC (1, 0) NOT NULL, -- tarja, chip, contactless, online
    NumeroParcelas NUMERIC(2, 0) NOT NULL, -- 1 a 12
    CodigoSegmento NUMERIC(3, 0) NOT NULL, -- mcc -> segmento
    ValorTransacoes NUMERIC(15, 2) NOT NULL,   -- valor transacao
    QuantidadeTransacoes NUMERIC(12, 0) NOT NULL, -- qtde trasacoes
    TaxaDescontoMedia NUMERIC(4, 2) NOT NULL -- taxa redeflex
);
create index idx_cadoc_6334_ranking_CadocBaseId on cadoc_6334_ranking(CadocBaseId);
create foreign key (CadocBaseId) references cadoc_6334_base(Id);
create unique index uk_cadoc_6334_ranking on cadoc_6334_ranking(Ano, Trimestre, CodigoEstabelecimento, Funcao, Bandeira, FormaCaptura, NumeroParcelas, CodigoSegmento);


-- Tabela de desconto Cadoc 6334 e indices
CREATE TABLE cadoc_6334_desconto (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CadocBaseId INT NOT NULL,
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    Funcao NVARCHAR(1) NOT NULL,
    Bandeira NUMERIC(2, 0) NOT NULL,
    FormaCaptura NUMERIC (1, 0) NOT NULL, -- 1 - tarja, 2 - chip, 4 - online, 5 - contactless (nfc), 6 - recorrente
    NumeroParcelas NUMERIC(2, 0) NOT NULL,
    CodigoSegmento NUMERIC(3, 0) NOT NULL,
    TaxaDescontoMedia NUMERIC(4, 2) NOT NULL,  -- avg
    TaxaDescontoMinima NUMERIC(4, 2) NOT NULL, -- min
    TaxaDescontoMaxima NUMERIC(4, 2) NOT NULL, -- max 
    DesvioPadraoTaxaDesconto NUMERIC(4, 2) NOT NULL, -- stddev
    ValorTransacoes NUMERIC(15, 2) NOT NULL,      -- sum
    QuantidadeTransacoes NUMERIC(12, 0) NOT NULL  -- count
);
create index idx_cadoc_6334_desconto_CadocBaseId on cadoc_6334_desconto(CadocBaseId);
create foreign key (CadocBaseId) references cadoc_6334_base(Id);
create unique index uk_cadoc_6334_desconto on cadoc_6334_desconto(Ano, Trimestre, Funcao, Bandeira, FormaCaptura, NumeroParcelas, CodigoSegmento);

-- Tabela de intercam Cadoc 6334 e indices
CREATE TABLE cadoc_6334_intercam (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CadocBaseId INT NOT NULL,
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    Produto NUMERIC(2, 0) NOT NULL,
    ModalidadeCartao NVARCHAR(1) NOT NULL,
    Funcao NVARCHAR(1) NOT NULL,
    Bandeira NUMERIC(2, 0) NOT NULL,
    FormaCaptura NUMERIC (1, 0) NOT NULL,  -- 1 - tarja, 2 - chip, 4 - online, 5 - contactless (nfc), 6 - recorrente
    NumeroParcelas NUMERIC(2, 0) NOT NULL,
    CodigoSegmento NUMERIC(3, 0) NOT NULL, -- mcc
    TarifaIntercambio NUMERIC(4, 2) NOT NULL, -- avg
    ValorTransacoes NUMERIC(15, 2) NOT NULL, -- sum
    QuantidadeTransacoes NUMERIC(12, 0) NOT NULL -- count
);
create index idx_cadoc_6334_intercam_CadocBaseId on cadoc_6334_intercam(CadocBaseId);
create foreign key (CadocBaseId) references cadoc_6334_base(Id);
create unique index uk_cadoc_6334_intercam on cadoc_6334_intercam(Ano, Trimestre, Produto, ModalidadeCartao, Funcao, Bandeira, FormaCaptura, NumeroParcelas, CodigoSegmento);

-- Tabela de conccred Cadoc 6334 e indices
CREATE TABLE cadoc_6334_conccred (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CadocBaseId INT NOT NULL,
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    Bandeira NUMERIC(2, 0) NOT NULL,
    Funcao NVARCHAR(1) NOT NULL,
    QuantidadeEstabelecimentosCredenciados NUMERIC(9, 0) NOT NULL,
    QuantidadeEstabelecimentosAtivos NUMERIC(9, 0) NOT NULL,
    ValorTransacoes NUMERIC(15, 2) NOT NULL,
    QuantidadeTransacoes NUMERIC(12, 0) NOT NULL
);
create index idx_cadoc_6334_conccred_CadocBaseId on cadoc_6334_conccred(CadocBaseId);
create foreign key (CadocBaseId) references cadoc_6334_base(Id);
create unique index uk_cadoc_6334_conccred on cadoc_6334_conccred(Ano, Trimestre, Bandeira, Funcao);

-- Tabela de infrest Cadoc 6334 e indices
CREATE TABLE cadoc_6334_infresta (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CadocBaseId INT NOT NULL,
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    Uf NVARCHAR(2) NOT NULL,
    QuantidadeEstabelecimentosTotais NUMERIC(8, 0) NOT NULL,
    QuantidadeEstabelecimentosCapturaManual NUMERIC(8, 0) NOT NULL,
    QuantidadeEstabelecimentosCapturaEletronica NUMERIC(8, 0) NOT NULL,
    QuantidadeEstabelecimentosCapturaRemota NUMERIC(8, 0) NOT NULL,
);
create index idx_cadoc_6334_infresta_CadocBaseId on cadoc_6334_infresta(CadocBaseId);
create foreign key (CadocBaseId) references cadoc_6334_base(Id);
create unique index uk_cadoc_6334_infresta on cadoc_6334_infresta(Ano, Trimestre, Uf);


-- Tabela de infrterm Cadoc 6334 e indices
CREATE TABLE cadoc_6334_infrterm (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CadocBaseId INT NOT NULL,
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    Uf NVARCHAR(2) NOT NULL,
    QuantidadePOSCompartilhados NUMERIC(8, 0) NOT NULL,
    QuantidadePOSLeitoraChip NUMERIC(8, 0) NOT NULL,
    QuantidadePDV NUMERIC(8, 0) NOT NULL,
);
create index idx_cadoc_6334_infrterm_CadocBaseId on cadoc_6334_infrterm(CadocBaseId);
create foreign key (CadocBaseId) references cadoc_6334_base(Id);
create unique index uk_cadoc_6334_infrterm on cadoc_6334_infrterm(Ano, Trimestre, Uf);

-- Tabela de segmento Cadoc 6334 e indices
CREATE TABLE cadoc_6334_segmento (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CadocBaseId INT NOT NULL,
    -- dados
    NomeSegmento NVARCHAR(50) NOT NULL,
    DescricaoSegmento NVARCHAR(255) NOT NULL,
    CodigoSegmento NUMERIC(3, 0) NOT NULL
);
create index idx_cadoc_6334_segmento_CadocBaseId on cadoc_6334_segmento(CadocBaseId);
create foreign key (CadocBaseId) references cadoc_6334_base(Id);
create unique index uk_cadoc_6334_segmento on cadoc_6334_segmento(CodigoSegmento);

-- Tabela de lucrcred Cadoc 6334 e indices
CREATE TABLE cadoc_6334_lucrcred (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CadocBaseId INT NOT NULL,
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    ReceitaTaxaDescontoBruta NUMERIC(12, 2) NOT NULL,
    ReceitaAluguelEquipamentosConectividade NUMERIC(12, 2) NOT NULL,
    ReceitaOutras NUMERIC(12, 2) NOT NULL,
    CustoTarifaIntercambio NUMERIC(12, 2) NOT NULL,
    CustoMarketingPropaganda NUMERIC(12, 2) NOT NULL,
    CustoTaxasAcessoBandeiras NUMERIC(12, 2) NOT NULL,
    CustoRisco NUMERIC(12, 2) NOT NULL,
    CustoProcessamento NUMERIC(12, 2) NOT NULL,
    CustoOutros NUMERIC(12, 2) NOT NULL
);
create index idx_cadoc_6334_lucrcred_CadocBaseId on cadoc_6334_lucrcred(CadocBaseId);
create foreign key (CadocBaseId) references cadoc_6334_base(Id);
create unique index uk_cadoc_6334_lucrcred on cadoc_6334_lucrcred(Ano, Trimestre);

-- Tabela de contatos Cadoc 6334 e indices
CREATE TABLE cadoc_6334_contatos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CadocBaseId INT NOT NULL,
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    TipoContato NVARCHAR(1) NOT NULL,
    Nome NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    Telefone NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL
)
create index idx_cadoc_6334_contatos_CadocBaseId on cadoc_6334_contatos(CadocBaseId);
create foreign key (CadocBaseId) references cadoc_6334_base(Id);
create unique index uk_cadoc_6334_contatos on cadoc_6334_contatos(Ano, Trimestre, TipoContato, Nome);

------------------------------------------------------------------------
-- BASE DETALHADA CADOC 6334
--------------------------------------------------------------------------
-- Tabela de contatos Cadoc 6334 e indices
CREATE TABLE cadoc_6334_item (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    -- controle
    SyncStatus INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
);
create index idx_cadoc_6334_item_SyncStatus on cadoc_6334_item(SyncStatus);
create index idx_cadoc_6334_item_CreatedAt on cadoc_6334_item(CreatedAt);
create index idx_cadoc_6334_item_UpdatedAt on cadoc_6334_item(UpdatedAt);

-- transacoes
CREATE TABLE cadoc_6334_transacao (
    Id INT IDENTITY(1, 1) PRIMARY KEY,
    CadocItemId INT NOT NULL,
    -- dados captura
    DataTransacao DATE,
    HoraTransacao TIME,
    codigo_transacao NVARCHAR(50),
    nsu NVARCHAR(50),
    codigo_autorizacao NVARCHAR(50),
    funcao NVARCHAR(50),
    bandeira NVARCHAR(50),
    forma_captura NVARCHAR(50),
    parcelas NUMERIC(2, 0),
    -- dados cartao
    bin_cartao NUMERIC(6, 0),
    modalidade_cartao NUMERIC(3, 0),
    -- dados estabelecimento
    codigo_estabelecimento NVARCHAR(50),
    mcc NUMERIC(5, 0),
    segmento NUMERIC(5, 0),
    -- dados terminal
    codigo_terminal NVARCHAR(50),
    -- valores
    valor_transacao NUMERIC(12, 2) NOT NULL,
    iof_percentagem NUMERIC(5, 2) NOT NULL,
    iof_valor NUMERIC(12, 2) not NULL,
    valor_liquido_iof NUMERIC(12, 2) NOT NULL,
    desconto_percentagem NUMERIC(5, 2) NOT NULL,
    desconto_valor NUMERIC(12, 2) NOT NULL,
    intercambio_percentagem NUMERIC(5, 2),
    intercambio_valor NUMERIC (12, 2)
    -- referencias
    codigo_gestao NVARCHAR(50),
    codigo_intercambio NVARCHAR(50)
);
create index idx_cadoc_6334_transacao_CadocItemId on cadoc_6334_transacao(CadocItemId);
create foreign key (CadocItemId) references cadoc_6334_item(Id);
create unique index uk_cadoc_6334_transacao on cadoc_6334_transacao(codigo_transacao);

-- estabelecimento
CREATE TABLE cadoc_6334_estabelecimento (
    Id INT IDENTITY(1, 1) PRIMARY KEY,
    CadocItemId INT NOT NULL,
    -- dados
    codigo_estabelecimento NVARCHAR(50),
    data_ultima_transacao DATE,
    mcc NUMERIC(5, 0),
    segmento NUMERIC(5, 0),
    captura_manual BIT,
    captura_eletronica BIT,
    captura_remota BIT
)
create index idx_cadoc_6334_estabelecimento_CadocItemId on cadoc_6334_estabelecimento(CadocItemId);
create foreign key (CadocItemId) references cadoc_6334_item(Id);
create unique index uk_cadoc_6334_estabelecimento on cadoc_6334_estabelecimento(codigo_estabelecimento);

-- terminal
CREATE TABLE cadoc_6334_terminal (
    Id INT IDENTITY(1, 1) PRIMARY KEY,
    CadocItemId INT NOT NULL,
    -- dados
    codigo_terminal NVARCHAR(50),
    codigo_estabelecimento NVARCHAR(50),
    tipo_terminal NVARCHAR(10), -- POS compartilhado, POS leitora, PDV
); 

create index idx_cadoc_6334_terminal_CadocItemId on cadoc_6334_terminal(CadocItemId);
create foreign key (CadocItemId) references cadoc_6334_item(Id);
create unique index uk_cadoc_6334_terminal on cadoc_6334_terminal(codigo_terminal);

------------------------------------------------------------------------
-- BASE DE APOIO CADOC 6334
--------------------------------------------------------------------------
CREATE TABLE cadoc_6334_segmento_mcc (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    mcc_init int NOT NULL,
    mcc_end int NOT NULL,
    segmento varchar(255) NOT NULL
);
CREATE INDEX idx_cadoc_6334_segmento_mcc_mcc_init ON cadoc_6334_segmento_mcc(mcc_init, mcc_end);
CREATE INDEX idx_cadoc_6334_segmento_mcc_mcc_end ON cadoc_6334_segmento_mcc(mcc_end);

insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5977, 5977, 401);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7298, 7298, 401);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7230, 7230, 401);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5997, 5997, 401);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7297, 7297, 401);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5812, 5812, 402);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5813, 5813, 402);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5814, 5814, 402);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7932, 7932, 402);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (3000, 3350, 403);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4511, 4511, 403);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4582, 4582, 403);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7929, 7929, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7832, 7832, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7999, 7999, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7933, 7933, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5733, 5733, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5971, 5971, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5940, 5940, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5941, 5941, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7841, 7841, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7911, 7911, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7941, 7941, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7994, 7994, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7997, 7997, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7996, 7996, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7991, 7991, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7998, 7998, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7992, 7992, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7922, 7922, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7829, 7829, 404);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8211, 8211, 405);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8220, 8220, 405);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8241, 8241, 405);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8244, 8244, 405);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8249, 8249, 405);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8299, 8299, 405);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8351, 8351, 405);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5816, 5816, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5045, 5045, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5722, 5722, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5732, 5732, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7622, 7622, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7629, 7629, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5065, 5065, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4816, 4816, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5734, 5734, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7372, 7372, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7375, 7375, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7379, 7379, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5817, 5817, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5818, 5818, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5978, 5978, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5815, 5815, 406);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5047, 5047, 407);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5122, 5122, 407);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5912, 5912, 407);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5975, 5975, 407);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5976, 5976, 407);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5300, 5300, 408);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5715, 5715, 408);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7299, 7299, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7333, 7333, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7342, 7342, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7349, 7349, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7211, 7211, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7210, 7210, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7216, 7216, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8734, 8734, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5933, 5933, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7321, 7321, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7322, 7322, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (6211, 6211, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7339, 7339, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7395, 7395, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7399, 7399, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7221, 7221, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7261, 7261, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7273, 7273, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7276, 7276, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7277, 7277, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7311, 7311, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7361, 7361, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7392, 7392, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7393, 7393, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5963, 5963, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5969, 5969, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8111, 8111, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8911, 8911, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8931, 8931, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8999, 8999, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8699, 8699, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8398, 8398, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8641, 8641, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8651, 8651, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8661, 8661, 409);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (9406, 9406, 410);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7995, 7995, 410);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7800, 7800, 410);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7801, 7801, 410);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7802, 7802, 410);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7338, 7338, 411);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5192, 5192, 411);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5735, 5735, 411);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5942, 5942, 411);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (2741, 2741, 411);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5044, 5044, 411);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5111, 5111, 411);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5943, 5943, 411);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5994, 5994, 411);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5422, 5422, 412);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5441, 5441, 412);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5451, 5451, 412);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5462, 5462, 412);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5499, 5499, 412);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5811, 5811, 412);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5199, 5199, 412);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7641, 7641, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5072, 5072, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7217, 7217, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5039, 5039, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5200, 5200, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5211, 5211, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5231, 5231, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5251, 5251, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5261, 5261, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5712, 5712, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5713, 5713, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5714, 5714, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5718, 5718, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5719, 5719, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (1520, 1520, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (1711, 1711, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (1731, 1731, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (1740, 1740, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (1750, 1750, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (1799, 1799, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7394, 7394, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7623, 7623, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7692, 7692, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5051, 5051, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5074, 5074, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5085, 5085, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5099, 5099, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5021, 5021, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5996, 5996, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (780, 780, 413);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5411, 5411, 414);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5331, 5331, 414);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5399, 5399, 414);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5999, 5999, 414);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5542, 5542, 415);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5983, 5983, 415);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5541, 5541, 415);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5655, 5655, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5137, 5137, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5139, 5139, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5611, 5611, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5621, 5621, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5631, 5631, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5651, 5651, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5661, 5661, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5681, 5681, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5691, 5691, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5697, 5697, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5698, 5698, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7631, 7631, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5949, 5949, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5131, 5131, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5094, 5094, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5944, 5944, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7296, 7296, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7251, 7251, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5641, 5641, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5699, 5699, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5948, 5948, 416);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8011, 8011, 417);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8021, 8021, 417);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8031, 8031, 417);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8041, 8041, 417);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8042, 8042, 417);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8049, 8049, 417);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8050, 8050, 417);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8062, 8062, 417);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4119, 4119, 417);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8071, 8071, 417);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8099, 8099, 417);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4722, 4722, 418);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (3501, 3999, 418);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7011, 7011, 418);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7032, 7032, 418);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4112, 4112, 418);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4411, 4411, 418);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4468, 4468, 418);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (3351, 3500, 418);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7512, 7512, 418);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7519, 7519, 418);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4457, 4457, 418);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7033, 7033, 418);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5198, 5198, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7513, 7513, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (2842, 2842, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5013, 5013, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5511, 5511, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5521, 5521, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5531, 5531, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5532, 5532, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5533, 5533, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5551, 5551, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5561, 5561, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5571, 5571, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5592, 5592, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7523, 7523, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7531, 7531, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7534, 7534, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7535, 7535, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7538, 7538, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7542, 7542, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7549, 7549, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5598, 5598, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5599, 5599, 419);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (742, 742, 420);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5995, 5995, 420);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5946, 5946, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5998, 5998, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5921, 5921, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5993, 5993, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5931, 5931, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5932, 5932, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5937, 5937, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5947, 5947, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5950, 5950, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5970, 5970, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5972, 5972, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5973, 5973, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5992, 5992, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5945, 5945, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7993, 7993, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7699, 7699, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5046, 5046, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8043, 8043, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5311, 5311, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5193, 5193, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (1761, 1761, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (1771, 1771, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5169, 5169, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5172, 5172, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4784, 4784, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4789, 4789, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7012, 7012, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4011, 4011, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4111, 4111, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4121, 4121, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4131, 4131, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5309, 5309, 421);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5271, 5271, 422);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (9311, 9311, 422);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4829, 4829, 422);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (6012, 6012, 422);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (6051, 6051, 422);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (6513, 6513, 422);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4900, 4900, 422);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (6540, 6540, 422);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5968, 5968, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5935, 5935, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (8675, 8675, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (7278, 7278, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (2791, 2791, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (743, 743, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (744, 744, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (763, 763, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5962, 5962, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5964, 5964, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5966, 5966, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5967, 5967, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5310, 5310, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4214, 4214, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4215, 4215, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4225, 4225, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4814, 4814, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4815, 4815, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4821, 4821, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (9950, 9950, 423);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (6010, 6010, 424);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (6011, 6011, 424);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (9211, 9211, 425);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (9222, 9222, 425);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (9223, 9223, 425);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (9399, 9399, 425);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (9402, 9402, 425);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (6300, 6300, 426);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5960, 5960, 426);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4812, 4812, 427);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (4899, 4899, 427);
insert into cadoc_6334_segmento_mcc (mcc_init, mcc_end, segment) values (5965, 5965, 428);
