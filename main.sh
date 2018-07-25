#!/bin/bash

#   ----------  Script constant section

VERSION='1.0'
NAME="main.sh"

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

RUN_CMD='run'
RESTART_CMD='restart'
STOP_CMD='stop'

#   ----------  Main options section

HELP_OPT='--help'
VERSION_OPT='--version'

#   ----------  Functions section

function help {
    echo -e "Usage: ${NAME} COMMAND\n"
    echo -e 'Manage the devops stack with docker-compose\n'
    echo -e 'Commands:\n'
    echo '  run                 Run the stack with docker-compose'
    echo '  restart             Restart the stack'
    echo '  stop                Stop the stack'
    echo '  --help              Display help'
    echo '  --version           Display the version of this script, docker & docker-compose'
    echo -e "\nRun '${NAME} COMMAND --help' for more information on a command."
}

function unknown {
    echo -e "${Red}${NAME} '${1}' is not a valid command."
    echo -e "See '${NAME}  --help' ${NC}"
}

function version {
    echo "${NAME} h version ${VERSION}"
    docker --version
    docker-compose --version
}

function run {
    ./cli/startup.sh "$@"
}

function restart {
    ./cli/restart.sh "$@"
}

function stop {
    ./cli/stop.sh "$@"
}

#   ----------  Entry Point section

case $1 in
    $RUN_CMD)
        run $@
        ;;
    $RESTART_CMD)
        restart $@
        ;;
    $STOP_CMD)
        stop $@
        ;;
    $HELP_OPT)
        help
        ;;
    $VERSION_OPT)
        version
        ;;
    *)
        unknown $1
        ;;
esac
