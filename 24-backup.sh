#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2

DAYS=${3:-14}

LOGS_FOLDER="/var/logs/Shell-Script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/backup.log"

mkdir -p $LOGS_FOLDER
echo "Script started executed at :: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]; then
	echo "ERROR:: Please run this in with root previleage"
	exit  1
fi

USAGE() {
	echo -e "$R USAGE:: sudo sh 24-backup.sh
	<SOURCE_DIR> <DEST_DIR> <DAYS> [optional default 14 days] $N"
	exit 1
}

if [ $# -lt 2 ]; then
	USAGE
fi

if [ ! -d $SOURCE_DIR ]; then
	echo -e "$R $SOURCE_DIR does not exist $N"
	exit 1
fi

if [ ! -d $DEST_DIR ]; then
	echo -e "$R $DEST_DIR does not exist $N"
	exit 1
fi

#find the files
FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

if [ -n "${FILES}" ]; then
	echo "Files found $FILES"
	TIMESTAMP=$(date +%F-%H-%M)
	ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.zip"
	echo "zip file name:: $ZIP_FILE_NAME"
	find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS | zip -j "$ZIP_FILE_NAME"

	if [ -f $ZIP_FILE_NAME ]; then
		echo -e "Archival... $G SUCCESS $N"
		while IFS=read -r filepath
		do
			rm -rf $filepath
			echo "Delete the :: $filepath"
		done <<< $FILES

	else
		echo "Archival... $R FAILURE $N"
		exit 1
	fi
else
	echo -e "No files to archive... $Y SKIPPING $N"
fi