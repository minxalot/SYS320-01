#!/bin/bash

input="report.txt"
output="/var/www/html/report.html"

{
	echo "<!DOCTYPE html>"
	echo "<html>"
	echo "<head>"
		echo "<title>IOC Report</title>"
		echo "<style>th, td { border: 1px solid #000000; }</style>"
	echo "</head>"
	echo "<body>"
	echo "<table>"
} > "$output"

{
	while read -r ip timestamp page; do
		echo "<tr>"
		echo "<td>$ip</td>"
		echo "<td>$timestamp</td>"
		echo "<td>$page</td>"
	done < report.txt
} >> "$output"

{
	echo "</table>"
	echo "</body>"
	echo "</html>"
} >> "$output"
