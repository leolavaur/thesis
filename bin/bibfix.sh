#!/usr/bin/env bash

echo "Bibfix daemon started"
fswatch -0 --format="%f|%p" "$1" | while read -d "" event
do
    EVENT=$(echo "$event" | cut -d"|" -f1)

    [[ "$EVENT" =~ "Removed" ]] && exit 1

    FILENAME=$(echo "$event" | cut -d"|" -f2)

    [[ $(head "$FILENAME") =~ "% LTeX: enabled=false" ]] && continue

    sed -i '1s/^/% LTeX: enabled=false\n/' "$FILENAME"
    echo "Bibfix:$(date +%s):$FILENAME"
    
done
