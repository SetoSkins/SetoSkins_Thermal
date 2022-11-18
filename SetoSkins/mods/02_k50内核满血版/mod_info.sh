# 安装时显示的模块名称
mod_name="干掉k50的所有温控（适合pandora的内核）"
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
mod_require_device="rubens" #全部
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
rm -rf /data/system/batterystats.bin
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
