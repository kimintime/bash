#!/bin/bash

echo "******** Test Script ********"

x="aa bb cc dd"

#Space is the Internal Field Seperator 

for i in $x; do
	echo $i
done

echo "---- Changing IFS ----"

old_IFS=$IFS

IFS="_"
echo "Value of IFS: $IFS"

x="aa_bb_cc_dd"

for i in $x; do
	echo $i
done

read a b c d f <<< "hi_there_how_are_you"

echo "a is $a"
echo "b is $b"
echo "c is $c"
echo "d is $d"
echo "f is $f"

IFS=$old_IFS
echo "Value of IFS: $IFS"
