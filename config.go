package main

// distributions
var (
	// period
	years    = []int32{2025}
	quarters = []int32{3}
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
	// segments
	segValues = []int32{401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 421, 422, 423, 424, 425, 426, 427, 428}
	segProp   = []float32{0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.04, 0.04}

	// QttyRange
	avgTicket float32 = 150
)

// ranking
var (
	// max
	maxClients int32   = 15
	maxCode    int32   = 12345678
	maxCodeLeg int32   = 200
	maxVal     float32 = 10_500_000.00
	maxValLeg  float32 = 865_000.00
	maxFees            = []float32{0.5, 0.8, 0.7, 1.0, 1.2, 1.5}
	// min
	minClients int32   = 200
	minCode    int32   = 23456789
	minCodeLeg int32   = 200
	minVal     float32 = 80_000.00
	minValLeg  float32 = 1_680.00
	minFee             = []float32{1.5, 1.8, 1.9, 2.5, 1.4}
)

// discount
var (
	// fee range
	subFee     float32 = -1.75
	sumFee     float32 = 2.25
	stdDevProp float32 = 0.1
	// total
	discTotalValue float32 = 750_000_000.00
	discAvgFee     float32 = 2.3
)
