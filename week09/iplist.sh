#!/bin/bash

# Usage: ./iplist.sh 10.0.17
if [ $# -lt 1 ]; then 
	echo "Usage: $0 <prefix>"
	exit 1
fi

prefix=$1
if [[ ${#1} -lt 5 ]]; then
	printf "Prefix length too short.\nExample: 192.168.1\n"
	exit 1
fi

for i in {1..254}
	do
		echo "$1.$i"
	done
