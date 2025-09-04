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

-- insercao concred piloto
insert into cadoc_6334_conccred(Ano, Trimestre, Bandeira, Funcao, QuantidadeEstabelecimentosCredenciados, QuantidadeEstabelecimentosAtivos, ValorTransacoes, QuantidadeTransacoes) values (2025, 3, 1, 'D', 2524050, 1750551, 262582096.00, 1750547);
insert into cadoc_6334_conccred(Ano, Trimestre, Bandeira, Funcao, QuantidadeEstabelecimentosCredenciados, QuantidadeEstabelecimentosAtivos, ValorTransacoes, QuantidadeTransacoes) values (2025, 3, 1, 'C', 1081734, 750234, 112535192.00, 750234);
insert into cadoc_6334_conccred(Ano, Trimestre, Bandeira, Funcao, QuantidadeEstabelecimentosCredenciados, QuantidadeEstabelecimentosAtivos, ValorTransacoes, QuantidadeTransacoes) values (2025, 3, 2, 'D', 1514428, 1050328, 157549264.00, 1050328);
insert into cadoc_6334_conccred(Ano, Trimestre, Bandeira, Funcao, QuantidadeEstabelecimentosCredenciados, QuantidadeEstabelecimentosAtivos, ValorTransacoes, QuantidadeTransacoes) values (2025, 3, 2, 'C', 649040, 450140, 67521120.00, 450140);
insert into cadoc_6334_conccred(Ano, Trimestre, Bandeira, Funcao, QuantidadeEstabelecimentosCredenciados, QuantidadeEstabelecimentosAtivos, ValorTransacoes, QuantidadeTransacoes) values (2025, 3, 8, 'D', 1009618, 700218, 105032840.00, 700218);
insert into cadoc_6334_conccred(Ano, Trimestre, Bandeira, Funcao, QuantidadeEstabelecimentosCredenciados, QuantidadeEstabelecimentosAtivos, ValorTransacoes, QuantidadeTransacoes) values (2025, 3, 8, 'C', 432693, 300093, 45014076.00, 300093);
