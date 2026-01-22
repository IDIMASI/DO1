#!/bin/bash

if [[ $# != 4 ]]
then
	echo "Invalid number of arguments (expected 4, input $#)"
	exit 1
fi

re='^[1-6]$'

if [[ !($1 =~ $re) || !($2 =~ $re ) || !($3 =~ $re) || !($4 =~ $re) ]]
then
	echo "Incorrect input"
	exit 1
fi

if [[ ($1 == $2) || ($3 == $4) ]]
then
	echo "The font and background colors match. Call the script again"
	exit 1
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

case $1 in
	1)
		FIRST_FON=$FON_WHITE
		;;
	2)
		FIRST_FON=$FON_RED
		;;
	3)
		FIRST_FON=$FON_GREEN
		;;
	4)
		FIRST_FON=$FON_BLUE
		;;
	5)
		FIRS_FON=$FON_PURPLE
		;;
	6)
		FIRST_FON=$FON_BLACK
		;;
esac

case $2 in
	1)
		FIRST_FRONT=$WHITE
		;;
	2)
		FIRST_FRONT=$RED
		;;
	3)
		FIRST_FRONT=$GREEN
		;;
	4)
		FIRST_FRONT=$BLUE
		;;
	5)
		FIRST_FRONT=$PURPLE
		;;
	6)
		FIRST_FRONT=$BLACK
		;;
esac

case $3 in
	1)
		SECOND_FON=$FON_WHITE
		;;
	2)
		SECOND_FON=$FON_RED
		;;
	3)
		SECOND_FON=$FON_GREEN
		;;
	4)
		SECOND_FON=$FON_BLUE
		;;
	5)
		SECOND_FON=$FON_PURPLE
		;;
	6)
		SECOND_FON=$FON_BLACK
		;;
esac

case $4 in
	1)
		SECOND_FRONT=$WHITE
		;;
	2)
		SECOND_FRONT=$RED
		;;
	3)
		SECOND_FRONT=$GREEN
		;;
	4)
		SECOND_FRONT=$BLUE
		;;
	5)
		SECOND_FRONT=$PURPLE
		;;
	6)
		SECOND_FRONT=$BLACK
		;;
esac

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

