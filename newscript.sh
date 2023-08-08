#!/bin/bash

echo "----------Generate new script----------"

#Keep asking for the filename until a valid one is given, or exit the script

while true; do

	read -p "Enter a filename: " myfile

	if [[ "$myfile" == *".sh" ]]; then
		break

	elif [[ "$myfile" == "q" ]]; then
		exit 0

	else
		echo "Please enter a valid filename ending in .sh. q Quits."

	fi

done

#Add shebang to script and set permission to executable
#It's my script I'll dev null if I want to

echo "#!/bin/bash" > "$myfile" 2> /dev/null
chmod +x "$myfile"

#Check that file is executable, and if so, launch the script in Sublime

if [[ -x "$myfile" ]]; then
	echo "New script file '$myfile' has been created and is now executable."
	subl "$myfile"

else
	echo "There was a problem creating the new file."

fi