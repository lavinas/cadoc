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

-- insercao infterm piloto
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'SP', 479004, 789787, 315914);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'MG', 219925, 366543, 146617);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'RJ', 177125, 295211, 118083);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'BA', 152982, 254970, 101988);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'PR', 122253, 203758, 81502);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'RS', 115449, 192418, 76966);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'PE', 98329, 163884, 65553);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'CE', 95257, 158763, 63504);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'PA', 89550, 149251, 59700);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'SC', 84282, 140472, 56188);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'GO', 76381, 127303, 50920);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'MA', 72210, 120353, 48140);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'AM', 44336, 73894, 29557);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'PB', 42799, 71334, 28533);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'ES', 42360, 70603, 28240);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'MT', 39946, 66578, 26631);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'RN', 35556, 59262, 23704);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'PI', 34678, 57799, 23119);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'AL', 33142, 55238, 22094);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'DF', 30728, 51214, 20485);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'MS', 30069, 50117, 20046);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'SE', 23704, 39508, 15803);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'RO', 17997, 29998, 11998);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'TO', 16242, 27070, 10828);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'AC', 8998, 14999, 5999);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'AP', 8559, 14268, 5706);
insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (2025, 3, 'RR', 6584, 10975, 4389);