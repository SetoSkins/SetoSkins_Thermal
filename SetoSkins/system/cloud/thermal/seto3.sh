#!/system/bin/sh
	until [ $(getprop sys.boot_completed) -eq 1 ] ; do
sleep 5
done
	if [[ -f /data/adb/1 ]]; then
	    rm -rf /data/adb/1
	    	rm -rf /data/media/0/Android/备份温控（请勿删除）
		rm -rf /data/adb/service.d/*seto*
		else
		touch /data/adb/1
		fi