#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo -e "${R}ERROR:${N} Please run the command using root privilege"
    exit 1
fi

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER

echo  "Script execution started at: $(date)" | tee -a $LOG_FILE

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e "Installing $2 ... $R FAILURE $N" | tee -a $LOG_FILE
    else
        echo -e "Installing $2 ... $G SUCCESS $N" | tee -a $LOG_FILE
    fi
}

for package in $@
do 
    dnf list installed $package
    if [ $? -ne 0 ]; then
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? $package
    else
        echo -e "$package already installed ... $Y SKIPPING $N" | tee -a $LOG_FILE
    fi 
done