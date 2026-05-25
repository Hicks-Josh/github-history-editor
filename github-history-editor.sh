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
MIN_COMMITS=1
MAX_COMMITS=5

# All possible times to pick from (must have at least MAX_COMMITS entries)
ALL_TIMES=(
  "07:30:00" "08:15:00" "09:00:00" "10:20:00" "11:45:00"
  "13:00:00" "14:30:00" "15:15:00" "16:40:00" "17:50:00"
  "19:00:00" "20:30:00"
)

START_DATE=$(date -d "$MONTHS_BACK months ago" +"%Y-%m-%d")
END_DATE=$(date +"%Y-%m-%d")
current_date="$START_DATE"

while [[ "$current_date" < "$END_DATE" || "$current_date" == "$END_DATE" ]]; do
  # Pick a random number of commits for this day
  num_commits=$(( RANDOM % (MAX_COMMITS - MIN_COMMITS + 1) + MIN_COMMITS ))

  # Shuffle ALL_TIMES and pick the first num_commits entries
  mapfile -t shuffled < <(printf '%s\n' "${ALL_TIMES[@]}" | shuf)

  # Sort selected times so commits are in chronological order
  mapfile -t selected < <(printf '%s\n' "${shuffled[@]:0:$num_commits}" | sort)

  for time in "${selected[@]}"; do
    commit_datetime="$current_date $time"
    GIT_AUTHOR_DATE="$commit_datetime" \
    GIT_COMMITTER_DATE="$commit_datetime" \
    git commit --allow-empty -m "chore: work on $current_date"
  done

  current_date=$(date -d "$current_date + 1 day" +"%Y-%m-%d")
done

echo "Done. Don't forget to force-push."
