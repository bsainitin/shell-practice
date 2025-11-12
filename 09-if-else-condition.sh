#!/bin/bash

Number=$1

if [ "$Number" -lt 10 ]; then 
    echo "Given number $Number is less than 10"
elif ["$Number" -eq 10 ]; then
    echo "Given number $Number is Equal to 10"
else
    echo "Given $Number number is greater than 10"
fi