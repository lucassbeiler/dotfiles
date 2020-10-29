#!/bin/sh

Memoria(){
      ram=$(free -mh | awk '{print $3}' | sed -n '2p' | sed "s/Gi/GB/")
      swap=$(free -mh | awk '{print $3}' | sed -n '3p' | sed "s/Gi/GB/")
      echo -en "\uf538 $ram / $swap"
}

Relogio() {
      date=$(date "+%a, %d/%m %H:%M:%S")
      echo -en "\uf017 $date"
}

Clima() {
	temperatura="$(cat $HOME/.temperatura_atual)"
	echo -en "\uf0c2 $temperatura"
}

Bateria() {
	BATERIA=$(cat /sys/class/power_supply/BAT1/capacity)
	if [ $(cat /sys/class/power_supply/ADP1/online) -eq '1' ]; then
		iconeBat="\uf5e7" #carregando
	elif [ "$BATERIA" -gt '75' ]; then
		iconeBat="\uf240" #76% ~ 100% 
	elif [[ "$BATERIA" -le '75' ]] && [[ "$BATERIA" -gt '50' ]]; then
	 	iconeBat="\uf241" #3/4 de 100%
	elif [[ "$BATERIA" -le '50' ]] && [[ "$BATERIA" -gt '25' ]]; then
    		iconeBat="\uf242" #metade
	elif [[ "$BATERIA" -le '25' ]] && [[ "$BATERIA" -gt '15' ]]; then
    		iconeBat="\uf243" #1/4 de 100%
	elif [ "$BATERIA" -le '15' ]; then
    		iconeBat="\uf244" #fim
	fi
	echo -en "$iconeBat $BATERIA%"
}

Rede() {
	ip=$(ip addr show scope global | awk '$1 ~ /^inet/ {print $2}' | cut -d "/" -f1 | sed -n '1p')
	echo -en "\uf1eb $ip"
}

Volume() {
	volume=$(pactl list sinks | grep "^[[:space:]]Volume:" | cut -d'/' -f2 | head -n1)
	volumeInt=$(echo "${volume//[!0-9]/}")

	if [ "$volumeInt" -gt '48' ]; then
		iconeVol="\uf028"
	elif [[ "$volumeInt" -le '48' ]] && [[ "$volumeInt" -gt '5' ]]; then
    		iconeVol="\uf027"
	elif [[ "$volumeInt" -le '5' ]] && [[ "$volumeInt" -gt '0' ]]; then
    		iconeVol="\uf026"
	else
    		iconeVol="\uf6a9"
  	fi

  	echo -en "$iconeVol $volumeInt%"
}

Proce(){
	cpu=$(top -bn1 | grep -i "cpu(s)" | cut -d "," -f1 | cut -d ":" -f2)
	echo -e "\uf2db $cpu%"

}

while :; do
      xsetroot -name "| $(Clima) | $(Volume) | $(Bateria) | $(Proce) | $(Rede) | $(Memoria) | $(Relogio)"
      sleep 1
done &
