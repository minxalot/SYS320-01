#!/bin/bash

url=10.0.17.6/IOC.html
fullPage=$(curl -s "$url")

echo "$fullPage" | grep -oP '(?<=<td>).*?(?=</td>)' | sed 'n;d' > IOC.txt
