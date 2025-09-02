package main

import (
	"fmt"
)

var (
	// period
	years    = []int16{2025}
	quarters = []int16{1, 2, 3, 4}
	// codes
	maxInitialCode int32 = 12345678
	maxCodes       int32 = 15
	minInitialCode int32 = 23456789
	minCodes       int32 = 200
	// segments
	segValues = []int32{401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 421, 422, 423, 424, 425, 426, 427, 428}
	// Valrange
	maxValRange = []float32{200_000_000.00, 600_000_000.00}
	minValRange = []float32{5_000, 20_000}
	// FeeRange
	maxFeeRange = []float32{0.012, 0.025}
	minFeeRange = []float32{0.025, 0.050}
)

func main() {
	fmt.Println("Ranking module")
}
