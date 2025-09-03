-- Tabela de intercam Cadoc 6334 e indices
CREATE TABLE cadoc_6334_intercam (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    -- controle
    SyncStatus INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    Produto NUMERIC(2, 0) NOT NULL,
    ModalidadeCartao NVARCHAR(1) NOT NULL,
    Funcao NVARCHAR(1) NOT NULL,
    Bandeira NUMERIC(2, 0) NOT NULL,
    FormaCaptura NUMERIC (1, 0) NOT NULL,
    NumeroParcelas NUMERIC(2, 0) NOT NULL,
    CodigoSegmento NUMERIC(3, 0) NOT NULL,
    TarifaIntercambio NUMERIC(4, 2) NOT NULL,
    ValorTransacoes NUMERIC(15, 2) NOT NULL,
    QuantidadeTransacoes NUMERIC(12, 0) NOT NULL
);
CREATE INDEX idx_cadoc_6334_intercam_period ON cadoc_6334_intercam(Ano, Trimestre, Produto, ModalidadeCartao, Funcao, Bandeira, FormaCaptura, NumeroParcelas, CodigoSegmento);
CREATE INDEX idx_cadoc_6334_intercam_SyncStatus ON cadoc_6334_intercam(SyncStatus);
CREATE INDEX idx_cadoc_6334_intercam_CreatedAt ON cadoc_6334_intercam(CreatedAt);
CREATE INDEX idx_cadoc_6334_intercam_UpdatedAt ON cadoc_6334_intercam(UpdatedAt);

