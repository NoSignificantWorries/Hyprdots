#!/usr/bin/sh

time=$(date +"%H:%M")
echo "time:$time"

full_date=$(date +"%d.%m.%Y")
echo "date:$full_date"

month_name=$(date +"%B")
day_name=$(date +"%A")
echo "month_name:$month_name"
echo "day_name:$day_name"

timezone=$(date +"%z")
if [ ${#timezone} -eq 5 ]; then
    timezone_formatted="${timezone:0:3}:${timezone:3:2}"
else
    timezone_formatted="$timezone"
fi
echo "timezone:$timezone_formatted"

day_month=$(date +"%d")
year=$(date +"%Y")
echo "day:$day_month"
echo "year:$year"
