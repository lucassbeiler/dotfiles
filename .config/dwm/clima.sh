#!/bin/sh

Clima() {
    curl -s 'https://api.weather.com/v3/wx/observations/current?language=en-US&apiKey=6532d6454b8aa370768e63d6ba5a832e&geocode=-26.844191910135486%2C-48.63185600047038&units=m&format=json' -H 'Referer: https://notabug.org/' -H 'DNT: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.62 Safari/537.36' -H 'Sec-Fetch-Mode: cors' --compressed | \
    python -c "import sys, json; tudo = json.load(sys.stdin); print(str(tudo['temperature']) + '⁰C / ' + str(tudo['windSpeed']) + 'km/h (' + tudo['windDirectionCardinal'] + ')')"

}

while :; do
    temperatura=$(Clima)
    if [ "$(cat $HOME/.temperatura_atual)" != "$temperatura" ]; then
        echo $temperatura > $HOME/.temperatura_atual
    fi

    if [ "$temperatura" == "" ]; then
        echo "ERRO" > $HOME/.temperatura_atual
    fi

    sleep 1360
done
