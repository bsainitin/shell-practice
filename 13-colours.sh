#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# -e ignores backslash
echo -e "$R DANGER AHEAD $N" #If you dont use $N then the colour continues in the File.
echo "There is a sharp curve"
echo -e "$G GREEN LIGHT $N"
