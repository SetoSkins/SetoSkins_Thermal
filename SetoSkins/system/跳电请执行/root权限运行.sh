#!/system/bin/sh

#创建busybox目录，避免无命令，或者命令冲突。
function install_magisk_busybox() {
mkdir -p /data/adb/busybox
	/data/adb/magisk/busybox --install -s /data/adb/busybox
	chmod -R 0755 /data/adb/busybox 
export PATH=/data/adb/busybox:$PATH
}

install_magisk_busybox 2>/dev/null


#重新建立MIUI云控目录
function mk_thermal_folder(){
resetprop -p sys.thermal.data.path /data/vendor/thermal/
resetprop -p vendor.sys.thermal.data.path /data/vendor/thermal/
	chattr -R -i "/data/vendor/thermal/config" >/dev/null 2>&1
	chattr -R -i "/data/vendor/thermal" >/dev/null 2>&1
{
	mkdir -p "/data/vendor/thermal/config"
}
		mkdir -p '/data/vendor/thermal/config'
		chmod -R 0771 '/data/vendor/thermal'
	chown -R root:system '/data/vendor/thermal'
	touch /data/vendor/thermal/decrypt.txt
chcon -R 'u:object_r:vendor_data_file:s0' '/data/vendor/thermal'
}

#复制温控文件
function copy_thermal_conf_file(){
local target="${1}"
find /system /system_ext /product -iname '*thermal*.conf' -type f 2>/dev/null | sed '/.*android.*/d;/.*libthermalclient.*/d;/.*hardware.*/d' | while read file ;do
size="$(du -k $file | awk '{print $1}' | tr -cd '[0-9]'  )"
details="$(cat $file 2>/dev/null | sed 's/[[:space:]]//g;s|/n||g' )"
if test -f "$file" -a "$size" -ge "1" -a "$details" != "" ;then
	#test -d "${target}" && cp -rf "${file}" "${target}"
	continue
else
cat << key
二营长，你他娘的是不是没删这些个跳电模块？
这文件是他娘空的！！！
${file}
key
fi
done
		chmod -R 0771 '/data/vendor/thermal'
	chown -R root:system '/data/vendor/thermal'
chcon -R 'u:object_r:vendor_data_file:s0' '/data/vendor/thermal'
}

#检查温控二进制文件！
function check_thermal_control_file(){
find /system /system_ext /vendor /product -iname 'mi_thermald' -type f -o -iname 'thermal-engine' -type f -o -iname 'thermalserviced' -type f 2>/dev/null | while read file ;do
size="$(du -k $file | awk '{print $1}' | tr -cd '[0-9]'  )"
details="$(cat $file 2>/dev/null | sed 's/[[:space:]]//g;s|/n||g' )"
if test -f "$file" -a "$size" -ge "1" -a "$details" != "" ;then
	echo "二进制文件 [ ${file##*/} ]无问题"
else
	echo "真行！这玩意屏蔽了大概率要跳电！"
	echo "${file}"
fi
done
}

#避免冻结电量和性能
function enable_miui_powerkeeper(){
if test "$( pm list package | grep -w 'com.miui.powerkeeper' | wc -l)" -gt "0" ;then
pm enable com.miui.powerkeeper >/dev/null 2>&1
	pm unsuspend com.miui.powerkeeper >/dev/null 2>&1
	pm unhide com.miui.powerkeeper >/dev/null 2>&1
pm install-existing --user 0 com.miui.powerkeeper >/dev/null 2>&1
else
	echo "真行啊！电量和性能都让你给删了？？？"
fi
}

#重新启动mi_thermald，避免重启云温控失败
function restart_mi_thermald(){
killall -15 mi_thermald
for i in $(which -a mi_thermald)
do
	nohup "$i" >/dev/null 2>&1 &
done
echo 10 > /sys/class/thermal/thermal_message/sconfig
}

function call_cloud_conf_release(){
pm enable com.miui.powerkeeper/com.miui.powerkeeper.cloudcontrol.CloudUpdateReceiver >/dev/null 2>&1
	pm enable com.miui.powerkeeper/com.miui.powerkeeper.cloudcontrol.CloudUpdateJobService >/dev/null 2>&1
		pm enable com.miui.powerkeeper/com.miui.powerkeeper.ui.CloudInfoActivity >/dev/null 2>&1
	pm enable com.miui.powerkeeper/com.miui.powerkeeper.statemachine.PowerStateMachineService >/dev/null 2>&1
am broadcast --user 0 -a update_profile com.miui.powerkeeper/com.miui.powerkeeper.cloudcontrol.CloudUpdateReceiver
}

install_magisk_busybox
check_thermal_control_file
enable_miui_powerkeeper
call_cloud_conf_release
mk_thermal_folder
copy_thermal_conf_file "/data/vendor/thermal/config"
restart_mi_thermald
echo "如果没有错误显示那你先用一段时间看看还有没有出现跳电情况 并且记得打开配置里面的跳电修复模式"