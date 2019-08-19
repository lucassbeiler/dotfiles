#!/bin/sh


Memoria(){
      ram=$(free -mh | awk '{print $3}' | sed -n '2p' | sed "s/Gi/GB/")
      echo -en "\uf538 $ram"
}

Relogio() {
      date=$(date "+%a, %d/%m %H:%M:%S")
      echo -en "\uf017 $date"
}

Clima() {
	temperatura="$(cat $HOME/.temperatura_atual)"
	if [ "$temperatura" -gt '15' ]; then
		iconTemp="\uf185" #calor
	elif [ "$temperatura" -lt '16' ]; then
		iconTemp="\uf2dc" #frio comfy
	fi
	echo -en "$iconTemp $temperatura°C"
}

Bateria() {
	BATERIA=$(cat /sys/class/power_supply/BAT1/capacity)
	if [ $(cat /sys/class/power_supply/ADP1/online) -eq '1' ]; then
		iconeBat="\uf5e7" #carregando
	elif [ "$BATERIA" -lt '18' ]; then
		iconeBat="\uf244" #acabando
	else
		iconeBat="\uf240" #decente
	fi

	echo -en "$iconeBat $BATERIA%"
}

Rede() {
	ip=$(ip addr show scope global | awk '$1 ~ /^inet/ {print $2}' | head -c 13)
	echo -en "\uf1eb $ip"
}

Volume() {
	#volume=$(amixer sget Master | grep "Mono:" | awk -F '[][]' '{ print $2 }')
	volume=$(amixer get Master | grep -o -E [[:digit:]]+% | tail -n1)
	echo -en "\uf028 $volume"
}

Proce(){
	cpu=$(top -bn1 | grep -i "cpu(s)" | cut -d "," -f1 | cut -d ":" -f2)
	echo -e "\uf2db $cpu%"

}

while :; do
      xsetroot -name "|$(Clima)|$(Volume)|$(Bateria)|$(Proce)|$(Rede)|$(Memoria)|$(Relogio)"
      sleep 1
done &
