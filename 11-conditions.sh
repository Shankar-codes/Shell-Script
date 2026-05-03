#!/bin/bash
echo "Enter the number to find the whether it's even or odd"
read NUMBER
if [ $((NUMBER % 2)) -eq 0 ]; then
	echo "The given number is even"
else
	echo "The given number is odd"
fi