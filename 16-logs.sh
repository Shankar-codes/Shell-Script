#!/bin/bash

USERNAME=$(id -u)
LOGS_FOLDER="/var/log/Shell-Script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGS_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

if [ $USERNAME -ne 0 ]; then
	echo "Use root login to run the scripts"
	exit 1
fi

VALIDATE() {
	if [ $1 -ne 0 ]; then
		echo "Installing $2 is failure" | tee -a $LOGS_FILE
		exit 1
	else
		echo "Installing $2 is Success" | tee -a $LOGS_FILE
	fi
}

dnf list installed mysql &>>$LOGS_FILE
if [ $? -ne 0 ]; then
	dnf install mysql -y &>>$LOGS_FILE
	VALIDATE $? "mysql"
else
	echo "mysql already installed" | tee -a $LOGS_FILE
fi

dnf list installed nginx &>>LOGS_FILE
if [ $? -ne 0 ]; then
	dnf install nginx &>>LOGS_FILE
	VALIDATE $? "nginx"
else
	echo "nginx already installed" | tee -a $LOGS_FILE
fi

dnf list installed python3 &>>$LOGS_FILE
if [ $? -ne 0 ]; then
	dnf install python3 &>>$LOGS_FILE
	VALIDATE $? "Python3"
else
	echo "Python3 already installed" | tee -a $LOGS_FILE
fi