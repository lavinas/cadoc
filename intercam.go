package main

import (
	"fmt"
)

var (
	intercamSQL = "INSERT INTO intercam (Ano, Trimestre, Produto, ModalidadeCartao, Funcao, Bandeira, FormaCaptura, NumeroParcelas, CodigoSegmento, TarifaIntercambio, ValorTransacoes, QuantidadeTransacoes) VALUES (%d, %d, %d, '%s', '%s', %d, %d, %d, %d, %.2f, %.2f, %d);"
)

type Intercam struct {
	Year         int32
	Quarter      int32
	Product      int32
	CardType     string
	Function     string
	Brand        int32
	Capture      int32
	Installments int32
	Segment      int32
	Fee          float32
	Value        float32
	Qtty         int32
}

// GetInsert returns the SQL insert statement for the Intercam struct
func (i *Intercam) GetInsert() string {
	return fmt.Sprintf(intercamSQL, i.Year, i.Quarter, i.Product, i.CardType, i.Function, i.Brand, i.Capture, i.Installments, i.Segment, i.Fee, i.Value, i.Qtty)
}

// GetIntercam returns the Intercam struct from the SQL insert statement
func GetIntercam(year int32, quarter int32, value float32, fee float32) []*Intercam {
	ret := []*Intercam{}
	totValue := float32(0)
	for si, sv := range segValues {
		for pi, pv := range prodValues {
			for ti, tv := range cardtypeValues {
				for fi, fv := range funcValues {
					for bi, bv := range brandValues {
						var insValues []int32
						var probValues []float32
						var varFee []float32
						for ci, cv := range captValues {
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
								val := value * funcProp[fi] * brandProp[bi] * captProp[ci] * probValues[ii] * segProp[si] * prodProp[pi] * cardtypeProp[ti]
								qty := int32(val / avgTicket)
								if qty == 0 {
									qty = 1
								}
								fee := fee + varFee[ii]
								inter := &Intercam{
									Year:         year,
									Quarter:      quarter,
									Product:      pv,
									CardType:     tv,
									Function:     fv,
									Brand:        bv,
									Capture:      cv,
									Installments: iv,
									Segment:      sv,
									Fee:          fee,
									Value:        val,
									Qtty:         qty,
								}
								ret = append(ret, inter)
								totValue += val

							}
						}
					}
				}
			}
		}
	}
	ret[0].Value += value - totValue
	return ret
}

// PrintIntercam
func PrintIntercam() {
	tot := float32(0)
	for _, y := range years {
		for _, q := range quarters {
			intercam := GetIntercam(y, q, intercamTotalValue, intercamAvgFee)
			for _, i := range intercam {
				fmt.Println(i.GetInsert())
				tot += i.Value
			}
		}
	}
	fmt.Println("---------------------------------------")
	fmt.Printf("Value: %.2f, expected: %.2f\n", tot, intercamTotalValue)
}
