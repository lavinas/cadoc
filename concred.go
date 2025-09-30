package main

import (
	"fmt"

	"github.com/ianlopshire/go-fixedwidth"
)

var sqlConcred string = "insert into cadoc_6334_conccred(Ano, Trimestre, Bandeira, Funcao, QuantidadeEstabelecimentosCredenciados, QuantidadeEstabelecimentosAtivos, ValorTransacoes, QuantidadeTransacoes) values (%d, %d, %d, '%s', %d, %d, %.2f, %d);"

type Concred struct {
	Year                       int32   `fixed:"1,4"`
	Quarter                    int32   `fixed:"5,5"`
	Brand                      int32   `fixed:"6,7"`
	Function                   string  `fixed:"8,8"`
	CredentialedEstablishments int32   `fixed:"9,17"`
	ActiveEstablishments       int32   `fixed:"18,26"`
	TransactionValue           float32
	TransactionValueInt        int32   `fixed:"27,41"`
	TransactionQuantity        int32   `fixed:"42,53"`
}

// GetInsert generates the SQL insert statement for the Concred struct.
func (c *Concred) GetInsert() string {
	return fmt.Sprintf(sqlConcred, c.Year, c.Quarter, c.Brand, c.Function, c.CredentialedEstablishments, c.ActiveEstablishments, c.TransactionValue, c.TransactionQuantity)
}

// Parse parses a line of text into a Concred struct.
func (c *Concred) Parse(line string) (*Concred, error) {
	err := fixedwidth.Unmarshal([]byte(line), c)
	if err != nil {
		return nil, err
	}
	// Convert TransactionValueInt back to float32
	c.TransactionValue = float32(float64(c.TransactionValueInt) / float64(100))
	return c, nil
}

// GetConcred generates a list of Concred records based on the provided parameters.
func GetConcred(year int32, quarter int32, creden int32, actives int32, value float32) []*Concred {
	ret := []*Concred{}
	totCreden := int32(0)
	totActives := int32(0)
	for bi, bv := range brandValues {
		for fi, fv := range funcValues {
			valuePortion := value * brandProp[bi] * funcProp[fi]
			qty := int32(valuePortion / avgTicket)
			credentialedEstablishments := int32(float32(creden) * brandProp[bi] * funcProp[fi])
			activeEstablishments := int32(float32(actives) * brandProp[bi] * funcProp[fi])
			ret = append(ret, &Concred{
				Year:                       year,
				Quarter:                    quarter,
				Brand:                      bv,
				Function:                   fv,
				CredentialedEstablishments: credentialedEstablishments,
				ActiveEstablishments:       activeEstablishments,
				TransactionValue:           valuePortion,
				TransactionQuantity:        qty,
			})
			totCreden += credentialedEstablishments
			totActives += activeEstablishments
		}

	}
	ret[0].ActiveEstablishments += actives - totActives
	ret[0].CredentialedEstablishments += creden - totCreden
	return ret
}

// PrintConcred prints the Concred records.
func PrintConcred() {
	estabCount := int32(0)
	activeCount := int32(0)
	value := float32(0)
	qty := int32(0)
	count := int32(0)
	for _, y := range years {
		for _, q := range quarters {
			disc := GetConcred(y, q, concredTotalEstablishments, concredActiveEstablishments, concredTotalValue)
			for _, d := range disc {
				fmt.Println(d.GetInsert())
				estabCount += d.CredentialedEstablishments
				activeCount += d.ActiveEstablishments
				value += d.TransactionValue
				qty += d.TransactionQuantity
				count++
			}
		}
	}
	fmt.Println("--------------------------------------")
	fmt.Printf("-- Total Credentialed Establishments: %d, expected: %d\n", estabCount, concredTotalEstablishments)
	fmt.Printf("-- Total Active Establishments: %d, expected: %d\n", activeCount, concredActiveEstablishments)
	fmt.Printf("-- Total Transaction Value: %.2f, expected: %.2f\n", value, concredTotalValue)
	fmt.Printf("-- Total Transaction Quantity: %d\n", qty)
	fmt.Printf("-- Avg ticket: %.2f expected %.2f\n", value/float32(qty), avgTicket)
	fmt.Printf("-- Total Records: %d\n", count)

}
