-- Tabela de conccred Cadoc 6334 e indices
CREATE TABLE cadoc_6334_conccred (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    -- controle
    SyncStatus INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
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
CREATE INDEX idx_cadoc_6334_conccred_period ON cadoc_6334_conccred(Ano, Trimestre, Bandeira, Funcao);
CREATE INDEX idx_cadoc_6334_conccred_SyncStatus ON cadoc_6334_conccred(SyncStatus);
CREATE INDEX idx_cadoc_6334_conccred_CreatedAt ON cadoc_6334_conccred(CreatedAt);
CREATE INDEX idx_cadoc_6334_conccred_UpdatedAt ON cadoc_6334_conccred(UpdatedAt);
