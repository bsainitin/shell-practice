#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# 0  ->  Success
# Failure is other than 0 

if [ $USERID -ne 0 ]; then 
    echo "ERROR: Please run the script using root privilege"
    exit 1 #Shell script continues execution if we do not stop on error.
fi

VALIDATE() { #Functions receive inputs through arguments just like shell script arguments

    if [ $1 -ne 0 ]; then 
        echo -e "Installing $2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "Installing $2 ... $G SUCCESS $N"
    fi 

}

dnf list installed mysql
if [ $? -ne 0 ]; then 
    dnf install mysql -y
    VALIDATE $? "MySQL"
else 
    echo -e "MySQL already exists ... $Y SKIPPING $N"
fi 

dnf list installed nginx
if [ $? -ne 0 ]; then 
    dnf install nginx -y
    VALIDATE $? "Nginx"
else
    echo -e "Nginx already exists ... $Y SKIPPING $N"
fi

dnf list installed python3
if [ $? -ne 0 ]; then
    dnf install python3 -y
    VALIDATE $? "Python3"
else
    echo -e "Python3 already exists ... $Y SKIPPING $N"
fi

