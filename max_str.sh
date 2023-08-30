#!/bin/bash

echo "------ Max String Script ------"

file_name=$1

# Check if the user provided an output file name as an argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <output_file_name>"
  exit 1
  
fi

# Only run through the script if the file is readable
if [ -r "$file_name" ]; then
	string=$(strings "$file_name")

	ref_word=''
	max_length=0

	for i in $string; do
		# length=$(echo "$i" | wc -c)
		# length=$((length - 1))

		length=${#i}

		#echo "$i ---> $length"

		if [ $length -gt $max_length ]; then
			ref_word=$i
			max_length=$length

		fi
	done

else
	echo "File not readable or doesn't exist"

fi

echo "Max length is $max_length"
echo "Longest word is $ref_word"
