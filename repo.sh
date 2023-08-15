#!/bin/bash

echo "-----------Publish Commits------------"

while true; do

    # Initialize the repository if needed
    read -p "Publish repo? [y/n] " option

    if [[ "$option" == "y" ]]; then

        if ! [ -d .git ]; then
            git init
            echo "The repo is now initialized"

        fi

        #Initialize gitignore if needed
        if ! [ -e .gitignore ]; then
            touch .gitignore
        fi

        if [ ! -s .gitignore ]; then
            echo -e "# General\n.DS_Store\n.AppleDouble" > .gitignore
            echo "gitignore successfully generated"

        fi

        #Create remote if needed
        read -p "Does remote exist? [n to enter address] " option

        if [ "$option" == "n" ]; then
            read -p "Enter an address for the repo: " repo_address

            git remote add origin "$repo_address"

        fi

        #Stage changes and publish repo
        git add .
        echo "Changes staged."


        read -p "Enter commit message: " commit_message

        git commit -m "$commit_message"

        read -p "Enter branch name: " branch_name

        git push origin "$branch_name"
        echo "Commit published successfully"
        exit 0

    #Cancels creating any git files or publishing the repo
    elif [[ "$option" == "n" ]]; then
        echo "Publishing repo canceled."
        exit 0

    else
        echo "Please enter [y/n]"
    fi
done



