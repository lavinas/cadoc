package main

import (
	"fmt"
)

var sqlConcred string = "insert into cadoc_6334_concred(Ano, Trimestre, Bandeira, Funcao, QuantidadeEstabelecimentosCredenciados, QuantidadeEstabelecimentosAtivos, ValorTransacoes, QuantidadeTransacoes) values (%d, %d, %d, '%s', %d, %d, %.2f, %d);"

type Concred struct {
	Year                         int32
	Quarter                      int32
	Brand                        int32
	Function                     string
	CredentialedEstablishments   int32
	ActiveEstablishments         int32
	TransactionValue             float32
	TransactionQuantity          int32
}

func (c *Concred) GetInsert() string {
	return fmt.Sprintf(sqlConcred, c.Year, c.Quarter, c.Brand, c.Function, c.ActiveEstablishments, c.TransactionValue, c.TransactionQuantity)
}


