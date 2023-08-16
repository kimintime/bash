#!/bin/bash

echo "***********************************"

echo "This is paramenter 1: $1"
echo "This is paramenter 2: $2"

#Shift - shifts parameter by 1, can add the number to shift
shift 3

echo "This is paramenter 1: $1"
echo "This is paramenter 2: $2"
echo "This is paramenter 3: $3"
echo "This is paramenter 4: $4"
echo "This is paramenter 5: $5"
echo "This is paramenter 6: $6"

#Double digit number parameters

echo "This is paramenter 12: ${12}"

#How many parameters

echo " This is the number of parameters: $# "

#Access all parameters

echo "All parameters: $@"

echo "***********************************"


for i in $@; do
	echo "$i"
done

echo "***********************************"

# "$@" is different from "$*" - "$*" is considered just one element

for i in "$*"; do
	echo "$i"
done

echo "***********************************"

#Absolute path to script
echo "$0"






