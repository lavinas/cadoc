CREATE TABLE cadoc_6334_infrterm (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    -- controle
    SyncStatus INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    Uf NVARCHAR(2) NOT NULL,
    QuantidadePOSCompartilhados NUMERIC(8, 0) NOT NULL,
    QuantidadePOSLeitoraChip NUMERIC(8, 0) NOT NULL,
    QuantidadePDV NUMERIC(8, 0) NOT NULL,
);

CREATE INDEX idx_cadoc_6334_infrterm_period ON cadoc_6334_infrterm(Ano, Trimestre, Uf);
CREATE INDEX idx_cadoc_6334_infrterm_SyncStatus ON cadoc_6334_infrterm(SyncStatus);
CREATE INDEX idx_cadoc_6334_infrterm_CreatedAt ON cadoc_6334_infrterm(CreatedAt);
CREATE INDEX idx_cadoc_6334_infrterm_UpdatedAt ON cadoc_6334_infrterm(UpdatedAt);
