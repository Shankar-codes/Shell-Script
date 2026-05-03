#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERNAME=$(id -u)

LOGS_FOLDER="/var/log/Shell-Script"
SCRIPT_FILE=$(echo $0 | cut -d "." -f1)
LOGS_FILE="$LOGS_FOLDER/$SCRIPT_FILE.log"

mkdir -p $LOGS_FOLDER
echo "Script started executed at :: $(date)" | tee -a $LOGS_FILE

if [ $USERNAME -ne 0 ]; then
	echo "Please login to ROOT user" | tee -a $LOGS_FILE
	exit 1
fi

VALIDATE() {
	if [ $1 -ne 0 ]; then
		echo -e "Installing $2 ... $R FAILURE $N" | tee -a $LOGS_FILE
	else
		echo -e "Installing $2 ... $G SUCCESS $N" | tee -a $LOGS_FILE
	fi
}

for package in $@
do
	dnf list installed $package &>>LOGS_FILE
	if [ $? -ne 0 ]; then
		dnf install $package -y &>>LOGS_FILE
		VALIDATE $? "$package"
	else
		echo -e "$B $package already installed... $Y SKIPPING ... $N"
	fi
done