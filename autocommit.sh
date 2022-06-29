#!/bin/bash
COMMITS=3

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

    if [[ $(date +"%u") -lt 6 ]] && ([ -z "$saved_date" ] || [ $today_timestamp -gt $saved_date_timestamp ]) ; then
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
        echo "Do nothing"
    fi
fi