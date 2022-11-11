#!/sbin/sh
# 编写: 酷安@董小豪
# 版本: v2.0
chattr -i /data/vendor/thermal/config
chattr -i /data/vendor/thermal/config/*
chmod 777 /data/vendor/thermal/config
chmod 777 /data/vendor/thermal/config/*
rm -rf /data/vendor/thermal/config/*
rm -rf /data/system/package_cache/*
rm -f /data/thermal
chattr -R -i -a /data/adb/modules/SetoSkins/
{
	until [[ "$(getprop sys.boot_completed)" == "1" ]]; 
	do
		sleep 1
	done
    settings put system min_refresh_rate 60
}&
/sbin/.magisk/busybox/chattr -i -a -A /cache/magisk.log
chmod 777 /cache/magisk.log
rm -f /data/system/package_cache/*
rm -rf /data/adb/modules/SetoSkins/
rm -rf /data/adb/modules/module.prop