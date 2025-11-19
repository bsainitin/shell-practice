#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/shell-roboshop"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
#LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"
LOG_FILE="$LOG_FOLDER/backup.log"
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #If not provided considered as 14 days

mkdir -p $LOG_FOLDER
echo "Script started execution at $(date)" | tee -a $LOG_FILE

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo -e "${R}ERROR:${N} Please run the command using root privilege"
    exit 1
fi

USAGE(){
    echo -e "$R USAGE: sudo sh backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS>[optional, default 14 days] $N"
    exit 1
}

if [ $# -lt 2 ]; then 
    USAGE
fi

if [ ! -d $SOURCE_DIR ]; then
    echo -e "$R ERROR source $SOURCE_DIR does not exists $N"
    exit 1
fi

if [ ! -d $DEST_DIR ]; then
    echo -e "$R ERROR source $DEST_DIR does not exists $N"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

if [ ! -z "${FILES}" ]; then
    echo "Files found"
    TIMESTAMP=$(date +%F-%H-%M)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    echo "Zip file name: $ZIP_FILE_NAME"
    find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS | zip -@ -j "$ZIP_FILE_NAME"

    if [ -f $ZIP_FILE_NAME ]; then 
        echo -e "Archival ... $G SUCCESS $N"

        while IFS= read -r filepath
        do 
            echo "Deleting the file: $filepath"
            rm -rf $filepath
            echo "Deleted the file: $filepath"
        done <<< $FILES
    else
        echo -e "Archival ... $R FAILURE $N"
        exit 1
    fi
else
    echo -e "No files to archive ... $Y SKIPPING $N"
fi