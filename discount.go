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
	totValue := float32(0)
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
						totValue += val
						ret = append(ret, discount)
					}
				}
			}
		}
	}
	ret[0].Value += value - totValue
	return ret
}

func PrintDiscount() {
	value := float32(0)
	qty := int32(0)
	avgfee := float32(0)
	minfee := float32(0)
	maxfee := float32(0)
	stddev := float32(0)
	count := int32(0)
	for _, y := range years {
		for _, q := range quarters {
			disc := GetDiscount(y, q, discTotalValue, discAvgFee)
			for _, d := range disc {
				fmt.Println(d.GetInsert())
				value += d.Value
				qty += d.Qtty
				avgfee += d.AvgFee
				minfee += d.MinFee
				maxfee += d.MaxFee
				stddev += d.StdDevFee
				count++
			}
		}
	}
	fmt.Println("--------------------------------------")
	fmt.Printf("-- total value: %.2f, expected %.2f\n", value, discTotalValue)
	fmt.Printf("-- total quantity: %d\n", qty)
	fmt.Printf("-- avg fee: %.2f, expected %.2f\n", avgfee/float32(count), discAvgFee)
	fmt.Printf("-- min fee: %.2f\n", minfee/float32(count))
	fmt.Printf("-- max fee: %.2f\n", maxfee/float32(count))
	fmt.Printf("-- stddev fee: %.2f\n", stddev/float32(count))
	fmt.Printf("-- total records: %d\n", count)

}
