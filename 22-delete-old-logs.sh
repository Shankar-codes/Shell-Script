#!/bin/bash
LOGS_FOLDER="/var/log/Shell-Script"
SCRIPT_NAME=$(echo "$0" | cut -d '.' -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p LOGS_FOLDER

echo "Script execution started at $(date)..." | tee -a &LOG_FILE

SOURCE_DIR=/home/ec2-user/app-logs

if [ ! -d $SOURCE_DIR ]; then
	echo "ERROR :: $SOURCE_DIR does not exists"
	exit 1;
fi

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -type -f -mtime +14)

while IFS=read -r filepath
do
	echo "Deleting the file: $filepath"
	rm -rf $filepath
	echo "Deleted the file:: $filepath"
done <<< $FILES_TO_DELETE