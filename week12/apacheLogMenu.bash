#! /bin/bash

logFile="/var/log/apache2/access.log.1"

function displayAllLogs() {
	cat "$logFile"
}

function displayOnlyIPs() {
	cat "$logFile" | cut -d' ' -f 1 | sort -n | uniq -c
}

#function: displayOnlyPages
# like displayOnlyIPS - but only pages

function histogram () {
	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '[' | sort \
	 | uniq)
	# This is for debugging, print here to see what it does to continue:
	# echo "$visitsPerDay"
	:> newtemp.txt
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 \
		 cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d " " -f 1)

		local newLine ="$IP $withoutHours"
		echo "$IP $withoutHours" >> newtemp.txt
	done
	cat "newtemp.txt" | sort -n | uniq -c
}

# function: frequentVisitors:
# Only display IPs that have more than 10 visits
# You can either call histogram and process the results,
# or make a whole new function. Do not forget to separate the 
# number and check with a condition whether it's greater than 10
# The output should be almost identical to histogram,
# only with daily number of visits that are greater than 10.

# function: suspiciousVisitors
# Manually make a list of indicators of attack (ioc.txt)
# Filter the records with these indicators of attack
# Only display the unique count of IP addresses.
# Hint: there are examples in slides

# Keep in mind that I have selected a long way of doing things to
# demonstrate loops, functions, etc. If you can do things simpler,
# it is welcomed.

while :
do
	echo "Please select an option:"
	echo "[1] Display all logs"
	echo "[2] Display only IPs"
	echo "[3] Display only pages visited"
	echo "[4] Histogram"
	echo "[5] Frequent visitors"
	echo "[6] Suspicious visitors"
	echo "[7] Quit"

	read userInput

	case $userInput in

		7)
			echo "Quitting..."
			exit 1
			;;
		1)
			echo "Displaying all logs:"
			displayAllLogs
			;;
		2)
			echo "Displaying only IPs:"
			displayOnlyIPs
			;;
		3)
			echo "Displaying only pages visited:"
			# add this
			;;
		4)
			echo "Displaying histogram:"
			histogram
			;;
		5)
			echo "Displaying frequent visitors:"
			# add this
			;;
		6)
			echo "Displaying suspicious visitors:"
			# add this
			;;
		*)
			echo "nuh uh"
			;;
	esac
done
