#!/bin/bash

clear

echo "What do you want?"
PS3='Please choose: '
options=("Installer" "Generator" "Quit")
select opt in "${options[@]}"; do
case "$opt,$REPLY" in
Installer,*|*,Installer) 
echo "";
echo "1) Installer Selected";
sleep 2
termux-setup-storage
echo "y" | pkg update >/dev/null 2>&1
echo "y" | pkg upgrade >/dev/null 2>&1
pkg install python -y >/dev/null 2>&1
pkg install wireguard-tools -y >/dev/null 2>&1
pkg install git -y >/dev/null 2>&1
pkg install wget -y >/dev/null 2>&1
pip install requests >/dev/null 2>&1
cd storage/shared
mkdir -p WireGuard
clear
echo "Installing package done"

echo "";
break ;;
Generator,*|*,Generator) 
echo "";
echo "2) Generator Selected";
sleep 2
RED='\033[01;31m';
RESET='\033[0m';
GREEN='\033[01;32m';
clear
c1=$(tr -dc '[:alpha:]' </dev/urandom 2>/dev/null | head -c6)
cd storage/shared
rm -rf *.py *.json
cd WireGuard
echo ""
echo ""
echo ""
echo -e "$GREEN          Initializing... $RESET"
wget https://raw.githubusercontent.com/omayanrey/pisovpn/master/bj.py >/dev/null 2>&1
python bj.py >/dev/null 2>&1
clear
echo ""
echo ""
echo ""
echo -e "$GREEN          Installing please wait... $RESET"
sleep 1
echo -e "$GREEN          Configuring setup... $RESET"
sleep 1
mv client.conf BJAY-$c1.conf
rm -rf *.py *.json
clear
echo ""
echo ""
echo ""
echo -e "$GREEN          Success! $RESET"
echo ""
sleep 1
echo -e "$GREEN          BJAY-$c1.conf has been generated.$RESET"
echo ""
echo "";
break ;;

Quit,*|*,Quit) echo "Installation Cancelled!!";
echo -e "\e[1;31mRebuild your vps and correct the process.\e[0m";
exit;
break ;; *)
echo Invalid: Choose a proper Plan;;
esac
done

cd
rm -rf *.sh
exit 1
