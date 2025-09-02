package main

import (
	"fmt"
)

var (
	// functions
	funcValues = []string{"D", "C"}
	funcProp   = []float32{0.7, 0.3}
	// Brands
	brandValues = []int32{1, 2, 8}
	brandProp   = []float32{0.5, 0.3, 0.2}
	// capture
	captValues = []int32{2, 5}
	captProp   = []float32{0.7, 0.3}
	// credit installments
	instCredValues = []int32{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
	instCredProp   = []float32{0.22, 0.14, 0.13, 0.1, 0.08, 0.07, 0.05, 0.05, 0.04, 0.04, 0.04, 0.04}
	instCredFee    = []float32{0.00, 1.10, 1.10, 1.10, 1.10, 1.10, 2.15, 2.15, 2.15, 2.15, 2.15, 2.15}
	// debit installments
	instDebValues = []int32{1}
	instDebProp   = []float32{1}
	instDebFee    = []float32{-0.5}
	// QttyRange
	avgTicket float32 = 150
	// insert text
	sql string = "insert into cadoc_6334_ranking(Ano, Trimestre, CodigoEstabelecimento, Funcao, Bandeira, FormaCaptura, NumeroParcelas, CodigoSegmento, ValorTransacao, QuantidadeTransacoes, TaxaDescontoMedia) values (%d, %d, '%s', '%s', %d, %d, %d, %d, %.2f, %d, %.2f);"
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

// ClientRanking returns the ranking of the client
func GetClientRanking(year int32, quarter int32, clientCode string, clientSegment int32, amount float32, fee float32) []*Ranking {
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

// GetInsert returns the SQL insert statement for the ranking
func (r Ranking) GetInsert() string {
	return fmt.Sprintf(sql, r.Year, r.Quarter, r.ClientCode, r.Function, r.Brand, r.Capture, r.Installments, r.Segment, r.Value, r.Qtty, r.Discount)
}
