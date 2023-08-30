#!/bin/bash

# This script is intended to help generating the usual text needed in a cover letter. It assumes the following values need filling in:
#
# [today date]
# ----- Optional -----
# [employer name] 
# [company address]
# [postal code]
# [city]
# ----- Required -----
# [company name]
# [position]
# [job posting]
# [team]
# [vision]
#
# If your letter has Dear [employer name] and there is no [employer name], it's replaced with: To whom it may concern,.
# Write your cover letter template based on your needs, and use these values to be filled in by this script.
#
# Adjust the file names and their paths to suit your needs, for example, my template and saved files are markdown text,
# to be edited in iA Writer


# Function to check that required text is not empty
not_empty(){
  local var_name="$1"
  local prompt_message="$2"

  while true; do
    read -p "$prompt_message: " input

      if [ -n "$input" ]; then
          eval "$var_name=\"$input\"" # Assign input to the variable
        break
      else
          echo "Input cannot be empty."
      fi

  done
}

# Check if the user provided an output file name as an argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <output_file_name>"
  exit 1
  
fi

# Accept the filename as a param
output_file="$1"

# Create the output file. Adjust the path to suit your needs
touch "$output_file"

# Get the current date in the desired format (e.g., 21 August 2023)
current_date=$(date "+%d %B %Y")

echo "---------- ENTER ADDRESS ----------"

# Ask the user for the company's address
read -p "Enter the company address [Enter to continue]: " company_address

#Ask the user for the city, postal code
read -p "Enter the postal code [Enter to continue]: " postal_code
read -p "Enter the city [Enter to continue]: " company_city

# Ask the user for the employer's name
read -p "Enter the replacement text for [employer's name] [Enter to continue]: " employer_name


echo "---------- ENTER REPLACEMENT TEXT ----------"

# Ask the user for the company's name
not_empty company_name "Enter the replacement text for [company name]: " 

# Ask the user for position applied for
not_empty position "Enter the replacement text for [position]: "

# Ask the user where they found the job posting
not_empty job_posting "Enter the replacement text for [job posting]: "

# Ask the user the team being joined
not_empty team "Enter the replacement text for [team]: "

# Ask the user the company's goals and vision
not_empty vision "Enter the replacement text for [vision]: "

echo "---------- GENERATING LETTER ----------"

# Be sure to change the path of your input and output files to suit your needs.
# Read the cover letter template from the file
cover_letter_template=$(<cover_letter.md)

# Define the greeting based on employer_name
if [ -z "$employer_name" ]; then
    greeting="To whom it may concern"
else
    greeting="Dear $employer_name"
fi

# Replace "Dear [employer name]" with "[greeting]"
cover_letter_template=$(echo "$cover_letter_template" | sed "s/Dear \[employer name\]/$greeting/")

# Replace instances of [text in brackets]
cover_letter_content="${cover_letter_template//\[today date\]/$current_date}"
cover_letter_content="${cover_letter_content//\[employer name\]/$employer_name}"
cover_letter_content="${cover_letter_content//\[company address\]/$company_address}"
cover_letter_content="${cover_letter_content//\[postal code\]/$postal_code}"
cover_letter_content="${cover_letter_content//\[city\]/$company_city}"
cover_letter_content="${cover_letter_content//\[company name\]/$company_name}"
cover_letter_content="${cover_letter_content//\[position\]/$position}"
cover_letter_content="${cover_letter_content//\[job posting\]/$job_posting}"
cover_letter_content="${cover_letter_content//\[team\]/$team}"
cover_letter_content="${cover_letter_content//\[vision\]/$vision}"

# Debug statement to check the replaced content
echo "$cover_letter_content"

# Remember to change the path to suit your needs
echo -e "$cover_letter_content" > "$output_file"

echo "Replacement complete. Check '$output_file' for the updated text."

# Take a glance at the text before opening it in iA Writer. Adjust as needed. Remove if not opening the file.
sleep 10

# Optional: if you're using iA Writer for markdown texts
# Check if iA Writer is running
if ! pgrep -x "iA Writer" > /dev/null; then
  
    # iA Writer is not running, so open it
    open -a "iA Writer" /Users/apollostowel/Library/Mobile\ Documents/27N4MQEA55~pro~writer/Documents/Coverletters/"$output_file"

    # Wait for iA Writer to open (adjust the sleep duration as needed)
    sleep 3

    # Send an AppleScript command to iA Writer to make it fullscreen
    osascript -e 'tell application "System Events" to keystroke "f" using {command down, control down}'
else
    # iA Writer is already running, just display a message
    echo "iA Writer is already running."
fi
