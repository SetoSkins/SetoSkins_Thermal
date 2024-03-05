#!/system/bin/sh
if [ $KSU ]; then
    ui_print "- KSU？我直接取消安装"
    exit 1
fi
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
identify(){
	a=$(getprop ro.product.vendor.brand)
	if [[ ! $a == "Xiaomi" ]] && [[ ! $a == "Redmi" ]]; then
		echo "- 出现无法识别的机型。如果用的是HyperOS或MIUI系统，请选择音量上安装，不是则反之。"
	echo "- 音量上键为安装"
	echo "- 音量下键为取消"
	key_check
  case "$keycheck" in
  "KEY_VOLUMEUP")
       ui_print "- 继续安装"
       ui_print "—————————————————————————"
    ;;
  *)
    ui_print "- 取消安装"
    exit 1
    ;;
  esac
		fi
}

status=$(cat /sys/class/power_supply/battery/status)
current=$(cat /sys/class/power_supply/battery/current_now)
if [ -f "/data/adb/service.d/seto2.sh" ]; then
	echo "- 检测到有残留文件 正在处理 请耐心等待"
	for i in $(seq 60); do
		if [ -f "/data/adb/service.d/seto.sh" ]; then
			sleep 1
		elif
			[ ! -f "/data/adb/service.d/seto.sh" ]
		then
			break
		fi
	done
fi

echo "😋😋😋😋😋😋😋😋😋😋😋😋😋😋"
echo "- 2023.3.11 新功能 亮屏锁屏限制电流"
echo "- 2023.3.26 新功能 分应用限流"
echo "- 2023.6.13 回归功能 电量停冲的电流检测"
echo "- 2023.7.30 增加三限温度电流"
echo "- 2023.8.13 增加还原性能模式温控选项"
echo "- 2023.8.13 增加性能温控选项"
echo "- 2023.9.26 增加充电Log开关选项"
echo "- 2024.3.1 加快部分游戏启动速度"
echo "😋😋😋😋😋😋😋😋😋😋😋😋😋😋"
sleep 0.5
if [ -d "/data/media/0/Android/备份温控（请勿删除）" ]; then
sleep 4
fi
Local() {
echo "- 是否已安装Magisk Delta？"
	echo "- 音量上键为是"
	echo "- 音量下键为否"
key_check
 case "$keycheck" in
  "KEY_VOLUMEUP")
		echo "- 已启用本地+云端配置"
			echo "- 如果选错，请卸载模块并重新安装。"
			ui_print "—————————————————————————"
				sleep 1
		
		touch /data/adb/magisk/Delta.prop
			;;
	*)
		echo "- 已启用云端配置"
			echo "- 如果选错，请卸载模块并重新安装。"
ui_print "—————————————————————————"
				sleep 1
		
		    
		;;
	esac
}
	ui_print "—————————————————————————"
	echo "- 如有温控无效情况，请确保系统版本为最新再进行反馈。"
	echo "- 如果系统版本为最新版本，但依旧出现降亮度，充电慢等情况，可以在配置里把温控空文件挂载打开。"
	ui_print "—————————————————————————"

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
		ui_print "—————————————————————————"
			echo "- 正在持续写入保留配置文件 请耐心等待"
			ui_print "—————————————————————————"
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
		ui_print "—————————————————————————"
			echo "- 正在持续写入保留配置文件 请耐心等待"
			ui_print "—————————————————————————"
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
			sleep 1
		ui_print "—————————————————————————"
		;;
	esac
}
if [ -d "/data/media/0/Android/备份温控（请勿删除）" ]; then
	echo "- 检测到有备份温控 鉴定为更新模块"
Reserve
else
identify
Local
fi
chattr -i /data/vendor/thermal/
[[ -d /data/vendor/thermal ]] && chattr -i /data/vendor/thermal/
rm -rf /data/vendor/thermal/config/*

remove_all_modules() {
  local module_id
  for i in $(find /data/adb/modules* -name module.prop); do
    module_id=$(awk -F= '/id=/ {print $2}' "$i")
    case "$module_id" in
      "MIUI_Optimization" | "chargeauto" | "fuck_miui_thermal" | "MIUI_Optimization" | "He_zheng" | "JE" | "turbo-charge")
        sh "$(dirname $i)/uninstall.sh"
        chattr -i "$(dirname $i)"*
        chmod 666 "$(dirname $i)"*
        rm -rf "$(dirname $i)"*
        touch "$(dirname $i)"*
        chattr -i "$(dirname $i)"
        ;;
    esac
  done
}

# 调用函数
remove_all_modules



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
if [ ! -f /data/vendor/thermal/decrypt.txt ];then
mk_thermal_folder
restart_mi_thermald
fi
ui_print "- 充电日志和模块配置在模块根目录里面（/data/adb/modules/SetoSkins/）"
ui_print "- 本模块自动清除常见冲突模块"
ui_print "- 作者菜卡@SetoSkins 感谢 @SummerSK @shadow3 @nakixii @柚稚的孩纸 @灵聚丶神生 @代号10007"
thanox=$(find /data/system/ -type d -name 'thanos*')
if [ -d "$thanox" ]; then
	echo "- 已装Thanox"
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
if [ ! -f /data/media/0/Android/备份温控（请勿删除）/thermal-normal.conf ];then
	sleep 8

	mkdir -p /data/media/0/Android/备份温控（请勿删除）
	cp $(find /system/vendor/etc/ -type f -iname "thermal*.conf*" | grep -v /system/vendor/etc/thermal/) /data/media/0/Android/备份温控（请勿删除）
if [ ! -f /data/media/0/Android/备份温控（请勿删除）/thermal-normal.conf ];then
rm -rf /data/media/0/Android/备份温控（请勿删除）/*
cp /odm/etc/thermal* /sdcard/Android/备份温控（请勿删除）
fi
	am start -a 'android.intent.action.VIEW' -d 'https://hub.cdnet.run/' >/dev/null 2>&1
fi
