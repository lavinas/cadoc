package main

import (
	"fmt"
)

var (
	infestaSQL = "insert into cadoc_6334_infresta(Ano, Trimestre, Uf, QuantidadeEstabelecimentosTotais, QuantidadeEstabelecimentosCapturaManual, QuantidadeEstabelecimentosCapturaEletronica, QuantidadeEstabelecimentosCapturaRemota) values (%d, %d, '%s', %d, %d, %d, %d);"
)

// Infresta represents the infresta data model
type Infresta struct {
	Year              int32
	Quarter           int32
	UF                string
	TotalCli          int32
	TotalCliManual    int32
	TotalCliEletronic int32
	TotalCliRemote    int32
}

// GetInsert returns the SQL insert statement for the ranking
func (r Infresta) GetInsert() string {
	return fmt.Sprintf(infestaSQL, r.Year, r.Quarter, r.UF, r.TotalCli, r.TotalCliManual, r.TotalCliEletronic, r.TotalCliRemote)
}

// GetInfresta returns the infresta data for a given year and quarter
func GetInfresta(year int32, quarter int32, totalCli int32) []*Infresta {
	ret := []*Infresta{}
	


	return ret
}