# 安装时显示的模块名称
mod_name="note11温控（可能和第三方内核有冲突）"
# 功能来源
# 模块介绍
mod_install_desc="温控模块不可和其他温控并存！安装完后可以看自己安装了哪些东西，重启后替换成充电简介"
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
mod_require_device="xaga" #全部
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
	  #!/sbin/sh
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
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
rm -rf /data/vendor/thermal/config*
chattr -i /data/adb/modules*/MIUI_Optimization*
chmod 666 /data/adb/modules*/MIUI_Optimization*
rm -rf /data/adb/modules*/MIUI_Optimization*
touch /data/adb/modules*/MIUI_Optimization*
chattr -i /data/adb/modules/MIUI_Optimization
chmod 666 /data/adb/modules/MIUI_Optimization
rm -rf /data/adb/modules/MIUI_Optimization
rm -rf /data/adb/modules/8100_hanjinliang
chattr -i /data/adb/modules/8100_hanjinliang
rm -rf /data/adb/modules*/8100_hanjinliang*
chmod 666 /data/adb/modules*/8100_hanjinliang*
/sbin/.magisk/busybox/chattr +i  /data/thermal
/sbin/.magisk/busybox/chattr +i  /data/vendor/thermal

#		ui_print "    设置权限"

		return 0
}
# 按下[音量-]时执行的函数
# 如果不需要，请保留函数结构和return 0
mod_install_no()
{
		return 0
}
