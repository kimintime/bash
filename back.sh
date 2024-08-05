#!/bin/bash

#Param for number of directories to move back and count of directories
max="$1"; 
count=0

#Loop through the number of moves and cd for each one
for (( i= 0; i < max; i++ )); do
	((count=count+1))
	cd ../
done

#Show how many directories moved and current directory
echo "Moving back $count directories"
echo "Present Directory: $(pwd)"