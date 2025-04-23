#! /bin/bash

authfile="/var/log/auth.log"

function getLogins(){
	logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
	dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
	echo "$dateAndUser"
}

# function getFailedLogins
# todo 1
# complete the function
# generate failed logins and test

function getFailedLogins(){
	logline=$(cat "$authfile" | grep "authenticationfailure")
	dateAndUserFailed=$(echo "$logline" | cut -d' ' -f1,2,1,16 | sed 's/user=/ /')
	echo "$dateAndUserFailed"
}

echo "To:lindsey.bellaire@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
getLogins >> emailform.txt

cat emailform.txt | ssmtp lindsey.bellaire@mymail.champlain.edu

# todo 2
# send failed logins as an email to yourself
# similar to sending logins as email

echo "To:lindsey.bellaire@mymail.champlain.edu" > emailform1.txt
echo "Subject: Failed logins" >> emailform1.txt
getFailedLogins >> emailform1.txt

cat emailform1.txt | ssmtp lindsey.bellaire@mymail.champlain.edu
