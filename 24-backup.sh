#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR="$1"
DEST_DIR="$2"
DAYS="${3:-14}"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(basename "$0" .sh)
LOG_FILE="$LOGS_FOLDER/backup.log"

mkdir -p "$LOGS_FOLDER"

echo -e "Script execution started at $(date)" | tee -a "$LOG_FILE"

# Root check
if [ "$USERID" -ne 0 ]; then
    echo -e "$R ERROR:: Please run this script with root privilege $N" | tee -a "$LOG_FILE"
    exit 1
fi

USAGE(){
    echo -e "$R USAGE:: sudo bash $0 <SOURCE_DIR> <DEST_DIR> [DAYS] $N"
    exit 1
}

# Argument validation
if [ $# -lt 2 ]; then
    USAGE
fi

# Directory checks
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "$R Source directory does not exist: $SOURCE_DIR $N" | tee -a "$LOG_FILE"
    exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
    echo -e "$R Destination directory does not exist: $DEST_DIR $N" | tee -a "$LOG_FILE"
    exit 1
fi

# Find files
FILES=$(find "$SOURCE_DIR" -name "*.log" -type f -mtime +"$DAYS")

if [ -n "$FILES" ]; then
    echo "Files found:" | tee -a "$LOG_FILE"
    echo "$FILES" | tee -a "$LOG_FILE"

    TIMESTAMP=$(date +%F-%H-%M)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.zip"

    echo "Creating zip file: $ZIP_FILE_NAME" | tee -a "$LOG_FILE"

    echo "$FILES" | zip -@ -j "$ZIP_FILE_NAME"

    if [ -f "$ZIP_FILE_NAME" ]; then
        echo -e "Archival $G SUCCESS $N" | tee -a "$LOG_FILE"

        # Delete files
        while IFS= read -r filepath
        do
            echo "Deleting file: $filepath" | tee -a "$LOG_FILE"
            rm -f "$filepath"
        done <<< "$FILES"

    else
        echo -e "Archival $R FAILURE $N" | tee -a "$LOG_FILE"
        exit 1
    fi
else
    echo -e "No files to archive $Y SKIPPING $N" | tee -a "$LOG_FILE"
fi