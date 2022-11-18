# 安装时显示的模块名称
mod_name="小米12和12S 12X温控"
# 功能来源
# 模块介绍
mod_install_desc="温控模块不可和其他温控并存！安装完后可以看自己安装了哪些东西，重启后替换成充电简介，如果出现跳电情况，并且有时间测试可以加我qq3220565775私聊测试"
# 安装时显示的提示
mod_install_info="是否安装"
# 按下[音量+]选择的功能提示
mod_select_yes_text="安装捏"
# 按下[音量+]后加入module.prop的内容
mod_select_yes_desc="[$mod_name]"
# 按下[音量-]选择的功能提示
mod_select_no_text="不安装"
# 按下[音量-]后加入module.prop的内容
mod_select_no_desc=""
# 支持的设备，支持正则表达式(多的在后面加上|)
mod_require_device="mayfly|daumier|cupid|psyche" #全部
# 支持的系统版本，持正则表达式
mod_require_version=".{0,}" #全部
# 支持的设备版本，持正则表达式
mod_require_release=".{0,}" #全部


# 按下[音量+]时执行的函数
# 如果不需要，请保留函数结构和return 0
mod_install_yes()
{
mkdir -p $MODPATH/system/
		cp -rf $MOD_FILES_DIR/* $MODPATH/system/
		set_perm_recursive  $MODPATH  0  0  0755  0644
#		mkdir -p $MODPATH/system
#		cp -r $MOD_FILES_DIR/system/* $MODPATH/system

		# 附加值到 system.prop
#		add_sysprop ""
		# 从文件附加值到 system.prop
#		add_sysprop_file $MOD_FILES_DIR/system.prop
		# 添加service.sh
		add_service_sh $MOD_FILES_DIR/service.sh
		# 添加post-fs-data.sh
	add_postfsdata_sh $MOD_FILES_DIR/post-fs-data.sh
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
  
  	find /system /system_ext /vendor /product -iname 'mi_thermald' -type f -o -iname 'thermal-engine' -type f -o -iname 'thermalserviced' -type f 2>/dev/null | while read file ;do
size="$(du -k $file | awk '{print $1}' | tr -cd '[0-9]'  )"
details="$(cat $file 2>/dev/null | sed 's/[[:space:]]//g;s|/n||g' )"
if test -f "$file" -a "$size" -ge "1" -a "$details" != "" ;then
	echo "二进制文件 [ ${file##*/} ]无问题"
else
	echo "跳电警告！看看下面这个文件你是不是动了！！！（动了自己处理，不要找我反馈！）"
	echo "${file}"
fi
done

	if test "$( pm list package | grep -w 'com.miui.powerkeeper' | wc -l)" -gt "0" ;then
pm enable com.miui.powerkeeper >/dev/null 2>&1
	pm unsuspend com.miui.powerkeeper >/dev/null 2>&1
	pm unhide com.miui.powerkeeper >/dev/null 2>&1
pm install-existing --user 0 com.miui.powerkeeper >/dev/null 2>&1
else
	echo "电量与性能呢？被你吃了？"
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

		return 0
}

# 按下[音量-]时执行的函数
# 如果不需要，请保留函数结构和return 0
mod_install_no()
{
		return 0
}
