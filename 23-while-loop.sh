#!/bin/bash

while IFS= read -r line;
do
    echo "Processing line : $line"
done < "./20-scripts-1.sh"