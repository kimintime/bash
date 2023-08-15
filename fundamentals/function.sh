#!/bin/bash

mydate(){

	echo "Today is: "
	date

	echo "Have a nice day!"
}

#With input

hello2(){

	echo "hello $1"
	echo "hello also to $2"

	return 35
}

echo "Start here"

mydate

echo "------------------------"

hello2 "Mark" "Bob Loblaw"

echo "return value of my function is $?"

echo "move on..."
