#!/bin/bash

# Add to your $PATH to take advantage of using this script anywhere in your terminal.
# For example:

# pico ~/.zshrc // This depends on what shell you use, you may need to look this up for yourself.

# export PATH="$PATH:$HOME/bin" // Assumes you save your scripts to $HOME/bin. Edit this to reflect where the script is.
# alias publish='repo.sh'

# source ~/.zshrc or close and reopen terminal for changes to take effect

echo "-----------Publish Commits------------"

#Adds a new remote. Checks first that there is a remote name and a valid remote address, and keeps asking unless q exits the function.
newaddress() {
    while true; do
        local remote_address

        read -p "Enter a name for the repo (or 'q' to quit): " remote_name

        if [[ "$remote_name" == [Qq] ]]; then
            echo "New remote not saved. Continuing..."
            break

        elif [[ "$remote_name" ]]; then
            read -p "Enter an address for the new remote (or 'q' to quit): " remote_address

            if [[ "$remote_address" == [Qq] ]]; then
                echo "New remote not saved. Continuing..."
                break

            elif [[ "$remote_address" == *.git ]]; then
                git remote add "$remote_name" "$remote_address"
                break

            else
                echo "Invalid remote address. [q Continues without saving]"
            fi
        else
            echo "Please enter a remote name or 'q' to continue without saving."
        fi
    done
}

#Chooses from list of current remotes
choose_remote() {

    echo "---------Choose Remote--------"
    local existing_remote
    git remote

    read -p "Enter the name of an existing remote [q to continue without saving]:  " existing_remote

    if [[ "$existing_remote" == [Qq] ]]; then
        echo "Continuing with default..."

    else
        remote_name="$existing_remote"
    fi
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

        #Create remote if needed, or choose from list of remotes
        read -p "Add a new remote, or choose from an existing remote: [n to enter address, c to choose from list] " remote_option

        if [[ "$remote_option" == [Nn] ]]; then
            newaddress

        elif [[ "$remote_option" == [Cc] ]]; then
            choose_remote
        fi

        #Stage changes and publish repo, then exit the script.
        git add .
        echo "Changes staged."


        read -p "Enter commit message: " commit_message

        git commit -m "$commit_message"

        read -p "Enter branch name: " branch_name

        #Uses the remote name if it was added
        if [[ "$remote_name" ]]; then
            git push "$remote_name" "$branch_name"

        else
            git push origin "$branch_name"
        fi
            
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



