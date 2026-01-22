#!/bin/bash

source config.txt
re='^[1-6]$'

if [[ !($column1_background =~ $re || $column1_background == "") || 
	!($column1_font_color =~ $re || $column1_font_color == "") ||
       	!($column2_background =~ $re || $column2_background == "") ||
       	!($column2_font_color =~ $re || $column2_font_color == "") ]]
then
	echo "Incorrect input"
	exit 1
fi

if [[ $column1_background == "" ]]
then
	column1_background="default"
fi

if [[ $column1_font_color == "" ]]
then
	column1_font_color="default"
fi

if [[ $column2_background == "" ]]
then
	column2_background="default"
fi

if [[ $column2_font_color == "" ]]
then
	column2_font_color="default"
fi


WHITE='\033[37'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m' 
PURPLE='\033[0;35m'
BLACK='\033[0;30m'

NC='\033[0m'

FON_WHITE='\033[47m'
FON_RED='\033[41m'
FON_GREEN='\033[42m'
FON_BLUE='\033[44m'
FON_PURPLE='\033[45m'
FON_BLACK='\033[40m'

case $column1_background in
	1)
		FIRST_FON=$FON_WHITE
		first_fon_name="white"
		;;
	2)
		FIRST_FON=$FON_RED
		first_fon_name="red"
		;;
	3)
		FIRST_FON=$FON_GREEN
		first_fon_name="green"
		;;
	4)
		FIRST_FON=$FON_BLUE
		first_fon_name="blue"
		;;
	5)
		FIRST_FON=$FON_PURPLE
		first_fon_name="purple"
		;;
	6 | default)
		FIRST_FON=$FON_BLACK
		first_fon_name="black"
		;;
esac

case $column1_font_color in
	1 | default)
		FIRST_FRONT=$WHITE
		first_front_name="white"
		;;
	2)
		FIRST_FRONT=$RED
		first_front_name="red"
		;;
	3)
		FIRST_FRONT=$GREEN
		first_front_name="green"
		;;
	4)
		FIRST_FRONT=$BLUE
		first_front_name="blue"
		;;
	5)
		FIRST_FRONT=$PURPLE
		first_front_name="purple"
		;;
	6)
		FIRST_FRONT=$BLACK
		first_front_name="black"
		;;
esac

case $column2_background in
	1)
		SECOND_FON=$FON_WHITE
		second_fon_name="white"
		;;
	2)
		SECOND_FON=$FON_RED
		second_fon_name="red"
		;;
	3)
		SECOND_FON=$FON_GREEN
		second_fon_name="green"
		;;
	4)
		SECOND_FON=$FON_BLUE
		second_fon_name="blue"
		;;
	5 | default)
		SECOND_FON=$FON_PURPLE
		second_fon_name="purple"
		;;
	6)
		SECOND_FON=$FON_BLACK
		second_fon_name="black"
		;;
esac

case $column2_font_color in
	1 | default)
		SECOND_FRONT=$WHITE
		second_front_name="white"
		;;
	2)
		SECOND_FRONT=$RED
		second_front_name="red"
		;;
	3)
		SECOND_FRONT=$GREEN
		second_front_name="green"
		;;
	4)
		SECOND_FRONT=$BLUE
		second_front_name="blue"
		;;
	5)
		SECOND_FRONT=$PURPLE
		second_front_name="purple"
		;;
	6)
		SECOND_FRONT=$BLACK
		second_front_name="black"
		;;
esac

if [[ ($first_fon_name == $first_front_name) || ($second_fon_name == $second_front_name) ]]
then
	echo "The font and background colors match. Call the script again"
	exit 1
fi

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

echo -e "${FIRST_FRONT}${FIRST_FON}HOSTNAME${NC} = ${SECOND_FRONT}${SECOND_FON}$HOSTNAME${NC}"
echo -e "${FIRST_FRONT}${FIRST_FON}TIMEZONE${NC} = ${SECOND_FRONT}${SECOND_FON}$TIMEZONE UTC $UTC${NC}" 
echo -e "${FIRST_FRONT}${FIRST_FON}USER${NC} = ${SECOND_FRONT}${SECOND_FON}$USER${NC}" 
echo -e "${FIRST_FRONT}${FIRST_FON}OS${NC} = ${SECOND_FRONT}${SECOND_FON}$OSTYPE $OS${NC}" 
echo -e "${FIRST_FRONT}${FIRST_FON}DATE${NC} = ${SECOND_FRONT}${SECOND_FON}$DATE${NC}" 
echo -e "${FIRST_FRONT}${FIRST_FON}UPTIME${NC} = ${SECOND_FRONT}${SECOND_FON}$UPTIME${NC}" 
echo -e "${FIRST_FRONT}${FIRST_FON}UPTIME_SEC${NC} = ${SECOND_FRONT}${SECOND_FON}$UPTIME_SEC${NC}" 
echo -e "${FIRST_FRONT}${FIRST_FON}IP${NC} = ${SECOND_FRONT}${SECOND_FON}$IP${NC}" 
echo -e "${FIRST_FRONT}${FIRST_FON}MASK${NC} = ${SECOND_FRONT}${SECOND_FON}$MASK${NC}" 
echo -e "${FIRST_FRONT}${FIRST_FON}GATEWAY${NC} = ${SECOND_FRONT}${SECOND_FON}$GATEWAY${NC}" 
echo -e "${FIRST_FRONT}${FIRST_FON}RAM_TOTAL${NC} = ${SECOND_FRONT}${SECOND_FON}$RAM_TOTAL GB${NC}" 
echo -e "${FIRST_FRONT}${FIRST_FON}RAM_USED${NC} = ${SECOND_FRONT}${SECOND_FON}$RAM_USED GB${NC}" 
echo -e "${FIRST_FRONT}${FIRST_FON}RAM_FREE${NC} = ${SECOND_FRONT}${SECOND_FON}$RAM_FREE GB${NC}" 
echo -e "${FIRST_FRONT}${FIRST_FON}SPACE_ROOT${NC} = ${SECOND_FRONT}${SECOND_FON}$SPACE_ROOT MB${NC}" 
echo -e "${FIRST_FRONT}${FIRST_FON}SPACE_ROOT_USED${NC} = ${SECOND_FRONT}${SECOND_FON}$SPACE_ROOT_USED MB${NC}" 
echo -e "${FIRST_FRONT}${FIRST_FON}SPACE_ROOT_FREE${NC} = ${SECOND_FRONT}${SECOND_FON}$SPACE_ROOT_FREE MB${NC}"

echo "Column 1 background = ${column1_background} (${first_fon_name})"
echo "Column 1 font color = ${column1_font_color} (${first_front_name})"
echo "Column 2 background = ${column2_background} (${second_fon_name})"
echo "Column 2 font color = ${column2_font_color} (${second_front_name})"
