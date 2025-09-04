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
	countCli := int32(0)
	for ui, uv := range ufValues {
		cli := int32(float32(totalCli) * ufProp[ui])
		inf := &Infresta{
			Year:              year,
			Quarter:           quarter,
			UF:                uv,
			TotalCli:          cli,
			TotalCliManual:    int32(float32(cli) * infrestaProp[0]),
			TotalCliEletronic: int32(float32(cli) * infrestaProp[1]),
			TotalCliRemote:    int32(float32(cli) * infrestaProp[2]),
		}
		inf.TotalCliEletronic = cli - inf.TotalCliManual - inf.TotalCliRemote
		ret = append(ret, inf)
		countCli += cli
	}
	ret[1].TotalCli += totalCli - countCli
	ret[1].TotalCliEletronic = ret[1].TotalCli - ret[1].TotalCliManual - ret[1].TotalCliRemote
	return ret
}

// PrintInfresta prints the infresta data for a given year and quarter
func PrintInfresta() {
	totalCli := int32(0)
	totalCli2 := int32(0)
	for _, y := range years {
		for _, q := range quarters {
			inf := GetInfresta(y, q, infrestaTotalEstablishments)
			for _, i := range inf {
				fmt.Println(i.GetInsert())
				totalCli += i.TotalCli
				totalCli2 += i.TotalCliManual + i.TotalCliEletronic + i.TotalCliRemote
			}
		}
	}
	fmt.Println("----------------------------------------------------")
	fmt.Printf("Total Clients: %d - Total Clients2: %d, expected %d\n", totalCli, totalCli2, infrestaTotalEstablishments)
}
