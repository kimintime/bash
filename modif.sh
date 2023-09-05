#!/bin/bash

# Script to check how many files were modified per hour in a given directory

dir=$1

# Check if the user provided an output file name as an argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <output_directory_name"
  exit 1
  
fi

# Check that param is a directory
if [ ! -d $dir ]; then
	echo "Not a directory"
	exit
fi

# Use stat command to check when file was modified, check for OSTYPE for correct syntax
if [[ "$OSTYPE" == "linux-gnu" ]]; then

	#Linux syntax
	content=$( stat -c %y $dir/* | cut -c 12-13 )

elif [[ "$OSTYPE" == "darwin"* ]]; then

	#Mac syntax
	content=$(stat -f %Sm $dir/* | cut -c 08-09)

else
	echo "System not recognized."
fi

# Initialize array of hours that appear
for j in {0..23}; do
	hours[j]=0
done

# Count everytime an hour appears
for i in $content; do

	# Remove leading zeroes
	x=${i#0}

	(( hours[x]=${hours[x] +1} ))
done

echo -e "Hours \t Files \t\t Hours \t Files"
echo -e "----- \t ----- \t\t ----- \t -----"

for k in {0..11}; do

	#Parse the results into AM/PM
	m=$(( $k + 12 ))
	echo -e "$k \t ${hours[k]} \t\t $m \t ${hours[m]}"
done





