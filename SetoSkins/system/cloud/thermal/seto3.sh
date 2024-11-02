#!/system/bin/sh
while true; do
	if [[ "$(getprop sys.boot_completed)" == "1" ]]; then
		sleep 120
		break
	fi
done
 while true; do
	if [[ -f /data/adb/1 ]]; then
	for i in {1..5}
	do
	    rm -rf /data/adb/1
	    	rm -rf /data/media/0/Android/备份温控（请勿删除）
		rm -rf /data/adb/service.d/*seto*
		done
		break
		else
		touch /data/adb/1
		fi
done