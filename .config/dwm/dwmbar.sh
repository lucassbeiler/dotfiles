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
	if [ "$temperatura" -ge '17' ]; then
		iconTemp="\uf185" #calor
	elif [ "$temperatura" -le '16' ]; then
		iconTemp="\uf2dc" #frio comfy
	fi
	echo -en "$iconTemp $temperatura⁰C"
}

Bateria() {
	BATERIA=$(cat /sys/class/power_supply/BAT1/capacity)
	if [ $(cat /sys/class/power_supply/ADP1/online) -eq '1' ]; then
		iconeBat="\uf5e7" #carregando
  elif [ "$BATERIA" -le '75' ]; then
		iconeBat="\uf241" #3/4 de 100%
  elif [ "$BATERIA" -le '50' ]; then
    iconeBat="\uf242" #metade
  elif [ "$BATERIA" -le '25' ]; then
    iconeBat="\uf243" #1/4 de 100%
  elif [ "$BATERIA" -le '15' ]; then
    iconeBat="\uf244" #fim
	else
		iconeBat="\uf240" #76%~100%
	fi
	echo -en "$iconeBat $BATERIA%"
}

Rede() {
	ip=$(ip addr show scope global | awk '$1 ~ /^inet/ {print $2}' | cut -d "/" -f1)
	echo -en "\uf1eb $ip"
}

Volume() {
  volume=$(amixer get Master | grep -o -E [[:digit:]]+% | tail -n1)
	volumeInt=$(amixer get Master | grep -o -E [[:digit:]]+% | tail -n1 | cut -d "%" -f1)
  if [ "$volumeInt" -le '48' ]; then
    iconeVol="\uf027"
	elif [ "$volumeInt" -le '5' ]; then
    iconeVol="\uf026"
	elif [ "$volumeInt" -eq '0' ]; then
    iconeVol="\uf6a9"
  else
    iconeVol="\uf028"

  echo -en "$iconeVol $volume"
}

Proce(){
	cpu=$(top -bn1 | grep -i "cpu(s)" | cut -d "," -f1 | cut -d ":" -f2)
	echo -e "\uf2db $cpu%"

}

while :; do
      xsetroot -name "|$(Clima)|$(Volume)|$(Bateria)|$(Proce)|$(Rede)|$(Memoria)|$(Relogio)"
      sleep 1
done &
