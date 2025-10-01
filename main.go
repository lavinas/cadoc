package main

import (
	"fmt"
)


// main function to run the ReconcileIntercam function
func main() {
	fmt.Println("---------------------------------------------------------------------------------------------------------")
	ReconciliateRanking("files/RANKING.TXT")
	fmt.Println("---------------------------------------------------------------------------------------------------------")
	ReconciliateConcred("files/CONCCRED.TXT")
	fmt.Println("---------------------------------------------------------------------------------------------------------")
	ReconciliateInfresta("files/INFRESTA.TXT")
	fmt.Println("---------------------------------------------------------------------------------------------------------")
	ReconciliateInfrterm("files/INFRTERM.TXT")
	fmt.Println("---------------------------------------------------------------------------------------------------------")
	ReconciliateDiscount("files/DESCONTO.TXT")
	fmt.Println("---------------------------------------------------------------------------------------------------------")
	ReconcileateIntercam("files/INTERCAM.TXT")
	fmt.Println("---------------------------------------------------------------------------------------------------------")
}
