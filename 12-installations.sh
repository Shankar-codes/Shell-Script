#!/bin/basj
USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Please login as root user to run this script"
fi

dnf install mysql -y

if [ $? -ne 0 ]; then
    echo "Failed to install the Mysql"
else
    echo "Mysql installed successfully"
fi