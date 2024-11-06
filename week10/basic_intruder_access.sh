#!/bin/bash

for i in {1..20}
	do
		curl 10.0.17.24
		curl 10.0.17.24/page1.html
		curl 10.0.17.24/page2.html
	done
	
