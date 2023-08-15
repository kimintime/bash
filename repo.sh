#!/bin/bash

# Add to your $PATH to take advantage of using this script anywhere in your terminal.
# For example:

# pico ~/.zshrc // This depends on what shell you use, you may need to look this up for yourself.

# export PATH="$PATH:$HOME/bin" // Assumes you save your scripts to $HOME/bin. Edit this to reflect where the script is.
# alias publish='repo.sh'

# source ~/.zshrc or close and reopen terminal for changes to take effect

echo "-----------Publish Commits------------"

newaddress() {

    while true; do
        local remote_name
        local remote_address
        local exit_option

        read -p "Enter an address for the repo: " remote_address
        read -p "Enter a name for the new remote: " remote_name

        if [[ "$remote_name" && "$remote_address" == "*.git" ]]; then
            git remote add "$remote_name" "$remote_address"

        elif [[ "$exit_option" == [Qq] ]]; then
            echo "New remote not saved. Continuing..."
            break

        else
            read -p "Please enter a remote name and remote address. [q Continues without saving]" exit_option
        fi

    done

}

while true; do

    # Initialize the repository if needed. n Exits the script. Any other letter asks again until y/n is entered.
    read -p "Publish repo? [y/n] " publish_option

    if [[ "$publish_option" == [Yy] ]]; then

        if ! [ -d .git ]; then
            git init
            echo "The repo is now initialized"

        fi

        #Initialize gitignore if needed
        if ! [ -e .gitignore ]; then
            touch .gitignore
        fi

        #Adds my default gitignore content, edit for your needs.
        if [ ! -s .gitignore ]; then
            echo -e "# General\n.DS_Store\n.AppleDouble" > .gitignore
            echo "gitignore successfully generated"

        fi

        #Create remote if needed.
        read -p "Add remote? [y to enter address] " remote_option

        if [[ "$remote_option" == [Yy] ]]; then
            newaddress
        fi

        #Stage changes and publish repo, then exit the script.
        git add .
        echo "Changes staged."


        read -p "Enter commit message: " commit_message

        git commit -m "$commit_message"

        read -p "Enter branch name: " branch_name

        git push origin "$branch_name"
        echo "Commit published successfully"
        exit 0

    #Cancels creating any git files or publishing the repo, and exits the script without creating the repo.
    elif [[ "$publish_option" == [Nn] ]]; then
        echo "Publishing repo canceled."
        exit 0

    #Instructs the user to enter y/n before asking again to publish the repo?
    else
        echo "Please enter [y/n]"
    fi
done



