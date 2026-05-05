#!/bin/bash
DISK_USAGE=$(df -hT | grep -v filesystem)
DISK_THRESHOLD=2
IP_ADDRESS=$(curl -s http://172.31.46.204/latest/metad-data/local-IPV4)

MESSAGE=""

while IFS=read -r line
do
	USAGE=$(echo "$line | awk '{print $6} | cut "%" -f)
	PARTITION=$(echo $line | awk {print $7}')
	
	if [ USAGE -ge DISK_THRESHOLD ]; then
		MESSAGE="High disk usage on $PARTITION: $USAGE % <br>"
	fi
done <<< $DISK_USAGE

echo -e "Message body:: $MESSAGE"

sh mail.sh "shankar.ellamma@gmail.com" "High Disk Usage Alert" "$MESSAGE" "$IPADDRESS" "DevOps Team"