echo "To:lindsey.bellaire@mymail.champlain.edu" > emailform.txt
echo "Subject: Security incident" >> emailform.txt
echo "Test" >> emailform.txt

cat emailform.txt | ssmtp lindsey.bellaire@mymail.champlain.edu
