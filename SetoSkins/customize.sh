MODDIR=${0%/*}
set_perm_recursive $MODPATH 0 0 0755 0777
function key_source(){
if test -e "$1" ;then
	source "$1"
	rm -rf "$1"
fi
}
key_source $MODPATH/busybox.sh
test -d $MODPATH/busybox && {
set_perm $magiskbusybox 0 0 0755
chmod -R 0755 $MODPATH/busybox
}
set_perm_recursive $MODPATH/Script 0 0 0755 0755
  status=$(cat /sys/class/power_supply/battery/status)
  current=$(cat /sys/class/power_supply/battery/current_now)
  if [[ $status == "Charging" ]]
  then
    ui_print "- 嘟嘟：笨蛋，先拔出来啊（充电线）"
    exit 1
  fi
  if [[ $current -lt 0 ]]
  then
    ui_print "! 检测到与作者测试手机相反的电流极性!"
    ui_print "! 需要将/data/adb/modules/SetoSkins/system/下的minus的值改为1"
    ui_print "! 否则模块将显示相反的电流值"
    sleep 5
  fi
  Reserve(){
    echo "😋😋😋😋😋😋😋😋😋😋😋😋😋😋"
    echo "- 3月11日 新功能 亮屏锁屏限制电流"
    echo "😋😋😋😋😋😋😋😋😋😋😋😋😋😋"
    echo "- 是否保留之前配置"
    echo "- 如果保留则无法使用到最新功能"
    echo "- 音量上键为保留"
    echo "- 音量下键为取消"
    key_click=""
    while [ "$key_click" = "" ]; do
        key_click="$(getevent -qlc 1 | awk '{ print $3 }' | grep 'KEY_')"
        sleep 0.2
    done
    case "$key_click" in
        "KEY_VOLUMEUP")
            echo "- 确认保留"
            cp /data/adb/modules/SetoSkins/配置.prop /data/media/0/Android/备份温控（请勿删除）/配置.prop
        ;;
        *)
            echo "- 取消保留"
    esac
}
if [ -d "/data/media/0/Android/备份温控（请勿删除）" ];then
echo "- 检测到有备份温控 鉴定为更新模块"
#Reserve
else
echo "- 这应该是你第一次安装本模块请看好说明"
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
function mk_thermal_folder(){
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
    ui_print "- 充电日志和模块配置在模块根目录里面（/data/adb/modules/SetoSkins/）"
    ui_print "- 性能模式为系统默认温控"
    ui_print "- 本模块自动清除常见冲突模块"
	ui_print "- 作者菜卡@SetoSkins 感谢@shadow3 @nakixii @柚稚的孩纸 @向晚今天吃了咩 @灵聚丶神生 @代号10007 @星苒鸭 "
	rm -rf /data/system/package_cache/*
	ui_print "- 缓存清理完毕"
	rm -rf /data/media/0/Seto.zip
	rm -rf /data/Seto.zip
	coolapkTesting=`pm list package | grep -w 'com.coolapk.market'`
		if [ -f "/data/adb/service.d/seto.sh" ];then
echo "- 请耐心等待60秒 检测到有上次的残留文件"
sleep 60
fi
if [ -f "/data/adb/service.d/seto.sh" ];then
rm -rf /data/adb/service.d/seto.sh
rm -rf /data/adb/service.d/seto2.sh
echo "- 请进行重启手机，然后在安装本模块"
exit 0
elif [[ "$coolapkTesting" != "" ]] && [ ! -d "/data/media/0/Android/备份温控（请勿删除）" ] ;then
	sleep 5
mkdir -p /data/media/0/Android/备份温控（请勿删除）
cp $(find /system/vendor/etc/ -type f -iname "thermal*.conf*" | grep -v /system/vendor/etc/thermal/) /data/media/0/Android/备份温控（请勿删除）
am start -d 'coolmarket://u/5562122' >/dev/null 2>&1
fi