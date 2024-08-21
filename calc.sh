#!/bin/bash

echo # New line

echo "**********Calculator**********"

echo # New line

# The -p option comes before the expression. Enter the precision value after the -p option.
if [[ "$1" == "-p" ]]; then
	precision=$2
	shift 2

else
	precision=3
fi

# Display the calculation
echo "Calculating: $*"

# Perform the calculation
result=$(bc << _EOF_
scale=$precision
$@
_EOF_
)

# Display the result

echo "Result: $result"

echo # New line

