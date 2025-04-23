#!/bin/bash

pageContent=$(curl -s "10.0.17.6/Assignment.html")

times=$(
echo "$pageContent" | \
xmlstarlet select --html --recover --template --match '(//table)[1]/tr[position()>1]' --value-of 'td[2]
)

pressures=$(
)

temps=$(
echo "$pageContent" | \
xmlstarlet select --html --recover --template --match '(//table)[1]/tr[position()>1]' --value-of 'td[1]' --nl
)
