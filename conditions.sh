#!/bin/bash

echo -e "\n The program continues" 

read -p "Say something to greet me! " hello
echo "--------------------------------------"

if [ "$hello" == "hello" ]; then
    echo "Hello to you!"

elif [ "$hello" == "good morning" ]; then
    echo "Good morning to you"

elif [ "$hello" == "bye" ]; then
    echo "bye to you"

else
    echo "Have a nice day anyway"
fi

#IF ---> Strings

#String empty - z

if [ -z "$hello" ]; then
    echo "Empty String"
fi

#NON empty string -n

if [ -n "$hello" ]; then
    echo "---NON--- Empty String"
fi

#Negation ----> !

if [ "$hello" != "hello" ]; then
    echo "Not hello :("
fi

if [ ! -z "$hello" ]; then
    echo "NOT EMPTY"
fi