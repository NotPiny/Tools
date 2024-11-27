#!/bin/bash
COMMAND=$2
DIR=$1
FLAGS=($@)

# Recurvely loop through all files in the directory and subdirectories
function loop() {
    for file in $1/*; do
        if [ -d $file ]; then
            loop $file
        else
            $COMMAND $file
        fi
    done
}

loop $DIR