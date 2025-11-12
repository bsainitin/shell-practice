#!/bin/bash

echo "Enter the number to knnow Even or Odd:"
read Number

if [ $(($Number % 2)) -eq 0 ]; then
    echo "Given number $Number is Even number."
else
    echo "Given number $Number is Odd number."
fi