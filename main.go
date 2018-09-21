package main

import (
	"fmt"

	"github.com/mega_power/utils"
)

// paths for megamillions and powerball stuff
const (
	MegaPATH  = "mega/data.csv"
	PowerPATH = "power/data.csv"
)

func main() {
	utils.FetchAndWriteOrPass(MegaPATH, PowerPATH)

	megaRecent := utils.LastEight(MegaPATH)
	powerRecent := utils.LastEight(PowerPATH)

	fmt.Println("MEGA")
	fmt.Println(megaRecent)
	fmt.Println("POWER")
	fmt.Println(powerRecent)
}
