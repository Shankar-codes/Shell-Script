#!/bin/bash
echo "All variables passed to the script: $@"
echo "Number of arguments passed to the script: $*"
echo "The name of the script: $0"
echo "The process ID of the script: $$"
echo "The exit status of the last command: $?"
echo "The number of arguments passed to the script: $#"

#output: to run the script with arguments
#./08-special-variables.sh arg1 arg2 arg3