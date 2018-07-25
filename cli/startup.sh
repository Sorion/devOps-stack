#!/bin/bash

#    .---------- constant part!
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

function help {
    echo -e "Usage: startup.sh run\n"
    echo -e "Run the stack with docker-compose\n"
    echo -e "Commands:\n"
    echo "                      Run docker-compose stack without php openldap"
    echo "  -b, --build         Run docker-compose stack with --build option"
    echo "  -A, --admin-tools   Run docker-compose stack with container php openLDAP"
    echo "  --help              Display help"
}

function warning {
    echo -e "${Yellow}WARNING: php openldap container should used only for the first or additional configuration"
    echo -e "You should turn it off when initial configuration is done! ${NC}\n"
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
    echo "Run docker-compose in production mode..."
    docker-compose up -d
else
    #this prints all arguments
    while test $# -gt 0
    do
        case $1 in
            "run")
                echo "Run command"
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
    echo -e "See: startup.sh --help for usage${NC}"

elif [ $helpFlags = 'true' ]
then
    help

elif [ $tFlags = "true" ] && [ $bFlags = "true" ]
then
    warning
    echo "Run docker-compose up -b with php openldap container..."
    docker-compose -f docker-compose.yml -f docker-compose.admin.yml up -d --build

elif [ $tFlags = "true" ] && [ $bFlags = "false" ]
then
    warning
    echo "Run docker-compose up with php openldap container ..."
    docker-compose -f docker-compose.yml -f docker-compose.admin.yml up -d

elif [ $tFlags = "false" ] && [ $bFlags = "true" ]
then
    echo "Starting docker stack..."
    docker-compose -f docker-compose.yml up -d --build

fi

