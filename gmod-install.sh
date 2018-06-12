#!/bin/bash

# ----------------------------------#
#  Script développer par Rudelle65  #
# ----------------------------------#

apt-get -y update
apt-get -y install screen lib32gcc1 wget curl ca-certificates dos2unix lib32stdc++6 lib32tinfo5

wget https://raw.githubusercontent.com/Rudelle65/LinuxGmod/master/gmod-server
dos2unix gmod-server
chmod -R +x gmod-server

mkdir steamcmd
cd steamcmd
curl -sSL -o steamcmd.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz
tar -xzvf steamcmd.tar.gz
cd ..
chmod -R +x steamcmd

mkdir serverfiles
cd steamcmd
./steamcmd.sh +login anonymous +force_install_dir ../serverfiles +app_update 4020 validate +quit
cd ..
chmod -R +x serverfiles

mkdir .steam
cd .steam
mkdir sdk32
cd ..
chmod -R +x .steam
cd steamcmd
cp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so
cd ..

cd serverfiles
mkdir config
chmod -R +x config
cd config
wget https://raw.githubusercontent.com/Rudelle65/LinuxGmod/master/server.cfg
cd ../..

echo "Your server has been installed!"
echo "Enter [./gmod-server start] to start the server."
exit
