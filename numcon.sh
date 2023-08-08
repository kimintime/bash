#!/bin/bash

read -p "Give me a number " number
echo "-----------------------------"

#Equal -eq
if [ $number -eq 18 ]; then
	echo "It is 18"

else
	echo "not 18"

fi

#Not Equal -ne
if [ $number -ne 18 ]; then
	echo "It is NOT 18"

fi

#Less than -lt
if [ $number -lt 18 ]; then
	echo "Less than 18"

fi

#Greater than -gt
if [ $number -gt 18 ]; then
	echo "Greater than 18"

fi

#Less than or Equal to -le
if [ $number -le 18 ]; then
	echo "Less than or equal to 18"

fi

#Greater than or Equal to -ge
if [ $number -ge 18 ]; then
	echo "Greater than or equal to 18"

fi
