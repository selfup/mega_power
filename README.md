# MEGA POWER

Pull in the latest mega millions and powerball stuffs

MVP in ruby. Golang next for portability :tada:

Example of latest 5 (now latest 8)

![megapower8](https://user-images.githubusercontent.com/9837366/45858881-1f37f280-bd25-11e8-8336-c6225260fe94.png)

# Use

### Install deps

`bundle install`

### Then

1. Pull in all data :smile:

    ```bash
    ruby main.rb new
    ```

    Now you can run `recent` without making api calls :rocket:

2. Get the latest 8 results for each contest

    ```bash
    ruby main.rb recent
    ```

# Be nice

Don't slam the api. I would just call `new` every few days. Keep the data fresh, api calls low :boat:   
