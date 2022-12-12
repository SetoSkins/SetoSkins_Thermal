#!/system/bin/sh
MODDIR=${0%/*}
var_device=$(getprop ro.product.device)
status=$(cat /sys/class/power_supply/battery/status)
capacity=$(cat /sys/class/power_supply/battery/capacity)
temp=$(expr $(cat /sys/class/power_supply/battery/temp) / 10)
ChargemA=$(expr $(cat /sys/class/power_supply/battery/current_now) / -1000)
cp "$MODDIR"/作者QQ捐赠发电用.jpg /data/adb/modules/SetoSkins/
show_value() {
	value=$1
	file=/data/adb/modules/SetoSkins/配置.prop
	cat "${file}" | grep -E "(^$value=)" | sed '/^#/d;/^[[:space:]]*$/d;s/.*=//g' | sed 's/，/,/g;s/——/-/g;s/：/:/g' | head -n 1
}
if test $(show_value '温控配置') == 不保留 && $(show_value '检测mi_thermald丢失自动保活') == true; then
	while true; do
		echo $(date)" 脑瘫就别用我模块了😋" >>"$MODDIR"/log.log
		sed -i "/^description=/c description=脑瘫就别用我模块了😋" "$MODDIR/module.prop"
		echo $(date)" 脑瘫就别用我模块了😋" >>"$MODDIR"/配置.prop
	done
fi
if test $(show_value '温控配置') == 不保留; then
	setprop ctl.stop thermal-engine
	setprop ctl.stop mi_thermald
	setprop ctl.stop thermal_manager
	setprop ctl.stop thermal
	setprop ctl.stop thermald
    mkdir -p $MODDIR/vendor/etc
	chattr -R -i -a /data/vendor/thermal/
	rm -rf "$MODDIR"/vendor/etc/*
	rm -rf /data/vendor/thermal/config/*
	#云端
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/bin/mi_thermal"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-normal.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-class0.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-nolimits.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-tgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-mgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-yuanshen.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-video.conf"

	#本地
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-normal.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc//thermal-class0.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-nolimits.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-tgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-mgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-yuanshen.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-video.conf"
	chmod 777 /sys/class/thermal/thermal_message/sconfig
	if [[ $var_device == "xaga" ]]; then
		#云端
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-nolimits.conf.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-video.conf"
		#本地
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-video.conf"
	fi
	if [[ $var_device == "star" ]]; then
		#云端
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-nolimits.conf.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-video.conf"
		#本地
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-video.conf"
	fi
elif
	test $(show_value '温控配置') == 保留
then
	setprop ctl.restart thermal-engine
	setprop ctl.restart mi_thermald
	setprop ctl.restart thermal_manager
	setprop ctl.restart thermal
	mkdir -p $MODDIR/vendor/etc
	rm -rf "$MODDIR"/vendor/etc/*
	rm -rf /data/vendor/thermal/config/*
	chattr -R -i -a /data/vendor/thermal/
	#云端
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-normal.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-class0.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-nolimits.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-tgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-mgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-yuanshen.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-video.conf"

	#本地
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-normal.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc//thermal-class0.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-nolimits.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-tgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-mgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-yuanshen.conf"
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-video.conf"

	if [[ $var_device == "xaga" ]]; then
		#云端
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-l16u-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-l16u-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-l16u-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-l16u-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-l16u-video.conf"
		#本地
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-l16u-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-l16u-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-l16u-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-l16u-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-l16u-video.conf.conf"
	fi
	if [[ $var_device == "star" ]]; then
		#云端
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-k1a-video.conf"
		#本地
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-normal.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-class0.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-nolimits.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-tgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-k1a-mgame.conf"
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-k1a-video.conf.conf"
	fi
	chmod 777 /sys/class/thermal/thermal_message/sconfig
fi
if test $(show_value '切换云端或本地配置') == 本地; then
	rm -rf /data/vendor/thermal/config/*
elif
	test $(show_value '切换云端或本地配置') == 云端
then
	rm -rf "$MODDIR"/vendor/etc/
fi
if test $(show_value '关闭录制4K温控') == true; then
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-4K.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-4K.conf"
	elif
	test $(show_value '关闭录制4K温控') == false
	then
	rm -rf /data/vendor/thermal/config/thermal-4K.conf
	rm -rf $MODDIR/vendor/etc/thermal-4K.conf
fi
if test $(show_value '关闭相机温控') == true; then
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-camera.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-camera.conf"
	elif
	test $(show_value '关闭相机温控') == false
	then
	rm -rf /data/vendor/thermal/config/thermal-camera.conf
	rm -rf $MODDIR/vendor/etc/thermal-camera.conf
fi
if test $(show_value '开启修改电流数') == true; then
	b=$(grep "最大电流数" "$file" | cut -c6-)
	echo "$b" >/sys/class/power_supply/usb/current_max
	echo "$b" >/sys/class/power_supply/battery/constant_charge_current
fi

if test $(show_value '开启充电调速') == true; then
	cp "$MODDIR/temp_threshold.sh" "/data/adb/service.d/Seto_temp_threshold.sh"
elif
	test $(show_value '开启充电调速') == false
then
	rm -rf /data/adb/service.d/Seto_temp_threshold.sh
fi

if test $(show_value '关闭millet') == true; then
	cp "$MODDIR/cloud/post-fs-data.sh" "/data/adb/modules/SetoSkins/post-fs-data.sh"
elif
	test $(show_value '关闭millet') == false
then
		rm -rf /data/adb/modules/SetoSkins/post-fs-data.sh
		fi
		
if test $(show_value '全局高刷（和dfps冲突miui14自测）') == true; then
	settings put system min_refresh_rate 120
	elif
 test $(show_value '全局高刷（和dfps冲突miui14自测）') == false
 then
	settings put system min_refresh_rate 60
fi
if test $(show_value '魔改电量与性能（部分机型报错无法使用）') == true; then
	mkdir -p $MODDIR/app
	cp -r "$MODDIR/cloud/电量与性能/app/" "$MODDIR"
elif
test $(show_value '魔改电量与性能（部分机型报错无法使用）') == false
then
rm -rf $MODDIR/app/PowerKeeper*
fi
if test $(show_value '魔改joyose') == true; then
	mkdir -p $MODDIR/app
	cp -r "$MODDIR/cloud/joyose/app/" "$MODDIR"
elif
test $(show_value '魔改joyose') == false
then
rm -rf $MODDIR/app/Joyose*
fi