#!/bin/bash

#Logic Conditions

number=-7

#And condition -a
if [ $number -gt 3 -a $number -lt 10 ]; then
	echo " 3 > number < 10 "

fi

#OR condition -o
if [ $number -lt 3 -o $number -gt 10 ]; then
	echo " number < 3 OR number > 10"

fi


#Example file executable and not empty
myfile="hello.sh"

if [ -s "$myfile" -a -x "$myfile" ]; then
	echo " $myfile NON Empty AND executable "

fi

#---------------------------------------------
#Modern way to use IF conditions

number=3
echo "---------------------------------------"

if [[ $number -lt 10 && $number -gt 2 ]]; then
	echo " 2 < number < 10 "

fi

if [[ $number -lt 10 || $number -gt 20 ]]; then
	echo " number < 10 OR number > 20 "

fi

#Differences are the symbols for
#AND &&
#OR ||