#!/bin/bash
echo "Enter the number"
read NUMBER

if [ $NUMBER -lt 10 ]; then
	echo "Given number is less than 10"
elif [ $NUMBER -eq 10 ]; then
	echo "Given number is equal to 10"
else
	echo "Given number is greater than 10"
fi

leader=("Modi" "Trump" "Putin" "NBK")
echo "${leader[@]}"
echo "${#leader[@]}"
echo "$PWD"
echo "$HOME"
echo "$id"