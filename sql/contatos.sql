CREATE TABLE cadoc_6334_contatos (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    -- controle
    SyncStatus INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    -- dados
    Ano NUMERIC(4, 0) NOT NULL,
    Trimestre NUMERIC(1, 0) NOT NULL,
    TipoContato NVARCHAR(1) NOT NULL,
    Nome NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    Telefone NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL
)
CREATE INDEX idx_cadoc_6334_contatos_period ON cadoc_6334_contatos(Ano, Trimestre, Nome);
CREATE INDEX idx_cadoc_6334_contatos_SyncStatus ON cadoc_6334_contatos(SyncStatus);
CREATE INDEX idx_cadoc_6334_contatos_CreatedAt ON cadoc_6334_contatos(CreatedAt);
CREATE INDEX idx_cadoc_6334_contatos_UpdatedAt ON cadoc_6334_contatos(UpdatedAt);