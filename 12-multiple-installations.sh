#!/bin/bash

USERID=$(id -u)

# 0  ->  Success
# Failure is other than 0 

if [ $USERID -ne 0 ]; then 
    echo "ERROR: Please run the script using root privilege"
    exit 1 #Shell script continues execution if we do not stop on error.
fi

VALIDATE() { #Functions receive inputs through arguments just like shell script arguments
    if [ $1 -ne 0 ]; then 
        echo "ERROR: Installing $2 has Failed"
        exit 1
    else
        echo "Installing $2 is SUCCESS"
    fi 

}

dnf install mysql -y
VALIDATE $? "MySQL"

dnf install nginx -y
VALIDATE $? "Nginx"

dnf install python3 -y
VALIDATE $? "Python3"


