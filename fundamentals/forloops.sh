#!/bin/bash

echo "Hello"

for i in {1,2,3,4}; do
	echo -e "hi there\n--------------------\n"
	echo "The value of i is: 	$i"

done

for i in {a,b,c,d}; do
	echo "The value of i is: 	$i"

done

echo "-----------------------------"

if ! [ -d ../testfiles ]; then
	mkdir ../testfiles

fi

for i in {21,"my cat",1,2,"hello","END"}; do
	echo "The value of i is: 	$i"
	touch "../testfiles/${i}.xls"

done

echo "-----------------------------"

#Brace expansion
for i in {b..f}{1..3}; do
	echo "The value of i is:	$i"

done

echo "-----------------------------"

#Break
for i in {21,"my cat",1,"BAD",2,"hello","END"}; do
	echo "The value of i is: 	$i"

	if [ "$i" == "BAD" ]; then
		echo "**********BREAKING OUT OF THE LOOP***********"
		break
	fi

done

#Files
echo "-----------------------------"

for i in ../testfiles/* ; do
	echo "The file is:	$i"

done

echo "-----------------------------"

#Modern syntax for loop with numbers
for (( i = 0; i < 25; i = i + 3 )); do
	echo " $i "

done



























