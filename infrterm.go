package main

import (
	"fmt"
)

var (
	sqlInfrterm string = "insert into cadoc_6334_infrterm(Ano, Trimestre, Uf, QuantidadePOSCompartilhados, QuantidadePOSLeitoraChip, QuantidadePDV) values (%d, %d, '%s', %d, %d, %d);"
)

type Infrterm struct {
	Year               int32
	Quarter            int32
	UF                 string
	SharedPOSCount     int32
	ChipReaderPOSCount int32
	PDVCount           int32
}

// GetInsert returns the SQL insert statement for the infrterm
func (r Infrterm) GetInsert() string {
	return fmt.Sprintf(sqlInfrterm, r.Year, r.Quarter, r.UF, r.SharedPOSCount, r.ChipReaderPOSCount, r.PDVCount)
}

// GetInfrterm returns the infrterm for a given year, quarter, state, and counts
func GetInfrterm(year int32, quarter int32, terms int32) []*Infrterm {
	totTerms := int32(0)
	ret := []*Infrterm{}
	for ui, uv := range ufValues {
		term := int32(float32(terms) * ufProp[ui])
		inf := &Infrterm{
			Year:               year,
			Quarter:            quarter,
			UF:                 uv,
			SharedPOSCount:     int32(float32(term) * infretermProp[0]),
			ChipReaderPOSCount: int32(float32(term) * infretermProp[1]),
			PDVCount:           int32(float32(term) * infretermProp[2]),
		}
		totTerms += term
		inf.ChipReaderPOSCount = term - inf.SharedPOSCount - inf.PDVCount
		ret = append(ret, inf)
	}
	dif := terms - totTerms
	ret[0].SharedPOSCount += dif
	return ret
}

// PrintInfrterm prints the infrterm details
func PrintInfrterm() {
	totTerms := int32(0)
	for _, y := range years {
		for _, q := range quarters {
			infrterms := GetInfrterm(y, q, infretermTerminals)
			for _, i := range infrterms {
				totTerms += i.SharedPOSCount + i.ChipReaderPOSCount + i.PDVCount
				fmt.Println(i.GetInsert())
			}
		}
	}
	fmt.Println("---------------------------------------")
	fmt.Printf("-- total terminals: %d, expected %d\n", totTerms, infretermTerminals)
}
