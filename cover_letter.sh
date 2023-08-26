#!/bin/bash

# Function to check that required text is not empty
not_empty(){
	local var_name="$1"
  	local prompt_message="$2"

	white true; do
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

output_file="$1"

# Get the current date in the desired format (e.g., 21 August 2023)
current_date=$(date "+%d %B %Y")

echo "---------- ENTER ADDRESS ----------"

# Ask the user for the company's address
read -p "Enter the company address [Enter to continue]: " company_address

#Ask the user for the city, postal code
read -p "Enter the city [Enter to continue]: " company_city
read -p "Enter the postal code [Enter to continue]: " postal_code

echo "---------- ENTER REPLACEMENT TEXT ----------"

# Ask the user for the employer's name
read -p "Enter the replacement text for [employer's name] [Enter to continue]: " employer_name

# Ask the user for the company's name
not_empty company_name "Enter the replacement text for [company name]: " 

# Ask the user for position applied for
not_empty postion "Enter the replacement text for [position]: "

# Ask the user where they found the job posting
not_empty job_posting "Enter the replacement text for [job posting]: "

# Ask the user the job title
not_empty job_title "Enter the replacement text for [title]: "

# Ask the user the team being joined
not_empty team "Enter the replacement text for [team]: "

# Ask the user the company's goals and vision
not_empty vision "Enter the replacement text for [vision]: "


echo "---------- GENERATING LETTER ----------"

# Be sure to change the path of your input and output files to suit your needs.

# Use sed to replace optional text, or delete the placeholders
if [ -n "$employer_name" ]; then
  sed "s/\[employer's name\]/$employer_name/g" input.txt > "$output_file"
else
  sed -i "s/Dear \[employer's name\]/To whom it may concern/g" "$output_file"
fi

if [ -n "$company_address" ]; then
  sed "s/\[company address\]/$company_address/g" input.txt > "$output_file"
else
  sed "/\[company address\]/d" input.txt > "$output_file"
fi

if [ -n "$company_city" ]; then
  sed "s/\[city\]/$employer_name/g" input.txt > "$output_file"
else
  sed "/\[city\]/d" input.txt > "$output_file"
fi

if [ -n "$postal_code" ]; then
  sed "s/\[postal code\]/$employer_name/g" input.txt > "$output_file"
else
  sed "/\[postal code\]/d" input.txt > "$output_file"
fi


# Use sed to find and replace instances of [text in brackets]
sed "s/\[today's date\]/$company_date/g" input.txt > "$output_file"

sed "s/\[company name\]/$company_name/g" input.txt > "$output_file"

sed "s/\[position\]/$postion/g" input.txt > "$output_file"

sed "s/\[job posting\]/$job_posting/g" input.txt > "$output_file"

sed "s/\[title\]/$job_title/g" input.txt > "$output_file"

sed "s/\[team\]/$team/g" input.txt > "$output_file"

sed "s/\[vision\]/$vision/g" input.txt > "$output_file"

echo "Replacement complete. Check '$output_file' for the updated text."
