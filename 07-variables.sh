#!/bin/bash
Date=$(date)
Start_time=$(date +%s)
sleep 5
End_time=$(date +%s)
Duration=$((End_time - Start_time))
echo "Current date and time: $Date"
echo "Script execution duration: $Duration seconds"