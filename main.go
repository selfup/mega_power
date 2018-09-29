package main

import (
	"fmt"
	"os"

	"github.com/selfup/mega_power/utils"
)

func main() {
	// Check Windows HOME -> USERPROFILE
	home := os.Getenv("USERPROFILE")

	if home == "" {
		// Otherwise get Linux/macOS (darwin) HOME
		home = os.Getenv("HOME")
	}

	MegaPATH := home + "/.mega_power.mega.data.csv"
	PowerPATH := home + "/.mega_power.power.data.csv"

	utils.CheckCliArgs(MegaPATH, PowerPATH)

	megaRecent := utils.Recent(MegaPATH)
	powerRecent := utils.Recent(PowerPATH)

	fmt.Println("MEGA")
	fmt.Println(megaRecent)
	fmt.Println("POWER")
	fmt.Println(powerRecent)
}
