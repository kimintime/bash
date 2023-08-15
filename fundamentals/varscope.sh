#!/bin/bash

myfunction(){

	local var1="Eggs"
	var2="Salad"

	echo "My variable inside the function is: $var1"
}

echo "Start the program"

myfunction

#Variables are global if not specified as local

echo "Outside: $var1"
echo "Outside: $var2"