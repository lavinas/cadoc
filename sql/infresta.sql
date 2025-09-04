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

-- insercao infresta piloto
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'SP', 1556976, 778488, 467093, 311395);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'MG', 727659, 361299, 221841, 144519);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'RJ', 581973, 290986, 174593, 116394);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'BA', 502645, 251322, 150794, 100529);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'PR', 401684, 200842, 120506, 80336);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'RS', 379328, 189664, 113799, 75865);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'PE', 323078, 161539, 96924, 64615);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'CE', 312981, 156490, 93895, 62596);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'PA', 294231, 147115, 88270, 58846);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'SC', 276924, 138462, 83078, 55384);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'GO', 250962, 125481, 75289, 50192);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'MA', 237260, 118630, 71178, 47452);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'AM', 145673, 72836, 43703, 29134);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'PB', 140625, 70312, 42188, 28125);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'ES', 139183, 69591, 41756, 27836);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'MT', 131250, 65625, 39375, 26250);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'RN', 116827, 58413, 35049, 23365);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'PI', 113942, 56971, 34183, 22788);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'AL', 108894, 54447, 32669, 21778);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'DF', 100961, 50480, 30289, 20192);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'MS', 98798, 49399, 29640, 19759);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'SE', 77884, 38942, 23366, 15576);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'RO', 59134, 29567, 17741, 11826);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'TO', 53365, 26682, 16010, 10673);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'AC', 29567, 14783, 8871, 5913);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'AP', 28125, 14062, 8438, 5625);
insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (2025, 3, 'RR', 21634, 10817, 6491, 4326);