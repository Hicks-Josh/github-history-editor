#!/usr/bin/env bash

set -e

echo "╭━━━╮╭╮╭╮╱╱╱╱╭╮╱╱╭╮╱╭╮╱╱╱╭╮╱╱╱╱╱╱╱╱╱╱╭━━━╮╱╭╮╭╮";
echo "┃╭━╮┣╯╰┫┃╱╱╱╱┃┃╱╱┃┃╱┃┃╱╱╭╯╰╮╱╱╱╱╱╱╱╱╱┃╭━━╯╱┃┣╯╰╮";
echo "┃┃╱╰╋╮╭┫╰━┳╮╭┫╰━╮┃╰━╯┣┳━┻╮╭╋━━┳━┳╮╱╭╮┃╰━━┳━╯┣╮╭╋━━┳━╮";
echo "┃┃╭━╋┫┃┃╭╮┃┃┃┃╭╮┃┃╭━╮┣┫━━┫┃┃╭╮┃╭┫┃╱┃┃┃╭━━┫╭╮┣┫┃┃╭╮┃╭╯";
echo "┃╰┻━┃┃╰┫┃┃┃╰╯┃╰╯┃┃┃╱┃┃┣━━┃╰┫╰╯┃┃┃╰━╯┃┃╰━━┫╰╯┃┃╰┫╰╯┃┃";
echo "╰━━━┻┻━┻╯╰┻━━┻━━╯╰╯╱╰┻┻━━┻━┻━━┻╯╰━╮╭╯╰━━━┻━━┻┻━┻━━┻╯";
echo "╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭━╯┃";
echo "╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╰━━╯";

MONTHS_BACK=6

# times of day for commits
TIMES=("09:00:00" "14:00:00" "19:00:00")

# starting date - 6 months ago
START_DATE=$(date -d "$MONTHS_BACK months ago" +"%Y-%m-%d")
END_DATE=$(date +"%Y-%m-%d")

current_date="$START_DATE"

while [[ "$current_date" <="$END_DATE" ]]; do
  for time in "${TIMES[@]}"; do
    commit_datetime="$current_date $time"

    GIT_AUTHOR_DATE="$commit_datetime" \
    GIT_COMMITTER_DATE="$commit_datetime" \
    git commit --allow-empty -m "chore: work on $current_date"
  done

  current_date=$(date -d "$current_date + 1 day" +"%Y-%m-%d")
done

echo "Done. Don't forget to force-push."
