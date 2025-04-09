#! /bin/bash

authfile="/var/log/auth.log"

function getLogins(){
}

# function getFailedLogins
# todo 1
# complete the function
# generate failed logins and test

echo "To:lindsey.bellaire@mymail.champlain.edu" > emailform.txt
echo "Subject: Security incident" >> emailform.txt
echo "Test" >> emailform.txt

cat emailform.txt | ssmtp lindsey.bellaire@mymail.champlain.edu

# todo 2
# send failed logins as an email to yourself
# similar to sending logins as email
