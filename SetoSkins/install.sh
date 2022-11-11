# 调试模式标记
DEBUG_FLAG=false

# 自动挂载
SKIPMOUNT=false
# 对应/common/system.prop
PROPFILE=false
# 对应/common/post-fs-data.sh
POSTFSDATA=false
# 对应/common/service.sh
LATESTARTSERVICE=false

# 获取系统信息
var_sdk="$(grep_prop ro.*version.sdk)"
var_brand="$(grep_prop ro.product.*brand)"
var_model="$(grep_prop ro.product.*model)"
var_device="$(getprop ro.product.device)"
var_release="$(grep_prop ro.*version.release)"
var_version="$(grep_prop ro.*version.incremental)"
var_manufacturer="$(grep_prop ro.product.*manufacturer)"

# 设置统一权限
set_permissions() {
	set_perm_recursive $MODPATH 0 0 0755 0755
	chattr -R -i -a /data/adb/modules/SetoSkins/
}

initmods() {
	mod_name=""
	mod_install_info=""
	mod_select_yes_text=""
	mod_select_yes_desc=""
	mod_select_no_text=""
	mod_select_no_desc=""
	mod_require_device=""
	mod_require_version=""
	INSTALLED_FUNC="$(trim $INSTALLED_FUNC)"
	MOD_SKIP_INSTALL=false
	framework=false
	cd $TMPDIR/mods
}
print_modname() {
# 在这里设置你想要在模块安装过程中显示的信息
	ui_print "----------------------------"
	ui_print "  特别感谢@灵聚丶神生@向晚今天吃了咩@柚稚的孩纸""
  "你的机型代号是"`getprop ro.product.device`"
    ui_print "----------------------------"
}
keytest() {
	ui_print "----------------------------"
	ui_print "- 音量键测试 -"
	ui_print "   请按下 [音量+] 键："
	ui_print "   无反应或传统模式无法正确安装时，请触摸一下屏幕后继续。"
	(/system/bin/getevent -lc 1 2>&1 | /system/bin/grep VOLUME | /system/bin/grep " DOWN" >$TMPDIR/events) || return 1
	return 0
}

chooseport() {
	#note from chainfire @xda-developers: getevent behaves weird when piped, and busybox grep likes that even less than toolbox/toybox grep
	while (true); do
		/system/bin/getevent -lc 1 2>&1 | /system/bin/grep VOLUME | /system/bin/grep " DOWN" >$TMPDIR/events
		if ($(cat $TMPDIR/events 2>/dev/null | /system/bin/grep VOLUME >/dev/null)); then
			break
		fi
	done
	if ($(cat $TMPDIR/events 2>/dev/null | /system/bin/grep VOLUMEUP >/dev/null)); then
		return 0
	else
		return 1
	fi
}

chooseportold() {
	# Calling it first time detects previous input. Calling it second time will do what we want
	$KEYCHECK
	$KEYCHECK
	SEL=$?
	$DEBUG_FLAG && ui_print "  调试：选择portold：$1,$SEL"
	if [ "$1" == "UP" ]; then
		UP=$SEL
	elif [ "$1" == "DOWN" ]; then
		DOWN=$SEL
	elif [ $SEL -eq $UP ]; then
		return 0
	elif [ $SEL -eq $DOWN ]; then
		return 1
	else
		abort "   未检测到音量键!"
	fi
}

on_install() {
	ui_print "- Magisk 版本: $MAGISK_VER"
	if [ "$MAGISK_VER_CODE" -lt 24000 ]; then
		ui_print "----------------------------"
		ui_print "! 请安装 Magisk 24.0+"
		abort "----------------------------"
	fi
	# 解压文件
	unzip -o "$ZIPFILE" 'mods/*' -d "$TMPDIR/" >&2
	# 公用函数
	source $TMPDIR/util_funcs.sh

	# Keycheck binary by someone755 @Github, idea for code below by Zappo @xda-developers
	KEYCHECK=$TMPDIR/keycheck
	chmod 755 $KEYCHECK

	#zip
	MYZIP=$TMPDIR/zip
	chmod 755 $MYZIP
	MYTMPDIR=$TMPDIR/tmp

	# 测试音量键
	if keytest; then
		VOLKEY_FUNC=chooseport
		ui_print "----------------------------"
	else
		VOLKEY_FUNC=chooseportold
		ui_print "----------------------------"
		ui_print "- 检测到遗留设备！使用旧的 keycheck 方案"
		ui_print "- 进行音量键录入 -"
		ui_print "   录入：请按下 [音量+] 键："
		$VOLKEY_FUNC "UP"
		ui_print "   已录入 [音量+] 键。"
		ui_print "   录入：请按下 [音量-] 键："
		$VOLKEY_FUNC "DOWN"
		ui_print "   已录入 [音量-] 键。"
		ui_print "----------------------------"
	fi
	# 替换文件夹列表
	REPLACE=""

	# 已安装模块
	MODS_SELECTED_YES=""
	MODS_SELECTED_NO=""

	# 加载可用模块
	initmods
	for MOD in $(ls); do
		if [ -f $MOD/mod_info.sh ]; then
			MOD_FILES_DIR="$TMPDIR/mods/$MOD/files"
			source $MOD/mod_info.sh
			if [ "$(echo $var_device | egrep $mod_require_device)" = "" ]; then
				ui_print "----------------------------"
				ui_print "   [$mod_name]不支持你的设备。"
				ui_print "   帮您阻断一切弱智操作导致温控冲突。"
			elif [ "$(echo $var_version | egrep $mod_require_version)" = "" ]; then
				ui_print "----------------------------"
				ui_print "   [$mod_name]不支持你的系统版本。"
				ui_print "   [$mod_name]支持你的系统版本是[$mod_require_version]。"
			elif [ "$(echo $var_release | egrep $mod_require_release)" = "" ]; then
				ui_print "----------------------------"
				ui_print "   [$mod_name]不支持你的设备版本。"
				ui_print "   [$mod_name]支持你的设备版本是[$mod_require_release]。"
			else
				ui_print "----------------------------"
				ui_print "  [$mod_name]安装"
				ui_print "  - 介绍：$mod_install_desc"
				ui_print "  - 请按音量键选择$mod_install_info -"
				ui_print "   [音量+]：$mod_select_yes_text"
				ui_print "   [音量-]：$mod_select_no_text"
				if $VOLKEY_FUNC; then
					ui_print "   已选择$mod_select_yes_text。"
					mod_install_yes
					run_result=$?
					if [ $run_result -eq 0 ]; then
						MODS_SELECTED_YES="$MODS_SELECTED_YES ($MOD)"
						INSTALLED_FUNC="$mod_select_yes_desc $INSTALLED_FUNC"
					else
						ui_print "   失败。错误：$run_result"
					fi
				else
					ui_print "   已选择$mod_select_no_text。"
					mod_install_no
					run_result=$?
					if [ $run_result -eq 0 ]; then
						MODS_SELECTED_NO="$MODS_SELECTED_NO ($MOD)"
						INSTALLED_FUNC="$mod_select_no_desc $INSTALLED_FUNC"
					else
						ui_print "   失败。错误：$run_result"
					fi
				fi
				run_time
			fi
		fi
		initmods
	done

	if [ -z "$INSTALLED_FUNC" ]; then
		ui_print "未安装任何功能 即将退出安装..."
		rm -rf $TMPDIR
		exit
	fi
	echo "安装时间：[$(date "+%F %T")]	安装的功能: $INSTALLED_FUNC" >>$TMPDIR/module.prop
	[ -d "/storage/emulated/0/Download/"$MODID"_update" ] && rm -rf /storage/emulated/0/Download/"$MODID"_update
	echo -e "打开模块目录如果一些常见的文件还在的话，请返回data/adb/modules/把module.prop复制到模块目录即可。如果出现模块目录下只有一个system，其他文件都消失并且删除不掉模块，请打开data/adb/modules/module.prop执行异常情况解决方案2.sh\nSeto温控链接:" >/data/adb/modules/常见模块问题说明.prop
	echo -e ""id=SetoSkins"\n"name=色图Seto温控"\n"version=17"\n"versionCode=17"\n"author=菜卡@SetoSkins-感谢酷安@灵聚丶神生"\n"description=魔改阶梯充电，充电速度提升，性能模式无温控。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target 默认为22A｜temp_limit是高温降流阀值 current_limit是指定高温降流电流，如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明"\n"updateJson=https://ghproxy.com/https://raw.githubusercontent.com/SetoSKins/wenkong/main/update.json"\n" >/data/adb/modules/module.prop
	echo -e "chattr -R -i -a /data/adb/modules/SetoSkins/\nrm -rf /data/adb/modules/SetoSkins/" >/data/adb/modules/异常情况解决方案2.sh
	ui_print "你选择安装的模块列表在/data/adb/modules/SetoSkins/module.prop里"
	ui_print "请仔细查看模块简介！"
	ui_print "如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明"
	ui_print "作者酷安@SetoSkins"
	sleep 4
	rm -f /data/system/package_cache/*
	ui_print "  缓存清理完毕"
}
