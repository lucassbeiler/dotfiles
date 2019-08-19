#!/bin/sh

Clima() {
curl 'https://api.weather.com/v3/wx/observations/current?language=en-US&apiKey=6532d6454b8aa370768e63d6ba5a832e&geocode=-26.9%2C-48.66&units=m&format=json' -H 'Accept:
application/json, text/plain, */*' -H 'Referer: https://notabug.org/' -H 'DNT: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.62 Safari/537.36' -H 'Sec-Fetch-Mode: cors' --compressed | \
cut -d ":" -f31 | \
cut -d "," -f1
}

while :; do

if [ "$(cat $HOME/.temperatura_atual)" != "$(Clima)" ]
then
echo $(Clima) > $HOME/.temperatura_atual
fi

sleep 1420
done