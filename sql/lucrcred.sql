-- Tabela de lucrcred Cadoc 6334 e indices
CREATE TABLE cadoc_6334_lucrcred (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    -- controle
    SyncStatus INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
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
CREATE INDEX idx_cadoc_6334_lucrcred_period ON cadoc_6334_lucrcred(Ano, Trimestre);
CREATE INDEX idx_cadoc_6334_lucrcred_SyncStatus ON cadoc_6334_lucrcred(SyncStatus);
CREATE INDEX idx_cadoc_6334_lucrcred_CreatedAt ON cadoc_6334_lucrcred(CreatedAt);
CREATE INDEX idx_cadoc_6334_lucrcred_UpdatedAt ON cadoc_6334_lucrcred(UpdatedAt);

insert into cadoc_6334_lucrcred (Ano, Trimestre, ReceitaTaxaDescontoBruta, ReceitaAluguelEquipamentosConectividade, ReceitaOutras, CustoTarifaIntercambio, CustoMarketingPropaganda, CustoTaxasAcessoBandeiras, CustoRisco, CustoProcessamento, CustoOutros)
values (2025, 3, 24007506.15, 2700657.12, 650876.00, 12003753.07, 2768657.10, 1676980.10, 650897.12, 1234500.19, 430212.13);
