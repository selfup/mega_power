package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"strings"
)

// paths and urls for megamillions and powerball stuff
const (
	MegaPATH  = "mega/data.csv"
	PowerPATH = "power/data.csv"

	MegaURL  = "https://data.ny.gov/api/views/5xaw-6ayf/rows.csv?accessType=DOWNLOAD"
	PowerURL = "https://data.ny.gov/api/views/d6yy-54nr/rows.csv?accessType=DOWNLOAD"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func checkCSV(path string) bool {
	if _, err := os.Stat(path); os.IsNotExist(err) {
		return false
	}

	return true
}

func getCSV(lottery string) string {
	fmt.Println("Fetching Data from NYC Gov API")

	resp, err := http.Get(lottery)
	check(err)

	defer resp.Body.Close()

	if resp.StatusCode == http.StatusOK {
		bodyBytes, err := ioutil.ReadAll(resp.Body)
		check(err)

		return string(bodyBytes)
	}

	return ""
}

func readCSV(path string) string {
	file, err := ioutil.ReadFile(path)
	check(err)

	return string(file)
}

func writeCSV(path string, content string) bool {
	contentBytes := []byte(content)

	err := ioutil.WriteFile(path, contentBytes, 0644)
	check(err)

	return true
}

func main() {
	var megaCSVResponse string
	var powerCSVResponse string

	if !checkCSV(MegaPATH) && !checkCSV(PowerPATH) {
		megaCSVResponse = getCSV(MegaURL)
		powerCSVResponse = getCSV(PowerURL)

		writeCSV(MegaPATH, megaCSVResponse)
		writeCSV(PowerPATH, powerCSVResponse)
	}

	megaArr := strings.Split(readCSV(MegaPATH), "\n")
	powerArr := strings.Split(readCSV(PowerPATH), "\n")

	megaLastEight := megaArr[len(megaArr)-9 : len(megaArr)-1]
	powerLastEight := powerArr[len(powerArr)-9 : len(powerArr)-1]

	megaRecent := strings.Join(megaLastEight, "\n")
	powerRecent := strings.Join(powerLastEight[:], "\n")

	fmt.Println("MEGA")
	fmt.Println(megaRecent)
	fmt.Println("POWER")
	fmt.Println(powerRecent)
}
