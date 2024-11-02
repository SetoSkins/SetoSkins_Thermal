#!/bin/bash
start_time=$(date +%s)
duration=125

while true; do
    current_time=$(date +%s)
    elapsed=$(( current_time - start_time ))

    if [ $elapsed -ge $duration ]; then
        break
    fi

	sleep 2
cp -f /sdcard/Android/备份温控（请勿删除）/* /data/vendor/thermal/config/
	cp -f /data/media/0/Android/备份温控（请勿删除）/* /data/vendor/thermal/config/

sleep 1
done