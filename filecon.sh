#!/bin/bash

#IF with Files

read -p "Give me a filename " myfile
echo "------------------------------"

#If exists -e
if [ -e "$myfile" ]; then
	echo "The file exists"

else
	echo "Doesn't exist"

fi

#If Directory -d
if [ -d "$myfile" ]; then
	echo "The file exists and is a directory"

fi

#If Regular file (not directory, not link) -f
if [ -f "$myfile" ]; then
	echo "The file exists and is a regular file"

fi

#NOT Empty -s
if [ -s "$myfile" ]; then
	echo "The file exists and is not empty"

fi

#---------------------------------------------

#Readable
if [ -r "$myfile" ]; then
	echo "The file exists and is readable"

fi

#Writeable
if [ -w "$myfile" ]; then
	echo "The file exists and is writable"

fi

#Executable
if [ -x "$myfile" ]; then
	echo "The file exists and is executable"

fi

#-----------------------------------------------

#Negation - !

if [ ! -s "$myfile" ]; then
	echo "The file exists and has length = 0"

fi











