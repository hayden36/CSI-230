#!/bin/bash

logFile=$1
iocFile=$2

if [[ $# != 2 ]]; then
	echo "Please provide a log file and an IOC file."
	exit 1;
fi

logs=$(cat "$logFile"  | cut -d " " -f 1,4,7 | tr -d '[' | grep -e -i -f $2)
echo "$logs" > report.txt