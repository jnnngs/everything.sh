#!/bin/bash
# everything.sh
# Store menu options selected by the user

# trap ctrl-c and call ctrl_c()
# capture CTRL+C, CTRL+Z and quit singles using the trap

function ctrl_c() {
        dialog --title "Confirmation" --yesno "Are you sure to exit?" 10 40

		menuitem=$(<"${INPUT}")

		# make decsion 
		case $menuitem in
			yes) exit;;
			no) ;;
		esac
}
#trap 'ctrl_c' SIGINT SIGQUIT SIGTSTP
trap "ctrl_c" 2

echo 'export NCURSES_NO_UTF8_ACS=1' >> ~/.bashrc

sudo apt-get -qq -y install dialog

# get text editor or fall back to vi_editor
vi_editor=${EDITOR-vi}

#
# Purpose - display output using msgbox 
#  $1 -> set msgbox height
#  $2 -> set msgbox width
#  $3 -> set msgbox title
#
function runWireguard(){
	bash <(wget -q -O - https://wireguard.sh/wireguard.sh)
	read -n 1 -s -r -p "Press any key to continue"

}
#
# Purpose - display current system date & time
#
function runHarden(){
	bash <(wget -q -O - https://harden.sh/harden.sh)
	read -n 1 -s -r -p "Press any key to continue"
}
#
# Purpose - display a calendar
#
function runRDP(){
	bash <(wget -q -O - https://xRDP.sh/xrdp.sh)
	read -n 1 -s -r -p "Press any key to continue"
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
	Exit) trap - SIGINT SIGQUIT SIGTSTP;clear; echo "Thanks for using everything.sh"; break;;
esac

done

