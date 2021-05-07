#!/bin/bash
# everything.sh
# Store menu options selected by the user
echo 'export NCURSES_NO_UTF8_ACS=1' >> ~/.bashrc

sudo apt-get -qq -y install dialog

INPUT=/tmp/menu.sh.$$

# Storage file for displaying cal and date command output
OUTPUT=/tmp/output.sh.$$

# get text editor or fall back to vi_editor
vi_editor=${EDITOR-vi}

# trap and delete temp files
trap "rm $OUTPUT; rm $INPUT; exit" SIGHUP SIGINT SIGTERM

#
# Purpose - display output using msgbox 
#  $1 -> set msgbox height
#  $2 -> set msgbox width
#  $3 -> set msgbox title
#
function Wireguard(){
	. bash <(wget -q -O - https://wireguard.sh/wireguard.sh)

}
#
# Purpose - display current system date & time
#
function Harden(){
	. bash <(wget -q -O - https://harden.sh/harden.sh)
}
#
# Purpose - display a calendar
#
function xRDP(){
	. bash <(wget -q -O - https://xRDP.sh/xrdp.sh)
}
#
# set infinite loop
#
while true
do

### display main menu ###
dialog --clear  --backtitle "Mega awesome collection of everything bash" \
--title "everything.sh Main Menu" \
--menu "Please select an option below." 15 50 4 \
Wireguard "Install Wireguard VPN" \
Harden "Harden a newly installed Linux OS" \
xRDP "Install RDP features" \
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion 
case $menuitem in
	DWireguard) Wireguard;;
	Harden) Harden;;
	xRDP) xRDP;;
	Exit) clear; echo "Bye"; break;;
esac

done

# if temp files found, delete em
[ -f $OUTPUT ] && rm $OUTPUT
[ -f $INPUT ] && rm $INPUT
