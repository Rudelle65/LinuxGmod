#!/bin/bash

# ----------------------------------#
#  Script développer par Rudelle65  #
# ----------------------------------#

sudo apt-get -y update
sudo apt-get -y install screen lib32gcc1 wget curl ca-certificates

wget https://raw.githubusercontent.com/Rudelle65/LinuxGmod/master/gmod-server.sh
chown +x gmod-server.sh

mkdir steamcmd
curl -sSL -o steamcmd.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz
tar -xzvf steamcmd.tar.gz -C steamcmd
chmod +x steamcmd

mkdir serverfiles
chmod +x serverfiles
bash steamcmd/steamcmd.sh +login anonymous +force_install_dir ../serverfiles +app_update 4020 validate +quit

mkdir .steam/sdk32
chmod +x .steam
cp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so

mkdir config
chmod +x config
wget https://raw.githubusercontent.com/Rudelle65/LinuxGmod/master/server.cfg
mv server.cfg /config/server.cfg

echo "Your server has been installed!"
exit
