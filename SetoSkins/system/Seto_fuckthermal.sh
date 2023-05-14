#!/system/bin/sh
MODDIR=${0%/*}
alias sh='/system/bin/sh'
var_device=$(getprop ro.product.device)
status=$(cat /sys/class/power_supply/battery/status)
capacity=$(cat /sys/class/power_supply/battery/capacity)
temp=$(expr $(cat /sys/class/power_supply/battery/temp) / 10)
ChargemA=$(expr $(cat /sys/class/power_supply/battery/current_now) / -1000)
a=$(getprop ro.system.build.version.release)
mv "$MODDIR"/执行作者QQ.sh /data/adb/modules/SetoSkins/
mv "$MODDIR"/更新链接.sh /data/adb/modules/SetoSkins/
mv "$MODDIR"/FAQ.prop /data/adb/modules/SetoSkins/
mv $MODDIR/跳电请执行 /data/adb/modules/SetoSkins/
file1=/data/adb/modules/SetoSkins/配置.prop
int=$(cat /data/adb/modules/SetoSkins/system/节点.prop | sed -n '1p')
int2=$(cat /data/adb/modules/SetoSkins/system/节点.prop | sed -n '2p')
show_value() {
	value=$1
	file=/data/adb/modules/SetoSkins/配置.prop
	cat "${file}" | grep -E "(^$value=)" | sed '/^#/d;/^[[:space:]]*$/d;s/.*=//g' | sed 's/，/,/g;s/——/-/g;s/：/:/g' | head -n 1
}
mkdir -p $MODDIR/vendor/etc
chattr -R -i -a /data/vendor/thermal/
rm -rf "$MODDIR"/vendor/etc/*
rm -rf /data/vendor/thermal/config/*
#云端
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
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-normal.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-class0.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-nolimits.conf.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-tgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-mgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-video.conf"
	#本地
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-normal.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-class0.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-nolimits.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-tgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-mgame.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-video.conf"
fi

chmod 777 /sys/class/thermal/thermal_message/sconfig

if test $(show_value '关闭录制4K温控') == true; then
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-4k.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-4k.conf"
	if [[ $var_device_trans != "" ]]; then
		cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-4k.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-4k.conf"
	fi
elif
	test $(show_value '关闭录制4K温控') == false
then
	rm -rf /data/vendor/thermal/config/thermal-4k.conf
	rm -rf $MODDIR/vendor/etc/thermal-4k.conf
	rm -rf  $MODDIR/vendor/etc/thermal-l16u-4k.conf
	rm -rf /data/vendor/thermal/config/thermal-l16u-4k.conf
	rm -rf  $MODDIR/vendor/etc/thermal-k1a-4k.conf
	rm -rf /data/vendor/thermal/config/thermal-k1a-4k.conf
fi

if test $(show_value '关闭相机温控') == true; then
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-camera.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-camera.conf"
		if [[ $var_device_trans != "" ]]; then
			cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-camera.conf"
	cp "$MODDIR/cloud/thermal/thermal-per-huanji.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-camera.conf"
	fi
	
elif

	test $(show_value '关闭相机温控') == false
then
	rm -rf /data/vendor/thermal/config/thermal-camera.conf
	rm -rf $MODDIR/vendor/etc/thermal-camera.conf
		rm -rf  $MODDIR/vendor/etc/thermal-l16u-camera.conf
	rm -rf /data/vendor/thermal/config/thermal-l16u-camera.conf
	rm -rf  $MODDIR/vendor/etc/thermal-k1a-camera.conf
	rm -rf /data/vendor/thermal/config/thermal-k1a-camera.conf
fi

if test $(show_value '开启修改电流数') == true; then
	b=$(grep "最大电流数" "$file1" | cut -c7-)
	echo "$b" >"$int"
	echo "$b" >"$int2"
	echo "$b" >/sys/class/power_supply/battery/constant_charge_current
	echo "$b" >/sys/devices/platform/battery/power_supply/battery/fast_charge_current
	echo "$b" >/sys/devices/platform/battery/power_supply/battery/thermal_input_current
	echo "$b" >/sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	echo "$b" >/sys/devices/platform/mt_charger/power_supply/usb/current_max
	echo "$b" >/sys/firmware/devicetree/base/charger/current_max
	echo "$b" >/sys/class/power_supply/battery/constant_charge_current_max
	echo "$b" >/sys/class/power_supply/battery/fast_charge_current
	echo "$b" >/sys/class/power_supply/battery/current_max
fi

if test $(show_value '开启修改电流数') == false; then
	echo "50000000" >"$int"
	echo "50000000" >"$int2"
	echo "50000000" >/sys/class/power_supply/battery/constant_charge_current
	echo "50000000" >/sys/class/power_supply/battery/fast_charge_current
	echo "50000000" >/sys/class/power_supply/battery/current_max
	echo "50000000" >/sys/class/power_supply/battery/constant_charge_current_max
	echo "50000000" >/sys/devices/platform/battery/power_supply/battery/fast_charge_current
	echo "50000000" >/sys/devices/platform/battery/power_supply/battery/thermal_input_current
	echo "50000000" >/sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	echo "50000000" >/sys/devices/platform/mt_charger/power_supply/usb/current_max
	echo "50000000" >/sys/firmware/devicetree/base/charger/current_max
fi

if test $(show_value '全局高刷（和dfps冲突）') == true; then
	{
		until [[ "$(getprop sys.boot_completed)" == "1" ]]; do
			sleep 1
		done
		sh $MODDIR/cloud/Seto_shadow3.sh
	} &
fi

if test $(show_value '关闭millet') == true; then
	mv $MODDIR/cloud/post-fs-data.sh /data/adb/post-fs-data.d/post-fs-data.sh
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
	mkdir -p $MODDIR/product
	cp -r /product/pangu/system/* $MODDIR/product/
elif
	test $(show_value '修复nfc') == false
then
	rm -rf $MODDIR/product
fi

if test $(show_value '关闭miui更新') == true; then
	echo "ro.system.build.version.incremental=酷安关注@SetoSkins\nro.build.version.incremental=酷安关注@SetoSkins\n" >/data/adb/modules/SetoSkins/system.prop
elif
	test $(show_value '关闭miui更新') == false
then
	sed -i '/酷安关注@SetoSkins/d' /data/adb/modules/SetoSkins/system.prop
fi

if test $(show_value '关闭logd') == true; then
	cp -r $MODDIR/cloud/files/* $MODDIR
	touch /data/adb/modules/SetoSkins/system.prop
	echo "persist.logd.limit=OFF\npersist.logd.size=65536\npersist.logd.size.crash=1M\npersist.logd.size.radio=1M\npersist.logd.size.system=1M\nlog.tag.stats_log=OFF\nro.logd.size=64K\nro.logd.size.stats=64K" >/data/adb/modules/SetoSkins/system.prop
elif
	test $(show_value '关闭logd') == false
then
	rm -rf $MODDIR/bin
	rm -rf $MODDIR/etc
	rm -rf $MODDIR/vendor
	rm -rf $MODDIR/Seto_logd.sh
	sed -i '/log/d' /data/adb/modules/SetoSkins/system.prop
fi
if test $(show_value '关闭logd') == true; then
	if test $(show_value '关闭miui更新') == true; then
		echo "ro.system.build.version.incremental=酷安关注@SetoSkins\nro.build.version.incremental=酷安关注@SetoSkins" >/data/adb/modules/SetoSkins/system.prop
		echo "persist.logd.limit=OFF\npersist.logd.size=65536\npersist.logd.size.crash=1M\npersist.logd.size.radio=1M\npersist.logd.size.system=1M\nlog.tag.stats_log=OFF\nro.logd.size=64K\nro.logd.size.stats=64K" >>/data/adb/modules/SetoSkins/system.prop
	fi
fi

if test $(show_value '温控空文件挂载') == true; then
	cp -r $MODDIR/cloud/vendor/bin $MODDIR/vendor
	cp -r $MODDIR/cloud/lib64/ $MODDIR
	cp -r $MODDIR/cloud/bin/ $MODDIR
	cp -r $MODDIR/cloud/etc/ $MODDIR
elif
	test $(show_value '温控空文件挂载') == false
then
	rm -rf $MODDIR/bin/thermalserviced
	rm -rf $MODDIR/lib64
	rm -rf $MODDIR/etc/int/thermalservice.rc
	rm -rf $MODDIR/vendor/bin/thermal_factory
	rm -rf $MODDIR/vendor/bin/thermal-engine
	rm -rf $MODDIR/init
fi

if test $(show_value '关闭云控') == true; then
	pm disable com.miui.powerkeeper/com.miui.powerkeeper.feedbackcontrol.abnormallog.ThermalLogService
	pm disable com.miui.powerkeeper/com.miui.powerkeeper.logsystem.LogSystemService
	pm disable com.miui.securitycenter/com.miui.permcenter.root.RootUpdateReceiver
	pm disable com.miui.securitycenter/com.miui.antivirus.receiver.UpdaterReceiver
	pm disable com.miui.powerkeeper/com.miui.powerkeeper.ui.CloudInfoActivity
	pm disable com.miui.powerkeeper/com.miui.powerkeeper.statemachine.PowerStateMachineService
	pm disable com.xiaomi.joyose/com.xiaomi.joyose.cloud.CloudServerReceiver
	pm disable com.xiaomi.joyose/com.xiaomi.joyose.predownload.PreDownloadJobScheduler
	pm disable com.xiaomi.joyose/com.xiaomi.joyose.smartop.gamebooster.receiver.BoostRequestReceiver
elif
	test $(show_value '关闭云控') == false
then
	pm enable com.miui.powerkeeper/com.miui.powerkeeper.feedbackcontrol.abnormallog.ThermalLogService
	pm enable com.miui.powerkeeper/com.miui.powerkeeper.logsystem.LogSystemService
	pm enable com.miui.securitycenter/com.miui.permcenter.root.RootUpdateReceiver
	pm enable com.miui.securitycenter/com.miui.antivirus.receiver.UpdaterReceiver
	pm enable com.miui.powerkeeper/com.miui.powerkeeper.ui.CloudInfoActivity
	pm enable com.miui.powerkeeper/com.miui.powerkeeper.statemachine.PowerStateMachineService
	pm enable com.xiaomi.joyose/com.xiaomi.joyose.JoyoseJobScheduleService
	pm enable com.xiaomi.joyose/com.xiaomi.joyose.cloud.CloudServerReceiver
	pm enable com.xiaomi.joyose/com.xiaomi.joyose.predownload.PreDownloadJobScheduler
	pm enable com.xiaomi.joyose/com.xiaomi.joyose.smartop.gamebooster.receiver.BoostRequestReceiver
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
	mkdir -p $MODDIR/vendor/etc
	rm -rf "$MODDIR"/vendor/etc/*
	chattr -R -i -a /data/vendor/thermal/
	#云端
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-normal.conf"

	#本地
	cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-normal.conf"

	if [[ $var_device_trans != "" ]]; then
		#云端
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "/data/vendor/thermal/config/thermal-${var_device_trans}-normal.conf"
		#本地
		cp "$MODDIR/cloud/thermal/thermal-normal.conf" "$MODDIR/vendor/etc/thermal-${var_device_trans}-normal.conf"
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
