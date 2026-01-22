#!/bin/bash

HOSTNAME=$(hostname)
TIMEZONE=$(cat /etc/timezone)
USER=$(whoami)
UTC=$(date +"%-:::z")
OS=$(uname -r)
DATE=$(date +"%-d %B %Y %T")
UPTIME=$(uptime -p | cut -b 4-)
UPTIME_SEC=$(awk '{print $1}' /proc/uptime)
IP=$(ip addr show | grep 'inet ' | awk '{print $2}' | cut -d '/' -f 1 | head -n 1)
MASK=$(ip addr show | grep "inet " | awk '{print $2}' | cut -d '/' -f 2 | head -n 1)
GATEWAY=$(ip r | grep "default"); GATEWAY=${GATEWAY##default via }; GATEWAY=${GATEWAY%% *};
RAM_TOTAL=$(free | grep "Mem" | awk '{print $2}' | awk '{printf("%.3f", $1/1024/1024)}')
RAM_USED=$(free | grep "Mem" | awk '{print $3}' | awk '{printf("%.3f", $1/1024/1024)}')
RAM_FREE=$(free | grep "Mem" | awk '{print $4}' | awk '{printf("%.3f", $1/1024/1024)}')
SPACE_ROOT=$(df / | grep "dev" | awk '{print $2}' | awk '{printf("%.2f", $1/1024)}')
SPACE_ROOT_USED=$(df / | grep "dev" | awk '{print $3}' | awk '{printf("%.2f", $1/1024)}')
SPACE_ROOT_FREE=$(df / | grep "dev" | awk '{print $4}' | awk '{printf("%.2f", $1/1024)}')

echo "HOSTNAME = $HOSTNAME"
echo "TIMEZONE = $TIMEZONE UTC $UTC" 
echo "USER = $USER" 
echo "OS = $OSTYPE $OS" 
echo "DATE = $DATE" 
echo "UPTIME = $UPTIME" 
echo "UPTIME_SEC = $UPTIME_SEC" 
echo "IP = $IP" 
echo "MASK = $MASK" 
echo "GATEWAY = $GATEWAY" 
echo "RAM_TOTAL = $RAM_TOTAL GB" 
echo "RAM_USED = $RAM_USED GB" 
echo "RAM_FREE = $RAM_FREE GB" 
echo "SPACE_ROOT = $SPACE_ROOT MB" 
echo "SPACE_ROOT_USED = $SPACE_ROOT_USED MB" 
echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE MB"  

read -r -p "Do you want to write the data to a file? (Y/N): " answer
yes='^[yY]$'
if [[ ($answer =~ $yes) ]]
then
	DATE=$(date | awk '{print $3"_"$2"_"$6"_"$4}')
	DATE=${DATE//:/_}
	file="$DATE.status.txt"
	touch $file
	echo "HOSTNAME = $HOSTNAME" >> $file
    echo "TIMEZONE = $TIMEZONE UTC $UTC" >> $file
    echo "USER = $USER" >> $file
    echo "OS = $OSTYPE $OS" >> $file
    echo "DATE = $DATE" >> $file
    echo "UPTIME = $UPTIME" >> $file
    echo "UPTIME_SEC = $UPTIME_SEC" >> $file
    echo "IP = $IP" >> $file
    echo "MASK = $MASK" >> $file
    echo "GATEWAY = $GATEWAY" >> $file
    echo "RAM_TOTAL = $RAM_TOTAL GB" >> $file
    echo "RAM_USED = $RAM_USED GB" >> $file
    echo "RAM_FREE = $RAM_FREE GB" >> $file
    echo "SPACE_ROOT = $SPACE_ROOT MB" >> $file
    echo "SPACE_ROOT_USED = $SPACE_ROOT_USED MB" >> $file
    echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE MB" >> $file
fi