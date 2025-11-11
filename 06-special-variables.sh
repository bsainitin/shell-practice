#!/bin/bash

echo "Enter the variables: $@"
#            OR
echo "Enter the variables: $*"

echo "Script File Name: $0"
echo "Current directory: $PWD"
echo "User Name: $USER"
echo "Home directory of the user: $HOME"
echo "PID of the script: $$"
sleep 50 &
echo "PID of the Last command in back ground: $!"