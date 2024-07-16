#!/bin/bash
Time=$1
Label=$2

if [ -z "$Label" ]; then
    Label="Time left: %%time%% second%%plural%%..."
fi

while [ $Time -gt 0 ]; do
    PluralOut=""
    if [ $Time -gt 1 ]; then
        PluralOut="s"
    fi
    echo -ne "$Label\033[0K\r" | sed -e "s/%%time%%/$Time/" | sed -e "s/%%plural%%/$PluralOut/"
    sleep 1
    : $((Time--))
done