#!/bin/bash
NAME=India
echo "PID of the script1 is $$, $NAME"
source "./21-scripts-2.sh"
echo "After sourcing the script2, PID of the script1 is $$, $NAME"