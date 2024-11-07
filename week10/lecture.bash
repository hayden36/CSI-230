#!/bin/bash

file="/var/log/apache2/access.log"
allLogs=""

#results=$(cat "$file" | grep -i "page2.html" | cut -d ' ' -f 1,7 | tr -d "[")
#echo "$results"

function getAllLogs() {
	allLogs=$(cat "$file" | cut -d ' ' -f 1,4,7 | tr -d "[")
}

function ips() {
	ipsAccessed=$(echo "$allLogs" | cut -d ' ' -f1)
}

function getPageCount() { 
	allLogs=$(cat "$file" | cut -d ' ' -f 7 | tr -d "[" | sort | uniq -c)
}

#getAllLogs
#ips
#echo "$ipsAccessed" 

#getPageCount
#echo "$allLogs"


function countCurlAccess() {
	allLogs=$(cat "$file" | grep -i "curl" | cut -d ' ' -f 1,12 | tr -d "[" | sort | uniq -c) 	
}
countCurlAccess
echo "$allLogs"

