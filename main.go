package main

import (
	"fmt"
	"os"

	"github.com/mega_power/utils"
)

func main() {
	home := os.Getenv("USERPROFILE")

	if home == "" {
		home = os.Getenv("HOME")
	}

	MegaPATH := home + "/.mega_power.mega.data.csv"
	PowerPATH := home + "/.mega_power.power.data.csv"

	utils.FetchAndWriteOrPass(MegaPATH, PowerPATH)

	megaRecent := utils.LastEight(MegaPATH)
	powerRecent := utils.LastEight(PowerPATH)

	fmt.Println("MEGA")
	fmt.Println(megaRecent)
	fmt.Println("POWER")
	fmt.Println(powerRecent)
}
