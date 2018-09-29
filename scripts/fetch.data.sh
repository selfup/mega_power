echo '--> FETCHING MEGAMILLIONS INFO FROM NYCGOV...' \
  && wget -O $HOME/.mega_power.mega.data.csv https://data.ny.gov/api/views/5xaw-6ayf/rows.csv?accessType=DOWNLOAD \
  && echo '--> FETCHING POWERBALL INFO FROM NYCGOV...' \
  && wget -O $HOME/.mega_power.power.data.csv https://data.ny.gov/api/views/d6yy-54nr/rows.csv?accessType=DOWNLOAD \
  && echo 'ALL DATA HAS BEEN FETCHED!'
