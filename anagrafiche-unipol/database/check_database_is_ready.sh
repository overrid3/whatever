#!/bin/bash

fileToCheck=$1

if [[ -f $fileToCheck ]]
then
    echo `date` "The file $fileToCheck exists."
    exit 0
else
    echo `date` "The file $fileToCheck does not exist."
    exit 1
fi