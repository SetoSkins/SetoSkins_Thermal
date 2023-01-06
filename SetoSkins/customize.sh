MODDIR=${0%/*}
  status=$(cat /sys/class/power_supply/battery/status)
  current=$(cat /sys/class/power_supply/battery/current_now)
  if [[ $status == "Charging" ]]
  then
    ui_print "! 请拔出充电器再安装!"
    exit 1
  fi
  if [[ $current -lt 0 ]]
  then
    ui_print "! 检测到与作者测试手机相反的电流极性!"
    ui_print "! 需要将/data/adb/modules/SetoSkins/system/下的minus的值改为1"
    ui_print "! 否则模块将显示相反的电流值"
    sleep 5
  fi
if [ ! -d "/data/media/0/Android/备份温控（请勿删除）" ];then
echo "- 这应该是你第一次安装本模块请看好说明"
mkdir -p /data/media/0/Android/备份温控（请勿删除）
cp $(find /system/vendor/etc/ -type f -iname "thermal*.conf*" | grep -v /system/vendor/etc/thermal/) /data/media/0/Android/备份温控（请勿删除）
else
echo "- 检测到有备份温控 鉴定为更新模块"
fi
chattr -i /data/vendor/thermal/
rm -rf /data/vendor/thermal/config*
	[[ -d /data/vendor/thermal ]] && chattr -i /data/vendor/thermal/
	rm -rf /data/vendor/thermal/config*
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
    ui_print "- 性能模式为默认温控"
	ui_print "- 作者酷安@SetoSkins 感谢@shadow3 @nakixii @柚稚的孩纸 @向晚今天吃了咩 @灵聚丶神生 @代号10007"
	sleep 5
	rm -rf /data/system/package_cache/*
	ui_print "- 缓存清理完毕"
coolapkTesting=`pm list package | grep -w 'com.coolapk.market'`
if [[ "$coolapkTesting" != "" ]];then
am start -d 'coolmarket://u/5562122' >/dev/null 2>&1
fi