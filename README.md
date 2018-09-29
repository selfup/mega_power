# MEGA POWER

Pull in the latest mega millions and powerball stuffs

Example of latest 8

![megapowergo](https://user-images.githubusercontent.com/9837366/45861000-d6d20200-bd2f-11e8-8637-9ba205645dc1.png)

# Use

```bash
go get github.com/selfup/mega_power \
  && go install github.com/selfup/mega_power
```

Now globally: `mega_power`

# Fair Warning

Since files are being written, I have to write two dotfiles in your $HOME dir.

The nature of execs is that I have no idea where you are executing them :joy:

```go
home := os.Getenv("USERPROFILE")

if home == "" {
    home = os.Getenv("HOME")
}

MegaPATH := home + "/.mega_power.mega.data.csv"
PowerPATH := home + "/.mega_power.power.data.csv"
```

To get rid of these harmless files: `rm -rf ~/.mega_power.*` :pray:

# Development

If you want to work on this make sure you clone this into your `$GOPATH`

Otherwise imports will break :boom:

_building a binary release soon!_

1. It will fetch the data if it's not there.
1. Once the data is there, it will return the last 8 results of each lottery.

# Be nice

Don't slam the api. I would just call `new` every few days. Keep the data fresh, api calls low :boat:   

# But I Like Bash Scripts!

Me too :smile:

_cd into this repo_

### Fetch lottery data for Mega and Power

`./scripts/fetch.data.sh`

### Check last [n] drawings for Mega

`./scripts/mega.last.sh 3` --> returns last 3 drawings

### Check last [n] drawings for Power

`./scripts/power.last.sh 3` --> returns last 3 drawings

### Check by date of drawing

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

### Check to see if numbers match

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

# TODO

Work on cli ux
