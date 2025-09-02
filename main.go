package main

import (
	"fmt"
	"math/rand"
    "time"
)

var (
	// period
	years = []int16{2025}
	quarters = []int16{1, 2, 3, 4}
	// codes
	maxInitialCode int32 = 12345678
	maxCodes int32 = 15
	minInitialCode int32 = 23456789
	minCodes int32 = 200
	// functions
	funcValues = []string{"D", "C"}
	funcProp = []float32{0.7, 0.3}
	// Brands
	brandValues = []int16{1, 2, 8}
	brandProp = []float32{0.5, 0.3, 0.2}
	// credit installments
	instValues = []int32{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
	instProp = []float32{0.22, 0.14, 0.13, 0.1, 0.08, 0.07, 0.05, 0.05, 0.04, 0.04, 0.04, 0,04} 
	// segments
	segValues =[]int32{401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 421, 422, 423, 424, 425, 426, 427, 428}
	// Valrange
	maxValRange = []float32{200_000_000.00, 600_000_000.00}
	minValRange = []float32{5_000, 20_000}
	// QttyRange
	avgTicket float32 = 150
	// FeeRange 
	maxFeeRange = []float32{0.012, 0.025}
	minFeeRange = []float32{0.025, 0.050}
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

// getRankingValue gets the ranking value for a given segment
func getRankingValue(segment string) float32 {
	// value
	rand.Seed(time.Now().UnixNano())
	val := float32(0.00)
	if segment == "max" {
		val = rand.Float32() * (maxValRange[1] - maxValRange[0]) + maxValRange[0]
	} else {
		val = rand.Float32() * (minValRange[1] - minValRange[0]) + minValRange[0]
	}
	return val
}


func main () {
	fmt.Printf("%.2f\n", getRankingValue("max"))
	fmt.Printf("%.2f\n", getRankingValue("min"))
}
