# MEGA POWER

Pull in the latest mega millions and powerball stuffs

Example of latest 8

![megapowergo](https://user-images.githubusercontent.com/9837366/45861000-d6d20200-bd2f-11e8-8637-9ba205645dc1.png)

# Use

`go run main.go`

`go get github.com/selfup/mega_power && go install mega_power`

`mega_power`

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
