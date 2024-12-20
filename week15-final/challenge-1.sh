#!/bin/bash

# This is the link we will scrape
link="10.0.17.6/IOC.html"

# get it with curl and tell curl not to give errors
fullPage=$(curl -sL "$link")

# Utilizing xmlstarlet tool to extract table from the page
toolOutput=$(echo "$fullPage" | \
	xmlstarlet format --html --recover 2>/dev/null | \
	xmlstarlet select --template --copy-of \
	"//html//body//table//tr//td[1]") # https://www.w3schools.com/xml/xpath_syntax.asp


# # Processing HTML with sed
# # 1- Replacing every </tr> with a line break
echo -n "$toolOutput"  | \
sed -e 's/<\/tr>/\n/g' | \
sed -e 's/<tr>//g' | \
sed -e 's/<td[^>]*>//g' | \
sed -e 's/<\/td>/;/g' | \
sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
sed -e 's/<[/\]\{0,1\}nobr>//g' | \
sed -e 's/;/\n/g' > IOC.txt