#!/system/bin/sh
status=$(cat /sys/class/power_supply/battery/status)
current=$(cat /sys/class/power_supply/battery/current_now)
if [ -f "/data/adb/service.d/seto.sh" ]; then
	echo "- 检测到有残留文件 正在处理 请耐心等待"
	for i in $(seq 72); do
		if [ -f "/data/adb/service.d/seto.sh" ]; then
			sleep 1
		elif
			[ ! -f "/data/adb/service.d/seto.sh" ]
		then
			break
		fi
	done
fi
echo "- 如果温控没有用或者降亮度问题，可以在配置里把温控空文件挂载打开。"
echo "😋😋😋😋😋😋😋😋😋😋😋😋😋😋"
echo "- 2023.3.11 新功能 亮屏锁屏限制电流"
echo "- 2023.3.26 新功能 分应用限流"
echo "- 2023.6.13 回归功能 电量停冲的电流检测"
echo "- 2023.7.30 增加三限温度电流"
echo "- 2023.8.13 增加还原性能模式温控选项"
echo "- 2023.8.13 增加性能温控选项"
echo "- 2023.9.26 增加充电Log开关选项"
echo "😋😋😋😋😋😋😋😋😋😋😋😋😋😋"
sleep 5
key_check() {
  while true; do
    key_check=$(/system/bin/getevent -qlc 1)
    key_event=$(echo "$key_check" | awk '{ print $3 }' | grep 'KEY_')
    key_status=$(echo "$key_check" | awk '{ print $4 }')
    if [[ "$key_event" == *"KEY_"* && "$key_status" == "DOWN" ]]; then
      keycheck="$key_event"
      break
    fi
  done
  while true; do
    key_check=$(/system/bin/getevent -qlc 1)
    key_event=$(echo "$key_check" | awk '{ print $3 }' | grep 'KEY_')
    key_status=$(echo "$key_check" | awk '{ print $4 }')
    if [[ "$key_event" == *"KEY_"* && "$key_status" == "UP" ]]; then
      break
    fi
  done
}
Reserve() {
	echo "- 是否保留之前配置"
	echo "- 如果保留则无法使用到最新功能"
	echo "- 音量上键为保留"
	echo "- 音量下键为取消"
key_check
 case "$keycheck" in
  "KEY_VOLUMEUP")
		echo "- 确认保留"
		sleep 1
		cp /data/adb/modules/SetoSkins/配置.prop /data/media/0/Android/备份温控（请勿删除）/配置.prop
		cp /data/adb/modules/SetoSkins/黑名单.prop /data/media/0/Android/备份温控（请勿删除）/黑名单.prop
		if [ ! -f "/data/media/0/Android/备份温控（请勿删除）/配置.prop" ]; then
			echo "- 正在持续写入保留配置文件 请耐心等待"
			for i in $(seq 1 60); do
				sleep 1
				if [ ! -f "/data/media/0/Android/备份温控（请勿删除）/配置.prop" ]; then
					cp /data/adb/modules/SetoSkins/配置.prop /data/media/0/Android/备份温控（请勿删除）/配置.prop
					if [ -f "/data/media/0/Android/备份温控（请勿删除）/配置.prop" ]; then
						break
					fi
				fi
			done
		fi
		if [ ! -f "/data/media/0/Android/备份温控（请勿删除）/黑名单.prop" ]; then
			echo "- 正在持续写入保留配置文件 请耐心等待"
			for i in $(seq 1 60); do
				sleep 1
				if [ ! -f "/data/media/0/Android/备份温控（请勿删除）/黑名单.prop" ]; then
					cp /data/adb/modules/SetoSkins/黑名单.prop /data/media/0/Android/备份温控（请勿删除）/黑名单.prop
					if [ -f "/data/media/0/Android/备份温控（请勿删除）/黑名单.prop" ] || [ ! -f "/data/adb/modules/SetoSkins/黑名单.prop" ]; then
						break
					fi
				fi
			done
		fi
		;;
	*)
		echo "- 取消保留"
		;;
	esac
}
if [ -d "/data/media/0/Android/备份温控（请勿删除）" ]; then
	echo "- 检测到有备份温控 鉴定为更新模块"
Reserve
else
	echo "- 第一次安装本模块请看好说明"
fi
chattr -i /data/vendor/thermal/
[[ -d /data/vendor/thermal ]] && chattr -i /data/vendor/thermal/
rm -rf /data/vendor/thermal/config/*

for i in $(find /data/adb/modules* -name module.prop); do
	module_id=$(cat $i | grep "id=" | awk -F= '{print $2}')
	if [[ $module_id =~ "MIUI_Optimization" ]]; then
		chattr -i /data/adb/modules*/MIUI_Optimization*
		chmod 666 /data/adb/modules*/MIUI_Optimization*
		rm -rf /data/adb/modules*/MIUI_Optimization*
		touch /data/adb/modules*/MIUI_Optimization*
		chattr -i /data/adb/modules/MIUI_Optimization
	fi
done

for i in $(find /data/adb/modules* -name module.prop); do
	module_id=$(cat $i | grep "id=" | awk -F= '{print $2}')
	if [[ $module_id =~ "chargeauto" ]]; then
		chattr -i /data/adb/modules*/chargeauto*
		chmod 666 /data/adb/modules*/chargeauto*
		rm -rf /data/adb/modules*/chargeauto*
		touch /data/adb/modules*/chargeauto*
		chattr -i /data/adb/modules/chargeauto
	fi
done

for i in $(find /data/adb/modules* -name module.prop); do
	module_id=$(cat $i | grep "id=" | awk -F= '{print $2}')
	if [[ $module_id =~ "fuck_miui_thermal" ]]; then
		chattr -i /data/adb/modules*/fuck_miui_thermal*
		chmod 666 /data/adb/modules*/fuck_miui_thermal*
		rm -rf /data/adb/modules*/fuck_miui_thermal*
		touch /data/adb/modules*/fuck_miui_thermal*
		chattr -i /data/adb/modules/fuck_miui_thermal
	fi
done
for i in $(find /data/adb/modules* -name module.prop); do
	module_id=$(cat $i | grep "id=" | awk -F= '{print $2}')
	if [[ $module_id =~ "MIUI_Optimization" ]]; then
		chattr -i /data/adb/modules*/MIUI_Optimization*
		chmod 666 /data/adb/modules*/MIUI_Optimization*
		rm -rf /data/adb/modules*/MIUI_Optimization*
		touch /data/adb/modules*/MIUI_Optimization*
		chattr -i /data/adb/modules/MIUI_Optimization
	fi
done

for i in $(find /data/adb/modules* -name module.prop); do
	module_id=$(cat $i | grep "id=" | awk -F= '{print $2}')
	if [[ $module_id =~ "chargeauto" ]]; then
		chattr -i /data/adb/modules*/chargeauto*
		chmod 666 /data/adb/modules*/chargeauto*
		rm -rf /data/adb/modules*/chargeauto*
		touch /data/adb/modules*/chargeauto*
		chattr -i /data/adb/modules/chargeauto
	fi
done

for i in $(find /data/adb/modules* -name module.prop); do
	module_id=$(cat $i | grep "id=" | awk -F= '{print $2}')
	if [[ $module_id =~ "He_zheng" ]]; then
		chattr -i /data/adb/modules*/He_zheng*
		chmod 666 /data/adb/modules*/He_zheng*
		rm -rf /data/adb/modules*/He_zheng*
		touch /data/adb/modules*/He_zheng*
		chattr -i /data/adb/modules/He_zheng
	fi
done
for i in $(find /data/adb/modules* -name module.prop); do
	module_id=$(cat $i | grep "id=" | awk -F= '{print $2}')
	if [[ $module_id =~ "turbo-charge" ]]; then
		chattr -i /data/adb/modules*/turbo-charge*
		chmod 666 /data/adb/modules*/turbo-charge*
		rm -rf /data/adb/modules*/turbo-charge*
		touch /data/adb/modules*/turbo-charge*
		chattr -i /data/adb/modules/turbo-charge
	fi
done
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
function mk_thermal_folder() {
	resetprop -p sys.thermal.data.path /data/vendor/thermal/
	resetprop -p vendor.sys.thermal.data.path /data/vendor/thermal/
	chattr -R -i -a '/data/vendor/thermal'
	rm -rf '/data/vendor/thermal'
	mkdir -p '/data/vendor/thermal/config'
	chmod -R 0771 '/data/vendor/thermal'
	chown -R root:system '/data/vendor/thermal'
	chcon -R 'u:object_r:vendor_data_file:s0' '/data/vendor/thermal'
}
mk_thermal_folder
if [ ! -f /data/vendor/thermal/decrypt.txt ];then
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
fi
ui_print "- 充电日志和模块配置在模块根目录里面（/data/adb/modules/SetoSkins/）"
ui_print "- 本模块自动清除常见冲突模块"
ui_print "- 作者菜卡@SetoSkins 感谢@shadow3 @nakixii @柚稚的孩纸 @灵聚丶神生 @代号10007"
thanox=$(find /data/system/ -type d -name 'thanos*')
if [ -d "$thanox" ]; then
	echo "- 已装thanox"
	chmod 777 /data/system/*thanos*
	if [ ! -d $thanox/profile_user_io ]; then
		echo "- 未识别到 profile_user_io"
		echo "- 正在创建 profile_user_io"
		mkdir -v $thanox/profile_user_io
	fi
fi
rm -rf /data/system/package_cache/*
ui_print "- 缓存清理完毕"
rm -rf /data/media/0/Seto.zip
rm -rf /data/Seto.zip
coolapkTesting=$(pm list package | grep -w 'com.coolapk.market')
if [ ! -d "/data/media/0/Android/备份温控（请勿删除）" ]; then
	sleep 8

	mkdir -p /data/media/0/Android/备份温控（请勿删除）
	cp $(find /system/vendor/etc/ -type f -iname "thermal*.conf*" | grep -v /system/vendor/etc/thermal/) /data/media/0/Android/备份温控（请勿删除）

	am start -a 'android.intent.action.VIEW' -d 'https://hub.cdnet.run/' >/dev/null 2>&1
fi
