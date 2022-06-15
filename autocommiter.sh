#!/bin/sh
saved_date=$(tail -n 1 autocommiter_tracker | grep -Eo '(?<|)[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}')
saved_date_timestamp=$(date -d "${saved_date}" +"%s")
current_folder=$(pwd)

cd $TARGETFOLDER
choosen=$(git status -s | sed "s@^[^ ]* @$PWD/@" | tail -1)

if [ -z "$choosen" ]
then
    echo "No item to save in the repo"
else
    echo "Saving $choosen"
    today_simplified=$(date +"%Y-%m-%d")
    today_timestamp=$(date -d "${today_simplified}" +"%s")

    if [ -z "$saved_date" ] || [ $today_timestamp -gt $saved_date_timestamp ];
    then
        git add $choosen
        git commit -m "Saving Kata Solution"
        git push origin master

        # saving current progress, if a file has been saved today no need to save more
        cd $current_folder
        echo "$choosen | $today_simplified" >> autocommiter_tracker
    else
        cd $current_folder
        echo "Do nothing"
    fi
fi