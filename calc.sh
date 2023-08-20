#!/bin/bash

echo "**********Calculator**********"


if [[ "$1" == "-p" ]]; then
	precicion=$2
	shift 2

else
	precicion=3
fi


bc << _EOF_
scale=$precicion

$@
_EOF_

