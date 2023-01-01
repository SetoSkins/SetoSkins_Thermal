chattr -i /data/vendor/thermal/config
chattr -i /data/vendor/thermal/config/*
chmod 777 /data/vendor/thermal/config
chmod 777 /data/vendor/thermal/config/*
rm -rf /data/system/package_cache/*
chattr -R -i -a /data/adb/modules/SetoSkins/
rm -rf /data/adb/service.d/service2.sh
rm -rf /data/adb/service.d/Seto_temp_threshold.sh
rm -rf /data/adb/service.d/service.sh
rm -rf /data/adb/service.d/post-fs-data.sh
echo 0 > /sys/class/power_supply/battery/input_suspend
{
	until [[ "$(getprop sys.boot_completed)" == "1" ]]; 
	do
		sleep 1
	done
    settings put system min_refresh_rate 
    service call SurfaceFlinger 1035 i32 0
}&
rm -rf /data/adb/service.d/Seto_temp_threshold.sh
/sbin/.magisk/busybox/chattr -i -a -A /cache/magisk.log
chmod 777 /cache/magisk.log
rm -f /data/system/package_cache/*
setprop ctl.restart thermal-engine
setprop ctl.restart mi_thermald
setprop ctl.restart thermal_manager
setprop ctl.restart thermal
function install_magisk_busybox() {
mkdir -p /data/adb/busybox
	/data/adb/magisk/busybox --install -s /data/adb/busybox
	chmod -R 0755 /data/adb/busybox 
export PATH=/data/adb/busybox:$PATH
}

install_magisk_busybox 2>/dev/null
function restart_mi_thermald(){
killall -15 mi_thermald
for i in $(which -a mi_thermald)
do
	nohup "$i" >/dev/null 2>&1 &
done
}
function mk_thermal_folder(){
resetprop -p sys.thermal.data.path /data/vendor/thermal/
resetprop -p vendor.sys.thermal.data.path /data/vendor/thermal/
chattr -R -i -a '/data/vendor/thermal'
	rm -rf '/data/vendor/thermal'
		mkdir -p '/data/vendor/thermal/config'
		chmod -R 0771 '/data/vendor/thermal'
	chown -R root:system '/data/vendor/thermal'
	cp -r /data/media/0/Android/备份温控（请勿删除）/* /data/vendor/thermal/config
	rm -rf /data/media/0/Android/备份温控（请勿删除）
chcon -R 'u:object_r:vendor_data_file:s0' '/data/vendor/thermal'
}

install_magisk_busybox
mk_thermal_folder
restart_mi_thermald
