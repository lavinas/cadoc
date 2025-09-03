package main

import (
	"fmt"
)

var (
	sqlDiscount string = "insert into cadoc_6334_desconto(Ano, Trimestre, Funcao, Bandeira, FormaCaptura, NumeroParcelas, CodigoSegmento, TaxaDescontoMedia, TaxaDescontoMinima, TaxaDescontoMaxima, DesvioPadraoTaxaDesconto, ValorTransacoes, QuantidadeTransacoes) values (%d, %d,'%s', %d, %d, %d, %d, %.2f, %.2f, %.2f, %.2f, %.2f, %d);"
)

type Discount struct {
	Year         int32
	Quarter      int32
	Function     string
	Brand        int32
	Capture      int32
	Installments int32
	Segment      int32
	AvgFee       float32
	MinFee       float32
	MaxFee       float32
	StdDevFee    float32
	Value        float32
	Qtty         int32
}

// GetInsert returns the SQL insert statement for the ranking
func (r Discount) GetInsert() string {
	return fmt.Sprintf(sqlDiscount, r.Year, r.Quarter, r.Function, r.Brand, r.Capture, r.Installments, r.Segment, r.AvgFee, r.MinFee, r.MaxFee, r.StdDevFee, r.Value, r.Qtty)
}

// GetDiscount returns the discount for a given year, quarter, value, and fee
func GetDiscount(year int32, quarter int32, value float32, fee float32) []*Discount {
	ret := []*Discount{}
	for si, sv := range segValues {
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
						val := value * funcProp[fi] * brandProp[bi] * captProp[ci] * probValues[ii] * segProp[si]
						qty := int32(val / avgTicket)
						fee := fee + varFee[ii]
						minFee := fee + subFee
						maxFee := fee + sumFee
						stdDevFee := fee * stdDevProp
						discount := &Discount{
							Year:         year,
							Quarter:      quarter,
							Function:     fv,
							Brand:        bv,
							Capture:      cv,
							Installments: iv,
							Segment:      sv,
							AvgFee:       fee,
							MinFee:       minFee,
							MaxFee:       maxFee,
							StdDevFee:    stdDevFee,
							Value:        val,
							Qtty:         qty,
						}
						ret = append(ret, discount)
					}
				}
			}
		}
	}
	return ret
}

func PrintDiscount() {
	for _, y := range years {
		for _, q := range quarters {
			disc := GetDiscount(y, q, discTotalValue, discAvgFee)
			for _, d := range disc {
				fmt.Println(d.GetInsert())
			}
		}
	}
}
