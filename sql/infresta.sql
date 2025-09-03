-- Tabela de infrest Cadoc 6334 e indices
CREATE TABLE cadoc_6334_infresta (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    -- controle
    SyncStatus INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    Uf NVARCHAR(2) NOT NULL,
    QuantidadeEstabelecimentosTotais NUMERIC(8, 0) NOT NULL,
    QuantidadeEstabelecimentosCapturaManual NUMERIC(8, 0) NOT NULL,
    QuantidadeEstabelecimentosCapturaEletronica NUMERIC(8, 0) NOT NULL,
    QuantidadeEstabelecimentosCapturaRemota NUMERIC(8, 0) NOT NULL,
);
CREATE INDEX idx_cadoc_6334_infresta_period ON cadoc_6334_infresta(Ano, Trimestre, Uf);
CREATE INDEX idx_cadoc_6334_infresta_SyncStatus ON cadoc_6334_infresta(SyncStatus);
CREATE INDEX idx_cadoc_6334_infresta_CreatedAt ON cadoc_6334_infresta(CreatedAt);
CREATE INDEX idx_cadoc_6334_infresta_UpdatedAt ON cadoc_6334_infresta(UpdatedAt);
