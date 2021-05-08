#!/bin/bash
# everything.sh
# Store menu options selected by the user

# trap ctrl-c and call ctrl_c()
# capture CTRL+C, CTRL+Z and quit singles using the trap

function ctrl_c() {
        dialog --title "Confirmation" --yesno "Are you sure to exit?" 10 40

		#Get exit status
		# 0 means user hit [yes] button.
		# 1 means user hit [no] button.
		# 255 means user hit [Esc] key.
		response=$?
		case $response in
			0) clear; echo "Thanks for using everything.sh"; exit;;
			1) ;;
			255) ;;
		esac
}

#trap 'ctrl_c' SIGINT SIGQUIT SIGTSTP
trap "ctrl_c" 2

echo 'export NCURSES_NO_UTF8_ACS=1' >> ~/.bashrc
export NCURSES_NO_UTF8_ACS=1

sudo apt-get -qq -y install dialog

INPUT=/tmp/menu.sh.$$
# Storage file for displaying cal and date command output
OUTPUT=/tmp/output.sh.$$

# trap and delete temp files
#trap "rm $OUTPUT; rm $INPUT; exit" SIGHUP SIGINT SIGTERM

#
# Purpose - display output using msgbox 
#  $1 -> set msgbox height
#  $2 -> set msgbox width
#  $3 -> set msgbox title
#
function runBenchmark(){
	#
	# set infinite loop
	#
	while true
	do

		### display main menu ###
		dialog --backtitle "Benchmark" \
		--title "Main Menu" \
		--menu "Please select an option below." 15 50 4 \
		USA "Benchmark & The US Speedtest" \
		Europe "Benchmark & Europe Speedtest" \
		MiddleEast  "Benchmark & Middle East Speedtest" \
		India "IBenchmark & India Speedtest" \
		Asia "Benchmark & Asia Speedtest" \
		Australia "Benchmark & Australia Speedtest" \
		SouthAmerica "Benchmark & South America Speedtest" \
		Exit "Exit to the shell" 2>"${INPUT}"

		menuitem=$(<"${INPUT}")


		# make decsion 
		case $menuitem in
			USA) runUSA;;
			Europe) runEurope;;
			MiddleEast) runMiddleEast;;
			India) runIndia;
			Asia) runAsia;;
			Australia) runAustralia;;
			SouthAmerica) runSouthAmerica;;
			Exit) clear; echo "Thanks for using everything.sh"; break;;
		esac										

	done

}
function runUSA(){
	curl -LsO bench.monster/speedtest.sh; bash speedtest.sh -us
	read -n 1 -s -r -p "Press any key to continue"

}
}
function runEurope(){
	curl -LsO bench.monster/speedtest.sh; bash speedtest.sh -eu
	read -n 1 -s -r -p "Press any key to continue"

}
}
function runMiddleEast(){
	curl -LsO bench.monster/speedtest.sh; bash speedtest.sh -me
	read -n 1 -s -r -p "Press any key to continue"

}
}
function runIndia(){
	curl -LsO bench.monster/speedtest.sh; bash speedtest.sh -in
	read -n 1 -s -r -p "Press any key to continue"

}
}
function runAsia(){
	curl -LsO bench.monster/speedtest.sh; bash speedtest.sh -asia
	read -n 1 -s -r -p "Press any key to continue"

}
}
function runAustralia(){
	curl -LsO bench.monster/speedtest.sh; bash speedtest.sh -au
	read -n 1 -s -r -p "Press any key to continue"

}
}
function runSouthAmerica(){
	curl -LsO bench.monster/speedtest.sh; bash speedtest.sh -sa
	read -n 1 -s -r -p "Press any key to continue"

}
}
function runUSA(){
	curl -LsO bench.monster/speedtest.sh; bash speedtest.sh
	read -n 1 -s -r -p "Press any key to continue"

}
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
	Benchmark "Perform a Benchmark test" \
	Harden "Harden a newly installed Linux OS" \
	RDP "Install Remote Desktop (xRDP)" \
	Wireguard "Install Wireguard VPN" \
	Exit "Exit to the shell" 2>"${INPUT}"

	menuitem=$(<"${INPUT}")


	# make decsion 
	case $menuitem in
		Benchmark) runBenchmark;;
		Harden) runHarden;;
		RDP) runRDP;;
		Wireguard) runWireguard;;
		Exit) clear; echo "Thanks for using everything.sh"; break;;
	esac

done

