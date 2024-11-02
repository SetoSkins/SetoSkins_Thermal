#!/system/bin/sh
MODDIR=${0%/*}

alias sh='/system/bin/sh'
var_device=$(getprop ro.product.device)
status=$(cat /sys/class/power_supply/battery/status)
capacity=$(cat /sys/class/power_supply/battery/capacity)
temp=$(expr $(cat /sys/class/power_supply/battery/temp) / 10)
ChargemA=$(expr $(cat /sys/class/power_supply/battery/current_now) / -1000)
a=$(getprop ro.system.build.version.release)
mv $MODDIR/执行作者主页.sh /data/adb/modules/SetoSkins/乱七八糟/执行作者主页.sh
file1=/data/adb/modules/SetoSkins/配置.prop
file2=$(ls /sys/class/power_supply/battery/*charge_current /sys/class/power_supply/battery/current_max /sys/class/power_supply/battery/thermal_input_current 2>>/dev/null | tr -d '\n')
file3=$(ls /sys/class/power_supply/*/constant_charge_current_max /sys/class/power_supply/*/fast_charge_current /sys/class/power_supply/*/thermal_input_current 2>/dev/null |tr -d ' ')
show_value() {
	value=$1
	file=/data/adb/modules/SetoSkins/配置.prop
	cat "${file}" | grep -E "(^$value=)" | sed '/^#/d;/^[[:space:]]*$/d;s/.*=//g' | sed 's/，/,/g;s/——/-/g;s/：/:/g' | head -n 1
}
	rm -rf /data/vendor/thermal/config/*
chattr -R -i -a /data/vendor/thermal/
#云端
if test $(show_value '均衡式性能温控') == false; then
	if test $(show_value '跳电修复模式') == false; then
		if test $(show_value '还原性能模式温控') == false; then
		if [ -f "/system/vendor/odm/etc/thermal-normal.conf" ];then
		if [ -f /data/adb/magisk/Delta.prop ];then
					mkdir -p /data/adb/modules/SetoSkins/system/vendor/odm/etc/
						cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-cnormal.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-normal.conf"
							cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-thermal-highfps.conf"
								cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-thermal-cclassvideo.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-class0.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-cnormal.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-per-normal.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-per-class0.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-nolimits.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-tgame.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-mgame.conf"
					cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-cgame.conf"
							cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-cgame2.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-yuanshen.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-video.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-per-video.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-nolimits.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-performance-boost-game.conf"
		fi		
				
			
		if [ -f /data/media/0/Android/备份温控（请勿删除）/thermal-cgame.conf ]; then
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-cgame.conf"
					cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-cgame.conf"
					fi
	if [ -f /system/vendor/odm/etc/thermal-cgame.conf ]; then
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-cgame.conf"
		
						cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-cgame2.conf"
			
					fi
						if [ -f /system/vendor/odm/etc/thermal-cclassvideo.conf ]; then
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-cclassvideo.conf"
					fi
if [ -f /system/vendor/odm/etc/thermal-highfps.conf ]; then
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-highfps.conf"
					fi
					
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-cnormal.conf" "/data/vendor/thermal/config/thermal-normal.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-class0.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-cnormal.conf" "/data/vendor/thermal/config/thermal-per-normal.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-per-class0.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-nolimits.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-tgame.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-mgame.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-yuanshen.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-video.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-per-video.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-nolimits.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-performance-boost-game.conf"
			else
					mkdir -p /data/adb/modules/SetoSkins/system/vendor/etc
			#本地
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-cnormal.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-normal.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-class0.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-cnormal.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-per-normal.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-per-class0.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-nolimits.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-tgame.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-mgame.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-yuanshen.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-video.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-per-video.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-nolimits.conf"
					cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-highfps.conf"
					fi
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-cnormal.conf" "/data/vendor/thermal/config/thermal-normal.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-class0.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-cnormal.conf" "/data/vendor/thermal/config/thermal-per-normal.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-per-class0.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-nolimits.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-tgame.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-mgame.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-yuanshen.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-video.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-per-video.conf"
			cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-nolimits.conf"
			chmod 777 /sys/class/thermal/thermal_message/sconfig

			case "$var_device" in
			xagapro)
				var_device_trans=l16u
				;;
			star | mars)
				var_device_trans=k1a
				;;
			esac
			if [[ $var_device_trans != "" ]]; then
				#云端
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-cnormal.conf" "/data/vendor/thermal/config/thermal-per-${var_device_trans}-normal.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-per-${var_device_trans}-class0.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-nolimits.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-tgame.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-mgame.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-per-${var_device_trans}-video.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-video.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-cnormal.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-normal.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-class0.conf"
				#本地
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-cnormal.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-per-${var_device_trans}-normal.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-per-${var_device_trans}-class0.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-cnormal.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-${var_device_trans}-normal.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-${var_device_trans}-class0.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-${var_device_trans}-nolimits.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-${var_device_trans}-tgame.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-${var_device_trans}-mgame.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-per-${var_device_trans}-video.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-${var_device_trans}-video.conf"
		fi
	fi
	
	fi
fi
chmod 777 /sys/class/thermal/thermal_message/sconfig

if [ -f /data/media/0/Android/备份温控（请勿删除）/thermal-normal.conf ]; then
if test $(show_value '均衡式性能温控') == true; then

		
		rm -rf /data/system/thermal/*mgame.conf
		rm -rf /data/adb/modules/SetoSkins/system/system/vendor/etc/*mgame.conf
		cp -f /data/media/0/Android/备份温控（请勿删除）/thermal-tgame.conf /data/vendor/thermal/config/thermal-mgame.conf
		cp -f /data/media/0/Android/备份温控（请勿删除）/thermal-tgame.conf /data/adb/modules/SetoSkins/system/system/vendor/etc/thermal-mgame.conf
				cp -f -f /data/adb/modules/SetoSkins/cloud/thermal/thermal-performance.conf /data/vendor/thermal/config/thermal-normal.conf
		cp -f -f /data/adb/modules/SetoSkins/cloud/thermal/thermal-performance.conf /data/adb/modules/SetoSkins/system/system/vendor/etc/thermal-mgame.conf
	
	if [[ $var_device_trans != "" ]]; then
		
		rm -rf /data/system/thermal/*mgame.conf
		rm -rf /data/adb/modules/SetoSkins/system/system/vendor/etc/*mgame.conf
	
		cp -f -f "/data/adb/modules/SetoSkins/cloud/thermal/thermal-performance.conf" "/data/adb/modules/SetoSkins/system/system/vendor/etc/thermal-${var_device_trans}-normal.conf"
			cp -f -f "/data/adb/modules/SetoSkins/cloud/thermal/thermal-performance.conf /data/vendor/thermal/config/thermal-${var_device_trans}-normal.conf"
		cp -f "/data/adb/modules/SetoSkins/cloud/thermal/thermal-${var_device_trans}-tgame.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-mgame.conf"
		cp -f "/data/adb/modules/SetoSkins/cloud/thermal/thermal-${var_device_trans}-tgame.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-${var_device_trans}-mgame.conf"
	fi
fi

fi
if test $(show_value '关闭录制温控') == true; then
	if [ ! -d /data/media/0/Android/备份温控（请勿删除） ]; then
		cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-4k.conf"
				cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-8k.conf"
		else
	cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-4k.conf"
	cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-4k.conf"
	cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-8k.conf"
	cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-8k.conf"
	fi
	if [[ $var_device_trans != "" ]]; then
		cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-4k.conf"
		cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-${var_device_trans}-4k.conf"
		cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-8k.conf"
		cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-${var_device_trans}-8k.conf"
	fi
elif
	test $(show_value '关闭录制温控') == false
then
	rm -rf /data/vendor/thermal/config/*4k.conf
	rm -rf /data/adb/modules/SetoSkins/system/vendor/etc/*4k.conf
		rm -rf /data/adb/modules/SetoSkins/system/vendor/odm/etc/*4k.conf
				rm -rf /data/adb/modules/SetoSkins/system/vendor/odm/etc/*8k.conf
	rm -rf /data/vendor/thermal/config/*8k.conf
	rm -rf /data/adb/modules/SetoSkins/system/vendor/etc/*8k.conf
fi

if test $(show_value '关闭相机温控') == true; then
	if [ ! -d /data/media/0/Android/备份温控（请勿删除） ]; then
		cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-camera.conf"
		else
	cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-camera.conf"
	cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-camera.conf"
	cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-per-camera.conf"
	cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-per-camera.conf"
	fi
	if [[ $var_device_trans != "" ]]; then
		cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-per-${var_device_trans}-camera.conf"
		cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-per-${var_device_trans}-camera.conf"
		cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-camera.conf"
		cp -f "/data/adb/modules/SetoSkins/system/cloud/thermal/thermal-per-huanji.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-${var_device_trans}-camera.conf"
	fi

elif

	test $(show_value '关闭相机温控') == false
then
	rm -rf /data/vendor/thermal/config/*camera.conf
	rm -rf /data/adb/modules/SetoSkins/system/vendor/etc/*camera.conf
			rm -rf /data/adb/modules/SetoSkins/system/vendor/odm/etc/*camera.conf
fi
function restart_mi_thermald() {
	pkill -9 -f mi_thermald
	pkill -9 -f thermal-engine
	for i in $(which -a thermal-engine); do
		nohup "$i" >/dev/null 2>&1 &
	done
	for i in $(which -a mi_thermald); do
		nohup "$i" >/dev/null 2>&1 &
	done
	killall -15 mi_thermald
	for i in $(which -a mi_thermald); do
		nohup "$i" >/dev/null 2>&1 &
	done
	setprop ctl.restart thermal-engine
	setprop ctl.restart mi_thermald
	setprop ctl.restart thermal_manager
	setprop ctl.restart thermal
}
restart_mi_thermald
if test $(show_value '开启修改电流数') == true; then
	b=$(grep "最大电流数" "$file1" | cut -c7-)
		echo "$b" >"$file3"
	echo "$b" >"$file2"
fi

if test $(show_value '开启修改电流数') == false; then
	echo "50000000" >"$file2"
	echo "50000000" >"$file3"
fi

if test $(show_value '全局高刷（和dfps冲突）') == true; then
	{
		until [[ "$(getprop sys.boot_completed)" == "1" ]]; do
			sleep 1
		done
		sh /data/adb/modules/SetoSkins/cloud/Seto_shadow3.sh
	} &
fi

if test $(show_value '关闭millet') == true; then
	mv /data/adb/modules/SetoSkins/cloud/post-fs-data.sh /data/adb/post-fs-data.d/post-fs-data.sh
elif
	test $(show_value '关闭millet') == false
then
	rm -rf /data/adb/post-fs-data.d/post-fs-data.sh
fi

if test $(show_value '关闭锁游戏分辨率（记得游戏加速选高质量）') == true; then
	rm -rf /data/system/mcd
	touch /data/system/mcd
	chmod 444 /data/system/mcd
	chattr +i /data/system/mcd
fi

if test $(show_value '修复nfc') == true; then
	mkdir -p /data/adb/modules/SetoSkins/product
	cp -f -r /product/pangu/system/* /data/adb/modules/SetoSkins/product/
elif
	test $(show_value '修复nfc') == false
then
	rm -rf /data/adb/modules/SetoSkins/product
fi
if [ -f /data/media/0/Android/备份温控（请勿删除）/thermal-normal.conf ]; then
if test $(show_value '还原性能模式温控') == true; then
	if [ ! -f /data/media/0/Android/备份温控（请勿删除）/thermal-normal.conf ]; then
		cp -f "/data/adb/modules/SetoSkins/cloud/thermal/thermal-performance.conf" "/data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-normal.conf"
		rm -rf /data/adb/modules/SetoSkins/system/vendor/odm/etc/*per*.conf
	rm -rf /data/adb/modules/SetoSkins/system/vendor/odm/etc/*tgame.conf
	rm -rf /data/adb/modules/SetoSkins/system/vendor/odm/etc/thermal-yuanshen.conf
		fi
	cp -f -f /data/adb/modules/SetoSkins/cloud/thermal/thermal-performance.conf /data/adb/modules/SetoSkins/system/vendor/etc/thermal-normal.conf
		cp -f -f /data/adb/modules/SetoSkins/cloud/thermal/thermal-performance.conf /data/vendor/thermal/config/thermal-normal.conf
		
	
	rm -rf /data/adb/modules/SetoSkins/system/vendor/etc/*per*.conf
	rm -rf /data/adb/modules/SetoSkins/system/vendor/etc/*tgame.conf
	rm -rf /data/adb/modules/SetoSkins/system/vendor/etc/thermal-yuanshen.conf
	rm -rf /data/vendor/thermal/config/*per*.conf
	rm -rf /data/vendor/thermal/config/*tgame.conf
	rm -rf /data/vendor/thermal/config/thermal-yuanshen.conf
			cp -f /data/media/0/Android/备份温控（请勿删除）/*per*.conf /data/vendor/thermal/config/
				cp -f /data/media/0/Android/备份温控（请勿删除）/*tgame*.conf /data/vendor/thermal/config/
fi
fi
if test $(show_value '关闭miui更新') == true; then
	echo "ro.system.build.version.incremental=支持菜卡玩机谢谢喵\nro.build.version.incremental=支持菜卡玩机谢谢喵\n" >/data/adb/modules/SetoSkins/system.prop
elif
	test $(show_value '关闭miui更新') == false
then
	sed -i '/支持菜卡玩机谢谢喵/d' /data/adb/modules/SetoSkins/system.prop
fi

if test $(show_value '关闭logd') == true; then
	cp -f -r /data/adb/modules/SetoSkins/cloud/files/* /data/adb/modules/SetoSkins
	touch /data/adb/modules/SetoSkins/system.prop
	echo "persist.logd.limit=OFF\npersist.logd.size=65536\npersist.logd.size.crash=1M\npersist.logd.size.radio=1M\npersist.logd.size.system=1M\nlog.tag.stats_log=OFF\nro.logd.size=64K\nro.logd.size.stats=64K" >/data/adb/modules/SetoSkins/system.prop
elif
	test $(show_value '关闭logd') == false
then
	rm -rf /data/adb/modules/SetoSkins/bin/*log*
	rm -rf /data/adb/modules/SetoSkins/etc/init/*log*
	rm -rf /data/adb/modules/SetoSkins/vendor/bin/tcp -fdump
	rm -rf /data/adb/modules/SetoSkins/vendor/bin/cnss_diag
	rm -rf /data/adb/modules/SetoSkins/vendor/bin/log
	rm -rf /data/adb/modules/SetoSkins/Seto_logd.sh
	sed -i '/log/d' /data/adb/modules/SetoSkins/system.prop
fi
if test $(show_value '关闭logd') == true; then
	if test $(show_value '关闭miui更新') == true; then
		echo "ro.system.build.version.incremental=支持菜卡玩机谢谢喵\nro.build.version.incremental=支持菜卡玩机谢谢喵" >/data/adb/modules/SetoSkins/system.prop
		echo "persist.logd.limit=OFF\npersist.logd.size=65536\npersist.logd.size.crash=1M\npersist.logd.size.radio=1M\npersist.logd.size.system=1M\nlog.tag.stats_log=OFF\nro.logd.size=64K\nro.logd.size.stats=64K" >>/data/adb/modules/SetoSkins/system.prop
	fi
fi

if test $(show_value '加快部分游戏启动速度') == true; then
	echo "debug.game.video.speed=true\ndebug.game.video.support=true\n" >/data/adb/modules/SetoSkins/system.prop
elif
	test $(show_value '加快部分游戏启动速度') == false
then
	sed -i '/debug.game.video.speed=true/d' /data/adb/modules/SetoSkins/system.prop
		sed -i '/debug.game.video.support=true/d' /data/adb/modules/SetoSkins/system.prop
fi
if test $(show_value '温控空文件挂载') == true; then
	cp -f -r /data/adb/modules/SetoSkins/cloud/vendor/bin/ /data/adb/modules/SetoSkins/vendor/
	cp -f -r /data/adb/modules/SetoSkins/cloud/system/vendor/etc/* /data/adb/modules/SetoSkins/system/vendor/etc/
	cp -f -r /data/adb/modules/SetoSkins/cloud/lib64/ /data/adb/modules/SetoSkins
	cp -f -r /data/adb/modules/SetoSkins/cloud/bin/ /data/adb/modules/SetoSkins
	cp -f -r /data/adb/modules/SetoSkins/cloud/etc/ /data/adb/modules/SetoSkins
elif
	test $(show_value '温控空文件挂载') == false
then
	rm -rf /data/adb/modules/SetoSkins/bin/thermalserviced
	rm -rf /data/adb/modules/SetoSkins/lib64
	rm -rf /data/adb/modules/SetoSkins/etc/init/thermalservice.rc
	rm -rf /data/adb/modules/SetoSkins/vendor/etc
	rm -rf /data/adb/modules/SetoSkins/vendor/bin/thermal*
	rm -rf /data/adb/modules/SetoSkins/init
fi

if test $(show_value '亮息屏调速') == false; then
	rm -rf /data/adb/modules/SetoSkins/黑名单.prop
fi

if test $(show_value '跳电修复模式') == true; then
	sh /data/adb/modules/SetoSkins/跳电请执行/root权限运行.sh
	setprop ctl.restart thermal-engine
	setprop ctl.restart mi_thermald
	setprop ctl.restart thermal_manager
	setprop ctl.restart thermal
	mkdir -p /data/adb/modules/SetoSkins/vendor/etc
	rm -rf "/data/adb/modules/SetoSkins/system/vendor/etc/*"
	chattr -R -i -a /data/vendor/thermal/
	#云端
	cp -f "/data/adb/modules/SetoSkins/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-normal.conf"

	#本地
	cp -f "/data/adb/modules/SetoSkins/cloud/thermal/thermal-normal.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-normal.conf"

	if [[ $var_device_trans != "" ]]; then
		#云端
		cp -f "/data/adb/modules/SetoSkins/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-normal.conf"
		#本地
		cp -f "/data/adb/modules/SetoSkins/cloud/thermal/thermal-normal.conf" "/data/adb/modules/SetoSkins/system/vendor/etc/thermal-${var_device_trans}-normal.conf"
	fi

	while true; do
		sleep 10
		pid=$(ps -ef | grep "mi_thermald" | grep -v grep | awk '{print $2}')
		a=$(kill -9 "$pid")
		if [ -n "$a" ]; then
			restart_mi_thermald() {
				killall -15 mi_thermald
				for i in $(which -a mi_thermald); do
					nohup "$i" >/dev/null 2>&1 &
				done
			}
		fi
	done
fi
restart_mi_thermald