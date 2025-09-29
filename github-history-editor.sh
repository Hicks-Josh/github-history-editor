#!/bin/sh


echo "╭━━━╮╭╮╭╮╱╱╱╱╭╮╱╱╭╮╱╭╮╱╱╱╭╮╱╱╱╱╱╱╱╱╱╱╭━━━╮╱╭╮╭╮";
echo "┃╭━╮┣╯╰┫┃╱╱╱╱┃┃╱╱┃┃╱┃┃╱╱╭╯╰╮╱╱╱╱╱╱╱╱╱┃╭━━╯╱┃┣╯╰╮";
echo "┃┃╱╰╋╮╭┫╰━┳╮╭┫╰━╮┃╰━╯┣┳━┻╮╭╋━━┳━┳╮╱╭╮┃╰━━┳━╯┣╮╭╋━━┳━╮";
echo "┃┃╭━╋┫┃┃╭╮┃┃┃┃╭╮┃┃╭━╮┣┫━━┫┃┃╭╮┃╭┫┃╱┃┃┃╭━━┫╭╮┣┫┃┃╭╮┃╭╯";
echo "┃╰┻━┃┃╰┫┃┃┃╰╯┃╰╯┃┃┃╱┃┃┣━━┃╰┫╰╯┃┃┃╰━╯┃┃╰━━┫╰╯┃┃╰┫╰╯┃┃";
echo "╰━━━┻┻━┻╯╰┻━━┻━━╯╰╯╱╰┻┻━━┻━┻━━┻╯╰━╮╭╯╰━━━┻━━┻┻━┻━━┻╯";
echo "╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭━╯┃";
echo "╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╰━━╯";

read -r -p 'How many commits per day should be made: ' COMMITS_PER_DAY;
read -r -p 'How many days back should be gone: ' COMMITS_BACK;

commit_day_index=0;
while [ "$commit_day_index" -le "$COMMITS_BACK" ]; do
    commit_per_day_index=0;
    while [ "$commit_per_day_index" -le "$COMMITS_PER_DAY" ]; do
        day=$(date -d "$commit_day_index days ago $commit_per_day_index seconds ago" '+%a %b %d %H:%M %Y %Z');

        echo "commiting to this time: $day";
        GIT_COMMITTER_DATE="$day" git commit --date "$day" --allow-empty --allow-empty-message -m ''
        commit_per_day_index=$(($commit_per_day_index+1));
    done;
    commit_day_index=$(($commit_day_index+1));
done;
