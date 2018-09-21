package utils

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"strings"
)

// urls for megamillions and powerball stuff
const (
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

// FetchAndWriteOrPass checks to see if data already exists
// if data already exists then nothing happens
// if data does not exist data is fetched and then written to disk
func FetchAndWriteOrPass(megaPath string, powerPath string) {
	if !checkCSV(megaPath) && !checkCSV(powerPath) {
		megaCSVResponse := getCSV(MegaURL)
		powerCSVResponse := getCSV(PowerURL)

		writeCSV(megaPath, megaCSVResponse)
		writeCSV(powerPath, powerCSVResponse)
	}
}

// LastEight takes in the file path and then grabs the last eight records
func LastEight(path string) string {
	csvStr := readCSV(path)
	csvArr := strings.Split(csvStr, "\n")

	lastEightArr := csvArr[len(csvArr)-9 : len(csvArr)-1]

	return strings.Join(lastEightArr, "\n")
}