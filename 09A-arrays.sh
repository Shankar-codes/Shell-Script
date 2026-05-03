#!/bin/bash
#Arrays
LEADER=("MODI" "TRUMP" "PUTIN" "XI JINPING")
echo "First Leader: ${LEADER[0]}"
echo "All Leaders: ${LEADER[@]}"
echo "Number of Leaders: ${#LEADER[@]}"