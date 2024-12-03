#!/bin/bash


htmlStart="""
<!DOCTYPE html>
<html>
	<head>
		<title>Challenge 3</title>
	</head>
<body>
	<table>
		<tr>
			<th>IP</th>
			<th>Date &amp; Time</th>
			<th>Page</th>
		</tr>

"""

htmlEnd="""
		</table>
	</body>
</html>
<style>
th, td, table {
	border: 1px solid black;
	border-collapse: collapse;
}
th, td {
	padding: 5px;
}
</style>
"""
touch report.html

echo "$htmlStart" > report.html

cat report.txt | while read -r line;
do
	ip=$(echo "$line" | cut -d " " -f 1)
	date=$(echo "$line" | cut -d " " -f 2)
	page=$(echo "$line" | cut -d " " -f 3)
	tablebody="""
	<tr>
		<td>$ip</td>
		<td>$date</td>
		<td>$page</td>
	</tr>
	""" 
	echo "$tablebody" >> report.html
done

echo "$htmlEnd" >> report.html
mv report.html /var/www/html/report.html

if [[ $? -ne 0 ]]; then
	echo "Unable to move the file to /var/www/html. Please manually move or try running as root."
	exit 1;
fi
