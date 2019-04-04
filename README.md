# MEGA POWER

[Go](#go)

[Bash](#bash)

[Powershell](#powershell)

Pull in the latest mega millions and powerball stuffs

Example of latest 8

![new_mega_power_api](https://user-images.githubusercontent.com/9837366/51288802-6a0c0300-19c3-11e9-90c2-75734d4c4b39.PNG)

## Fair Warning

Since files are being written, I have to write two dotfiles in your:

macOS/Linux: `$HOME`
Windows: `%USERPROFILE%`

To get rid of these harmless files: `rm ~/.mega_power.*` (bash/pwsh) :pray:

## Be nice

Don't slam the api. I would just call `new` (go) or `--update` (pwsh) every few days. Keep the data fresh, api calls low :boat:

## Go

```bash
go get github.com/selfup/mega_power \
  && go install github.com/selfup/mega_power
```

Now globally: `mega_power`

## Development

If you want to work on this make sure you clone this into your `$GOPATH`

Otherwise imports will break :boom:

_building a binary release soon!_

1. It will fetch the data if it's not there.
1. Once the data is there, it will return the last 8 results of each lottery.

## Bash

_cd into this repo_

#### Fetch lottery data for Mega and Power

`./scripts/fetch.data.sh`

#### Check last [n] drawings for Mega

`./scripts/mega.last.sh 3` --> returns last 3 drawings

#### Check last [n] drawings for Power

`./scripts/power.last.sh 3` --> returns last 3 drawings

#### Check by date of drawing

```bash
./scripts/date.mega.sh "09/21/2018"
09/21/2018,01 02 11 52 64,09,04
```

This is just a grep, so you can check by only month - day - year or any combo of MM/DD/YY

Example:

```bash
./scripts/date.mega.sh "21/2018"
08/21/2018,14 16 19 38 57,11,03
09/21/2018,01 02 11 52 64,09,04
```

#### Check to see if numbers match

Use a last scripts for your lottery of choice

`numbers.mega.sh` takes two args:

1. First arg is how many latest drawings
1. Second arg is a string of the numbers you wanna grep

```bash
./scripts/numbers.mega.sh 3 "01 02"
```

Returns:

```bash
09/21/2018,01 02 11 52 64,09,04
```

Grep is nice and highlights matches in red :tada:

To narrow down the grep you can filter by date if your ticket is old or something.

You can even just check for one number on that draw date too:

```bash
./scripts/numbers.mega.sh 3 "01 02" | grep "09/21/2018"
09/21/2018,01 02 11 52 64,09,04
```

## PowerShell

Basic use:

```powershell
.\powershell\fetch.ps1
```

If you get a permission error, try:

```powershell
powershell -ExecutionPolicy ByPass -File .\powershell\fetch.ps1
```

![image](https://user-images.githubusercontent.com/9837366/55524880-7283e980-5654-11e9-8229-6d6fbfe41dfd.png)

#### Update Data Flag

Full prompt when updating existing csv data:

```powershell
powershell -ExecutionPolicy ByPass -File .\powershell\fetch.ps1 --update
```

![image](https://user-images.githubusercontent.com/9837366/55524651-add1e880-5653-11e9-84a6-a474ffab4f17.png)
