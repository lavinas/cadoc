-- Tabela de segmento Cadoc 6334 e indices
CREATE TABLE cadoc_6334_segmento (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    -- controle
    SyncStatus INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    -- dados
    NomeSegmento NVARCHAR(50) NOT NULL,
    DescricaoSegmento NVARCHAR(255) NOT NULL,
    CodigoSegmento NUMERIC(3, 0) NOT NULL
);
CREATE INDEX uq_cadoc_6334_segmento ON cadoc_6334_segmento(CodigoSegmento);
CREATE INDEX idx_cadoc_6334_segmento_SyncStatus ON cadoc_6334_segmento(SyncStatus);
CREATE INDEX idx_cadoc_6334_segmento_CreatedAt ON cadoc_6334_segmento(CreatedAt);
CREATE INDEX idx_cadoc_6334_segmento_UpdatedAt ON cadoc_6334_segmento(UpdatedAt);

-- insercao segmento piloto
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Cuidados pessoais', 'Loja de cosméticos;Navalha elétrica - venda e serviços', 401);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Bares e Restaurantes', 'Bares, pubs e casas noturnas;Bares de sinuca', 402);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Companhias aéreas e afins', 'Aeroportos e serviços ligados a aeronaves', 403);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Cultura e Esportes', 'Cinemas, produções cinematográficas;Academias / clubes', 404);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Educação', 'Universidades e faculdades;Escola de negócios/vocações;Colégios', 405);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Eletrônicos e eletrodomésticos', 'Computadores, equipamentos e softwares;Produtos digitais - aplicativos de software (exceto jogos);Lojas de eletrodomésticos', 406);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Farmácias e Cuidados com a saúde', 'Aparelhos auditivos - vendas e serviços;Farmácias', 407);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Grandes Atacadistas', 'Atacados de bebidas alcoólicas', 408);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Outros Serviços e Profissionais Liberais', 'Corretores de imóveis;Serviço funerário;Consultoria empresarial e serviços de relações públicas;Outros serviços profissionais de especializados', 409);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Jogos e Loteria', 'Corrida de cavalos licenciado;Cassinos, loterias e jogos de azar', 410);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Livrarias e afins', 'Banca de jornal e provedor de notícias;Artigos de papelaria e suprimentos para escritório', 411);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Alimentação', 'Loja de doces', 412);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Móveis e construção', 'Demais serviços de reforma e construção;Piscinas e banheiras - serviços, suprimentos e vendas', 413);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Pequenos supermercados e afins', 'Lojas especializadas não listadas anteriormente;Lojas de variedades', 414);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Combustíveis e afins', 'Postos de gasolina;Revendedores de combustíveis', 415);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Roupas, sapatos, acessórios e afins', 'Conserto de relógios e joias;Aluguel de roupas - fantasias, uniformes e roupas sociais', 416);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Comércio e serviços em geral', 'Opticians, optical goods, and eyeglasses;Loja de moedas e selos', 421);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Serviços Financeiros', 'Instituição financeira - agências e serviços;Corretores de residências móveis', 422);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Outros', 'Armazenamento agrícola, refrigeração, bens domésticos;Telegrafo', 423);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Instituições Financeiras 6010 Bancos / lojas de poupança e inst. Financeira', 'Bancos / lojas de poupança e inst. Financeira;Instituição financeira - caixa eletrônico', 424);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Serviços Públicos', 'Multas (fines);Serviços governamentais', 425);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Seguros', 'Marketing direto de seguros', 426);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Utilities (inclui telecom)', 'Telefones e equipamentos de telecom.;Catálogo de varejo', 427);
insert into cados_6334_segmento (NomeSegmento, DescricaoSegmento, CodigoSegmento) values ('Subadquirentes', 'Catálogo de varejo', 428);
