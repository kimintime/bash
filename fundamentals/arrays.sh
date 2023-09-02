#!/bin/bash

# Arrays

# a[0]="ball"
# a[1]="one glass"
# a[2]=22
# a[3]="a pencil"

# echo ${a[0]}

# echo ${a[3]}

# echo ${a[2]}

days=(mon tue wed thu fri)

# echo ${days[0]}

# echo ${days[3]}

for i in {0..4}; do
	echo "Element $i is ${days[i]}"
done

# Access all parameters

echo ${days[@]}

for element in "${days[@]}"; do
	echo "Our item is $element"
done

# Number of elements inside an array
b=(10 20 30 "hello")

echo ${#b[@]}

echo ${b[3]}

# What indexes are filled
echo ${!b[@]}

# Append elements to an array
b+=(90 and END)

echo ${b[@]}












