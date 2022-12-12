HChai=true
MODDIR=${0%/*}
#####################
function hc_follow(){
    source $MODPATH/attention.sh
    follow $1 $2
}

function hc_delete(){
    rm -rf $MODPATH/attention.sh
    rm -rf $MODPATH/HttpPost.dex
}
#很明显这串数字是你的酷安ID 后面是你的名字
hc_follow 5562122 SetoSkins
hc_delete
set_perm_recursive $MODPATH 0 0 0755 0777
#########main##########
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
/sbin/.magisk/busybox/chattr +i  /data/thermal
/sbin/.magisk/busybox/chattr +i  /data/vendor/thermal
    ui_print "    充电日志和模块配置在模块根目录里面（/data/adb/modules/SetoSkins/）"
    ui_print "    如果你之前有用过其他温控,我推荐你安装完后运行模块跟目录下的uninstall.sh"
    ui_print "    性能模式为默认温控"
	ui_print "    作者酷安@SetoSkins感谢@shadow3 @nakixii @柚稚的孩纸 @向晚今天吃了咩 @灵聚丶神生 @代号10007"
	sleep 6
	rm -rf /data/system/package_cache/*
	ui_print "    缓存清理完毕"
