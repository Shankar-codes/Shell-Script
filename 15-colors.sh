#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
M="\e[35m"

USERNAME=$(id -u)

if [ $USERNAME -ne 0 ]; then
    echo "Please login as root user to run this script"
    exit 1
fi

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$RERROR:: Installing $2 is failure"
        exit 1
    else
        echo -e "$GInstalling $2 is successful"
    fi
}

dnf list installed mysql

if [ $? -ne 0 ]; then
	dnf install mysql -y
	VALIDATE $? "mysql"
else
	echo -e "$MMysql already installed"
fi

dnf list installed nginx
if [$? -ne 0 ]: then
	dnf install nginx -y
	VALIDATE $? "nginx"
else
	echo -e "$Bnginx already installed"
fi

dnf list installed python3
if [ $? -ne 0 ]; then
	dnf install python3 -y
	VALIDATE $? "Python3"
else
	echo -e "$Y Python3 is already installed"
fi