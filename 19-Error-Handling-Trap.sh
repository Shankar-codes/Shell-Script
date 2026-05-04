#!/bin/bash
#Error Handling
trap 'echo "There is an error in $LINENO, Command is :$BASH_COMMAND"' ERR
echo "Hello..."
echo "Before error"
abcdefghn
echo "After error"