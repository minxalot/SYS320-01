#!/bin/bash

> "report.txt"

# echo "$1"
# echo "$2"

logFile="$1"
iocFile="$2"

while read -r logLine; do
	while read -r ioc; do
		if echo "$logLine" | grep -q "$ioc"; then
			ip=$(echo "$logLine" | cut -d' ' -f1)
			timestamp=$(echo "$logLine" | cut -d' ' -f4 | tr -d '[]')
			page=$(echo "logLine" | cut -d' ' -f7)
			echo "$ip $timestamp $page" >> report.txt
		fi
	done < "$iocFile"
done < "$logFile"
