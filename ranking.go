package main

var (
	// functions
	funcValues = []string{"D", "C"}
	funcProp   = []float32{0.7, 0.3}
	// Brands
	brandValues = []int32{1, 2, 8}
	brandProp   = []float32{0.5, 0.3, 0.2}
	// credit installments
	instValues = []int32{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
	instProp   = []float32{0.22, 0.14, 0.13, 0.1, 0.08, 0.07, 0.05, 0.05, 0.04, 0.04, 0.04, 0, 04}
	// QttyRange
	avgTicket float32 = 150
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
func (r Ranking) GetRanking(year int32, quarter int32, clientCode string, clientType string, clientSegment int32, amount float32, fee float32) []*Ranking {
	ret := []*Ranking{}
	for fi, fv := range funcValues {
		for bi, bv := range brandValues {
			for ii, iv := range instValues {
				if fv == "D" && iv > 1 {
					continue
				}
				// Calculate the value and quantity based on the amount and various proportions
				val := amount * funcProp[fi] * brandProp[bi] * instProp[ii]
				qty := int32(val / avgTicket)
				// create and append ranking
				ranking := &Ranking{
					Year:         year,
					Quarter:      quarter,
					ClientCode:   clientCode,
					Function:     fv,
					Brand:        bv,
					Capture:      0,
					Installments: iv,
					Segment:      clientSegment,
					Value:        val,
					Qtty:         qty,
					Discount:     fee,
				}
				ret = append(ret, ranking)
			}
		}
	}
	return ret
}
