#!/bin/bash

USERID=$(id -u)

# 0  ->  Success
# Failure is other than 0 

if [ $USERID -ne 0 ]; then 
    echo "ERROR: Please run the script using root privilege"
    exit 1 #Shell script continues execution if we do not stop on error.
fi

dnf install mysql -y

if [ $? -ne 0 ]; then 
    echo "ERROR: Installing mysql Failed"
    exit 1
else
    echo "Installing mysql is SUCCESS"
fi      