#!/bin/bash
# Author: Rudelle65
# Github: https://github.com/Rudelle65/LinuxGmod

#########################
#### Server Settings ####
#########################

ScreenName="GMODSERVER01" # Change this value if you create multiple servers

defaultmap="gm_construct" # Map of your server
gamemode="sandbox" # Gamemode of your server
maxplayers="16" # Maximum number of players
port="27015" # Boot port
tickrate="22"
ip="0.0.0.0" # IP address of the network interface
workshopcollectionid="" # ID of your workshop collection
workshopauth="" # https://steamcommunity.com/dev/apikey
customparms="+r_hunkalloclightmaps 0 -disableluarefresh" # Custom Start Parameters


########################
######## Script ########
###### Do not edit #####
########################

servercfg="config/server.cfg"

consoleYN() {
    local prompt default reply
    while true; do
        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi
        echo -n "$1 [$prompt] "
        read reply </dev/tty
        if [ -z "$reply" ]; then
            reply=$default
        fi
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
    done
}

if [ -z "$1" ]; then
        echo "List of commands:"
        echo "To start the server: start"
        echo "To stop the server: stop"
        echo "To restart the server: restart"
        echo "To open the console: console"
        exit
fi
if [ "$1" != "start" ]&&[ "${1}" != "stop" ]&&[ "${1}" != "restart" ]&&[ "${1}" != "console" ]; then
        echo "List of commands:"
        echo "To start the server: start"
        echo "To stop the server: stop"
        echo "To restart the server: restart"
        exit
fi

if [ "$1" == "start" ]; then
        echo "Your server is starting up."
        screen -dmS ${ScreenName} ./srcds_run -game garrysmod -strictportbind -ip ${ip} -port ${port} -tickrate ${tickrate} -maxplayers ${maxplayers} +host_workshop_collection ${workshopcollectionid} -authkey ${workshopauth} +gamemode ${gamemode} +map ${defaultmap} +servercfgfile ${servercfg} ${customparms}
        exit
fi

if [ "$1" == "stop" ]; then
        echo "Your server is shutting down."
        screen -p 0 -S ${ScreenName} -X eval 'stuff "quit"\\015'
        exit
fi

if [ "$1" == "restart" ]; then
        screen -p 0 -S ${ScreenName} -X eval 'stuff "_restart"\\015'
        exit
fi

if [ "$1" == "console" ]; then
        echo "To close the console press [CTRL]+[a] followed by [d]"
        if consoleYN "Are you sure to open the console?"; then
            screen -r ${ScreenName}
        else
            echo "Canceling the opening of the console."
        fi
        exit
fi

if [ "$1" == "update" ]; then
        if consoleYN "Are you sure you want to update your server?"; then
            ./gmod-server stop
            cd steamcmd
            ./steamcmd.sh +login anonymous +force_install_dir ../serverfiles +app_update 4020 validate +quit
            cd ..
        else
            echo "Update process stopped."
        fi
        exit
fi
