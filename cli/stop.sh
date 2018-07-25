#   ----------  Script constant section

VERSION='1.0'
NAME="stop.sh"

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

function help {
    echo -e "Usage: ${NAME} run\n"
    echo -e "Stop the stack with docker-compose\n"
}

function stop {
    echo "Stop all container..."
    docker-compose -f docker-compose.yml -f docker-compose.admin.yml down
}

help='--help'
errorFlags='false'
helpFlags='false'

if [ -z $2 ]
then
    stop
else
    #this prints all arguments
    while test $# -gt 0
    do
        case $1 in
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

if [ $helpFlags = 'true' ]
then
    help
elif [ $errorFlags = 'true' ]
then
    echo -e "${Red}ERROR: Unknow command"
    echo -e "See: ${NAME} --help for usage${NC}"
fi