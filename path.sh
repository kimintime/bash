#!/bin/bash

# Displays echo $PATH in a more readable way. 
# add -c <comment> to search for files in the PATH
# add -d <comment> to search directories in the PATH

old_IFS="$IFS"
IFS=":"

# Check if directory is present in PATH
if [[ "$1" == "-d" ]]; then
	dir="$2"

	for i in $PATH; do
		if [[ "$dir" == "$i" || "$dir" == "$i/" ]]; then
			echo "*** Directory Found ***"
		fi
	done
fi

# Check if command is present in PATH. Unlike which command, this shows all instances.
if [[ "$1" == "-c" ]]; then
	comment="$2"

	for i in $PATH; do
		if [[ -e "$i/$comment" ]]; then
			echo "*** File present in PATH ***"
			echo $i/$comment
		fi
	done
fi

# Only list the entire PATH if no comment given
if [[ "$1" == "" ]]; then
	for i in $PATH; do
		echo "$i"
	done
fi

IFS="$old_IFS"