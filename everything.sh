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
function runWireguard(){
	bash <(wget -q -O - https://wireguard.sh/wireguard.sh)

}
#
# Purpose - display current system date & time
#
function runHarden(){
	bash <(wget -q -O - https://harden.sh/harden.sh)
}
#
# Purpose - display a calendar
#
function runRDP(){
	bash <(wget -q -O - https://xRDP.sh/xrdp.sh)
}
#
# set infinite loop
#
while true
do

### display main menu ###
dialog --backtitle "Mega awesome collection of everything.sh bash" \
--title "Main Menu" \
--menu "Please select an option below." 15 50 4 \
Wireguard "Install Wireguard VPN" \
Harden "Harden a newly installed Linux OS" \
RDP "Install Remote Desktop (xRDP)" \
Exit "Exit to the shell" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion 
case $menuitem in
	Wireguard) runWireguard;;
	Harden) runHarden;;
	RDP) runRDP;;
	Exit) clear; echo "Thanks for using everything.sh"; break;;
esac

done

# if temp files found, delete em
[ -f $OUTPUT ] && rm $OUTPUT
[ -f $INPUT ] && rm $INPUT
