#!/bin/bash

echo "To:lindsey.bellaire@mymail.champlain.edu" > fileaccesslog.txt
echo "Subject: Access" >> fileaccesslog.txt

currentTime=$(date '+%Y-%m-%d %H:%M:%S')

echo "File accessed at $currentTime" >> fileaccesslog.txt

cat fileaccesslog.txt | ssmtp lindsey.bellaire@mymail.champlain.edu
