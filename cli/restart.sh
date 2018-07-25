#!/bin/bash

#   ----------  Script constant section

VERSION='1.0'
NAME="restart.sh"

#   ----------  Colors Const section

NC='\033[0m'              # No Color
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

#   ----------  Commands section

function help {
    echo -e "Usage: restart.sh run\n"
    echo -e "Restart the stack with docker-compose\n"
    echo -e "Commands:\n"
    echo "                      Restart docker-compose stack without container php openldap"
    echo "  -b, --build         Restart docker-compose stack with --build option"
    echo "  -T, --run-tools     Restart docker-compose stack with container php openldap"
    echo "  --help              Display help"
}

function stop {
    echo "Stop all container..."
    docker-compose -f docker-compose.yml -f docker-compose.admin.yml down
}



runTools='--admin-tools'
runToolsShort='-A'

buildShort="-b"
build="--build"

help='--help'

tFlags='false'
bFlags='false'
errorFlags='false'
helpFlags='false'

if [ -z $2 ]
then
    stop
    ./cli/startup.sh run
else
    #this prints all arguments
    while test $# -gt 0
    do
        case $1 in
            "restart")
                echo "Restart command"
                ;;
            $runTools | $runToolsShort)
                tFlags='true'
                ;;
            $build | $buildShort)
                bFlags="true"
                ;;
            $help)
                helpFlags='true'
                ;;
            *)
                errorFlags='true'
                ;;
        esac
        shift
    done
fi

if [ $errorFlags = 'true' ]
then
    echo -e "${Red}ERROR: Unknow command"
    echo -e "See: restart.sh --help for usage${NC}"

elif [ $helpFlags = 'true' ]
then
    help

elif [ $tFlags = "true" ] && [ $bFlags = "true" ]
then
    stop
    ./cli/startup.sh run -b -A

elif [ $tFlags = "true" ] && [ $bFlags = "false" ]
then
    stop
    ./cli/startup.sh run -A

elif [ $tFlags = "false" ] && [ $bFlags = "true" ]
then
    stop
    ./cli/startup.sh run -b
fi
