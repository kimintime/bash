#!/bin/bash

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

# Function to remove optional text
replace_optional() {
  local var_name="$1"
  local var_value="$2"
  local template="$3"

  if [ -n "$var_value" ]; then
    echo "${template//\[$var_name\]/$var_value}"
  else
    echo "$template" # No replacement, keep the original template
  fi
}

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

echo "---------- ENTER REPLACEMENT TEXT ----------"

# Ask the user for the employer's name
read -p "Enter the replacement text for [employer's name] [Enter to continue]: " employer_name

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


# Read the cover letter template from the file. Adjust this to suit your needs
cover_letter_template=$(<cover_letter.md)


# Replace instances of [text in brackets]
cover_letter_content="${cover_letter_template//\[today date\]/$current_date}"
cover_letter_content=$(replace_optional "employer's name" "$employer_name" "$cover_letter_content")
cover_letter_content=$(replace_optional "company address" "$company_address" "$cover_letter_content")
cover_letter_content=$(replace_optional "postal code" "$postal_code" "$cover_letter_content")
cover_letter_content=$(replace_optional "city" "$company_city" "$cover_letter_content")
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
