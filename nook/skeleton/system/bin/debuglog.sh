#!/system/xbin/ash

set -euo pipefail

FORMATS="pdf epub"
                
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


if [[ ! -f $CHECKER_FILENAME ]]; then
    echo "latest" > $CHECKER_FILENAME
fi
CACHED_CHECKED=$(cat $CHECKER_FILENAME)

CHECKER_CONTENTS=$(wget -q "http://$ADDR/$CHECKER_FILENAME" -O - || echo "$CACHED_CHECKED")

echo "$CHECKER_CONTENTS" > "$CHECKER_FILENAME"

for format in $FORMATS; do
    TARGET_FILENAME=$(cat $CHECKER_FILENAME).${format}
    if [[ ! -f "$TARGET_FILENAME" ]]; then
        wget -q "http://$ADDR/$TARGET_FILENAME"
    fi
done
