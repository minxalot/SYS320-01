#!bin/bash

file="/var/log/apache2/access.log"
allLogs=""

function getAllLogs() {
	allLogs=$(cat "$file" | grep "GET /page2.html" | cut -d' ' -f1,7)
}

function pageCount() {
	cut -d' ' -f7 "$file"| sort | uniq -c | sort -nr
}

echo "Before function:"
echo "$allLogs"

getAllLogs

echo "After function:"
echo "$allLogs"

echo "Counts:"
pageCount
