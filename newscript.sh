#!/bin/bash

echo "----------Generate new script----------"

#Function to get a filename if one is not provided. Exits the script on q.

get_filename() {

    while true; do

        read -p "Enter a filename: " myfile

        if [[ "$myfile" == *".sh" ]]; then
            break

        elif [[ "$myfile" == [Qq] ]]; then
            exit 0

        else
            echo "Please enter a valid filename ending in .sh. [q Quits]."
        fi

    done
}

#Checks that the provided name is valid, and asks to get the filename if it isn't.

if [ "$1" ]; then

    if [[ "$1" == *".sh" ]]; then
        myfile="$1"

    else
        echo "Please provide a valid filename ending in .sh. [q Quits]."
        get_filename
    fi

else
    get_filename
fi


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