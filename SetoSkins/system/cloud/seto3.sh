#!/system/bin/sh
	if [[ "$(getprop sys.boot_completed)" == "1" ]]; then
	if [[ -f /data/adb/1 ]]; then
	    rm -rf /data/adb/1
		rm -rf /data/adb/service.d/*seto*
		else
		touch /data/adb/1
		fi
	fi
