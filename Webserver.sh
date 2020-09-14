#!/bin/bash
echo "#########################################"
echo "#         LEMP install Script           #"
echo "# Github https://github.com/Resolv-Conf #"
echo "# Website https://sessiontech.net       #"
echo "#########################################"
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

echo "LEMP"

dpkg -s nginx &> /dev/null
dpkg -s mysql-server &> /dev/null
dpkg -s php7.4 &> /dev/null

REQUIRED_PKG="nginx-common"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG 
fi
sleep 10s

REQUIRED_PKG="software-properties-common"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG 
fi
sleep 10s

REQUIRED_PKG="mysql-server"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG 
fi
sleep 10s

sudo add-apt-repository ppa:ondrej/php

REQUIRED_PKG="php7.4 libapache2-mod-php7.4 php7.4-cli php7.4-mysql php7.4-gd php7.4-imagick php7.4-recode php7.4-tidy php7.4-xmlrpc"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG 
fi
sleep 10s

REQUIRED_PKG=:"certbot"
PKG_OK=$(dpkg-query -W --showfprmat='${Status}\n' $REQUIRED_PKG|grep "installed ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG 
fi
sleep 10s

echo "LEMP Is now installed"
exit