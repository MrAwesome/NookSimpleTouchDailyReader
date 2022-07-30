#!/system/xbin/ash

set -euo pipefail
                
# NOTE: This file must be populated with your own static server IP address for this to work!
ADDR=$(cat /system/bin/ADDR)

NEWS_DIRECTORY="/dev/newsletters"
CHECKER_FILENAME="most_recent.txt"

[ -d "$NEWS_DIRECTORY" ] || mkdir "$NEWS_DIRECTORY"
cd "$NEWS_DIRECTORY"
                    
if [[ -f "$CHECKER_FILENAME" ]]; then
    OLD_CHECKER_FILE=$(find "$CHECKER_FILENAME" -mmin +10)
    if [[ "$OLD_CHECKER_FILE" == "" ]]; then
        exit 2
    fi
fi

wget -q "http://$ADDR/$CHECKER_FILENAME" -O - > "$CHECKER_FILENAME"

#MOST_RECENT=$()

