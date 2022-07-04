#!/bin/bash
COMMITS=$(($RANDOM%3 + 4))
TARGETFOLDER="$1"
AUTOCOMMITFOLDER=$(dirname "$0")

if [ -z "$TARGETFOLDER" ]
then
    echo "Please specify a folder to autocommit"
    exit 1
else
    echo "Target folder is $TARGETFOLDER"
fi

saved_date=$(tail -n 1 ${AUTOCOMMITFOLDER}/autocommit_tracker | grep -Eo '(?<|)[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}')
saved_date_timestamp=$(date -d "${saved_date}" +"%s")

cd $TARGETFOLDER
choosen=$(git status -s | sed "s@^[^ ]* @$PWD/@" | tail -${COMMITS})

if [ -z "$choosen" ]
then
    echo "No item to save in the repo"
else
    today_simplified=$(date +"%Y-%m-%d")
    today_timestamp=$(date -d "${today_simplified}" +"%s")
    current_time=$(date +%H:%M)

    if [[ $(date +"%u") -lt 6 ]] && ([ -z "$saved_date" ] || [ $today_timestamp -gt $saved_date_timestamp ]) && ([[ "$current_time" < "23:00" ]] && [[ "$current_time" > "09:30" ]]); then
        arr=($(echo $choosen | tr ',' "\n"))
        for (( i=0; i<${#arr[@]}; i++ ))
        do
            echo "Saving $i: ${arr[$i]}"
            git add ${arr[$i]}
            git commit -m "Saving Kata Solution"
            git push origin master
            sleep 5
        done

        # saving current progress, if a file has been saved today no need to save more
        cd $AUTOCOMMITFOLDER
        echo "$choosen | $today_simplified" >> autocommit_tracker
    else
        cd $AUTOCOMMITFOLDER
        echo "Do nothing $current_time"
    fi
fi