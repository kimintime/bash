#!/bin/bash

FILE=/etc/passwd

read -p "Enter the username: " user_name

info=$(grep "$user_name" $FILE)

echo "$info"

old_IFS=$IFS
IFS=$:

if [ -n "$info" ]; then
	read user pw uid gid full home shell <<< "$info"

	echo "User is: $user"
	echo "Password: $pw"
	echo "uid: $uid"
	echo "gid: $gid"
	echo "Name: $full"
	echo "Home: $home"
	echo "Shell: $shell"

else
	echo "User not found."
fi

IFS=$old_IFS




