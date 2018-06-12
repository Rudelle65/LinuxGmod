#!/bin/bash

# ----------------------------------#
#									                  #
#   Script developed by Rudelle65   #
#									                  #
# ----------------------------------#

sudo apt-get -y update
sudo apt-get -y install screen lib32gcc1 wget curl ca-certificates

wget https://raw.githubusercontent.com/Rudelle65/LinuxGmod/master/gmod-server.sh
chown +x gmod-server.sh

curl -sSL -o steamcmd.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz

mkdir steamcmd
mkdir serverfiles
tar -xzvf steamcmd.tar.gz -C steamcmd

./steamcmd/steamcmd.sh +login anonymous +force_install_dir ../serverfiles +app_update 4020 validate +quit

mkdir .steam/sdk32
cp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so

mkdir config
cd config
wget https://raw.githubusercontent.com/Rudelle65/LinuxGmod/master/server.cfg
cd ..

echo "Your server has been installed!"
exit
