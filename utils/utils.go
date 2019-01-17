package utils

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"strings"
)

// nyc gov [powerball and megamillions] csv api endpoints
const (
	MegaURL  = "https://data.ny.gov/api/views/5xaw-6ayf/rows.csv?accessType=DOWNLOAD"
	PowerURL = "https://data.ny.gov/api/views/d6yy-54nr/rows.csv?accessType=DOWNLOAD"
)

// CheckCliArgs checks to see if data already exists
// it also checks for the "new" os.Arg
// if "new" os.Arg[1] - API calls are made to update lotto data
// otherwise
// if data already exists then nothing happens
// if data does not exist data is fetched and then written to disk
func CheckCliArgs(megaPath string, powerPath string) {
	cliArgs := len(os.Args) > 1

	if cliArgs {
		if os.Args[1] == "new" {
			fetchAndWrite(megaPath, powerPath)
		}
	}

	if !checkCSV(megaPath) && !checkCSV(powerPath) {
		fetchAndWrite(megaPath, powerPath)
	}
}

// Recent takes in the file path and then grabs the last eight records
func Recent(path string) string {
	csvStr := readCSV(path)
	csvArr := strings.Split(csvStr, "\n")

	recent := csvArr[:8]

	return strings.Join(recent, "\n")
}

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

func fetchAndWrite(megaPath string, powerPath string) {
	megaCSVResponse := getCSV(MegaURL)
	powerCSVResponse := getCSV(PowerURL)

	writeCSV(megaPath, megaCSVResponse)
	writeCSV(powerPath, powerCSVResponse)
}
