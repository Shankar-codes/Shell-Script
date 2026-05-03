#!/bin/bash

USERNAME=$(id -u)
if [ $USERNAME -ne 0 ]; then
    echo "PLease login as root user to run this script"
    exit 1
fi

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo "ERROR:: Installing $2 is failure"
        exit 1
    else
        echo "Installing $2 is successful"
    fi
}

dnf install mysql -y
VALIDATE $? "mysql"

dnf install nginx -y
VALIDATE $? "nginx"

dnf install python3 -y
VALIDATE $? "python3"