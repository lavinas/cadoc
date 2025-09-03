package main

import (
	"fmt"
)

var (
	// insert text
	sqlRanking string = "insert into cadoc_6334_ranking(Ano, Trimestre, CodigoEstabelecimento, Funcao, Bandeira, FormaCaptura, NumeroParcelas, CodigoSegmento, ValorTransacao, QuantidadeTransacoes, TaxaDescontoMedia) values (%d, %d, '%s', '%s', %d, %d, %d, %d, %.2f, %d, %.2f);"
)

type Ranking struct {
	Year         int32
	Quarter      int32
	ClientCode   string
	Function     string
	Brand        int32
	Capture      int32
	Installments int32
	Segment      int32
	Value        float32
	Qtty         int32
	Discount     float32
}

// GetInsert returns the SQL insert statement for the ranking
func (r Ranking) GetInsert() string {
	return fmt.Sprintf(sqlRanking, r.Year, r.Quarter, r.ClientCode, r.Function, r.Brand, r.Capture, r.Installments, r.Segment, r.Value, r.Qtty, r.Discount)
}

// ClientRanking returns the ranking of the client
func GetRanking(year int32, quarter int32, clientCode string, clientSegment int32, amount float32, fee float32) []*Ranking {
	ret := []*Ranking{}
	for fi, fv := range funcValues {
		for bi, bv := range brandValues {
			for ci, cv := range captValues {
				var insValues []int32
				var probValues []float32
				var varFee []float32
				if fv == "D" {
					insValues = instDebValues
					probValues = instDebProp
					varFee = instDebFee
				} else {
					insValues = instCredValues
					probValues = instCredProp
					varFee = instCredFee
				}
				for ii, iv := range insValues {
					// Calculate the value and quantity based on the amount and various proportions
					val := amount * funcProp[fi] * brandProp[bi] * probValues[ii] * captProp[ci]
					qty := int32(val / avgTicket)
					// create and append ranking
					ranking := &Ranking{
						Year:         year,
						Quarter:      quarter,
						ClientCode:   clientCode,
						Function:     fv,
						Brand:        bv,
						Capture:      cv,
						Installments: iv,
						Segment:      clientSegment,
						Value:        val,
						Qtty:         qty,
						Discount:     fee + varFee[ii],
					}
					ret = append(ret, ranking)
				}
			}
		}
	}
	return ret
}

// ranking generate
func PrintRanking() {
	for _, y := range years {
		for _, q := range quarters {
			for i := int32(1); i <= maxClients; i++ {
				id := maxCode + i*maxCodeLeg
				val := maxVal + float32(i)*maxValLeg
				rank := GetRanking(y, q, fmt.Sprintf("%08d", id), segValues[i%int32(len(segValues))], val, maxFees[i%int32(len(maxFees))])
				for _, r := range rank {
					fmt.Println(r.GetInsert())
				}
			}
			for i := int32(1); i <= minClients; i++ {
				id := minCode + i*minCodeLeg
				val := minVal + float32(i)*minValLeg
				rank := GetRanking(y, q, fmt.Sprintf("%08d", id), segValues[i%int32(len(segValues))], val, minFee[i%int32(len(minFee))])
				for _, r := range rank {
					fmt.Println(r.GetInsert())
				}
			}
		}
	}
}
