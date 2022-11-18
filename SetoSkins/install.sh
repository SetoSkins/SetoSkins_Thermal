# Magisk多合一模块
# 脚本底包: 酷安@cjybyjk
# 脚本编写: 酷安@董小豪
# 版本: v2.0
# 开: true; 关: false
# 调试模式标记

# 自动挂载
SKIPMOUNT=false
# 对应/common/system.prop
PROPFILE=false
# 对应/common/post-fs-data.sh
POSTFSDATA=false
# 对应/common/service.sh
LATESTARTSERVICE=false
# 替换文件夹列表
REPLACE=""
# 获取系统信息
MODS_PATH="/data/adb/modules"
var_device="$(getprop ro.product.device)"
var_release="$(grep_prop ro.*version.release)"
var_version="$(grep_prop ro.*version.incremental)"

[[ -e /sys/class/power_supply/battery/cycle_count ]] && CYCLE_COUNT="$(cat /sys/class/power_supply/battery/cycle_count) 次" || CYCLE_COUNT="（？）"
[[ -e /sys/class/power_supply/battery/charge_full ]] && Battery_capacity="$(($(cat /sys/class/power_supply/battery/charge_full) / 1000))mAh" || Battery_capacity="（？）"
print_modname() {
	# 在这里设置你想要在模块安装过程中显示的信息
	ui_print "----------------------------"
	ui_print "  特别感谢@灵聚丶神生@向晚今天吃了咩""
  "你的机型代号是"$var_device"
	ui_print "  电池循环次数: $CYCLE_COUNT"
	ui_print "  电池容量: $Battery_capacity"
	ui_print "----------------------------"
}

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
	cd $TMPDIR/mods
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

	# 解压文件
	unzip -o "$ZIPFILE" 'mods/*' -d "$TMPDIR/" >&2
	# 公用函数
	source $TMPDIR/util_funcs.sh

	# Keycheck binary by someone755 @Github, idea for code below by Zappo @xda-developers
	KEYCHECK=$TMPDIR/keycheck
	chmod 755 $KEYCHECK

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
				ui_print "    [音量+]：$mod_select_yes_text"
				ui_print "    [音量-]：$mod_select_no_text"
				if $VOLKEY_FUNC; then
					ui_print "    已选择$mod_select_yes_text。"
					mod_install_yes
					run_result=$?
					if [ $run_result -eq 0 ]; then
						MODS_SELECTED_YES="$MODS_SELECTED_YES ($MOD)"
						INSTALLED_FUNC="$mod_select_yes_desc $INSTALLED_FUNC"
					else
						ui_print "    失败。错误：$run_result"
					fi
				else
					ui_print "    已选择$mod_select_no_text。"
					mod_install_no
					run_result=$?
					if [ $run_result -eq 0 ]; then
						MODS_SELECTED_NO="$MODS_SELECTED_NO ($MOD)"
						INSTALLED_FUNC="$mod_select_no_desc $INSTALLED_FUNC"
					else
						ui_print "    失败。错误：$run_result"
					fi
				fi
			fi
		fi
		initmods
	done

	if [ -z "$INSTALLED_FUNC" ]; then
		ui_print "未安装任何功能 即将退出安装..."
		rm -rf $TMPDIR
		exit
	fi
	#我超,Sutoliu
for i in $(ls $MODS_PATH); do
    if [[ ! -z $(grep author=SutoLiu $MODS_PATH/$i/module.prop) ]]; then
        chattr -R -i $MODS_PATH/$i
        rm -rf $MODS_PATH/$i
    fi
done
#我超shadog
for i in $(ls $MODS_PATH); do
    if [[ ! -z $(grep id=chargeauto $MODS_PATH/$i/module.prop) ]]; then
        chattr -R -i $MODS_PATH/$i
        rm -rf $MODS_PATH/$i
    echo "将shadog变成Seto的形状!"
    fi

		echo "安装时间：[$(date "+%F %T")]	安装的功能: $INSTALLED_FUNC" >>$TMPDIR/module.prop
	[ -d "/storage/emulated/0/Download/"$MODID"_update" ] && rm -rf /storage/emulated/0/Download/"$MODID"_update
	#echo -e "打开模块目录如果一些常见的文件还在的话，请返回data/adb/modules/把module.prop复制到模块目录即可。如果出现模块目录下只有一个system，其他文件都消失并且删除不掉模块，请打开data/adb/modules/module.prop执行异常情况解决方案2.sh\nSeto温控链接:" >/data/adb/modules/常见模块问题说明.prop
	#echo -e ""id=SetoSkins"\n"name=色图Seto温控"\n"version=19"\n"versionCode=19"\n"author=菜卡@SetoSkins-感谢酷安@灵聚丶神生"\n"description=魔改阶梯充电，充电速度提升，性能模式无温控。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target 默认为22A｜temp_limit是高温降流阀值 current_limit是指定高温降流电流，如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明"\n"updateJson=https://ghproxy.com/https://raw.githubusercontent.com/SetoSKins/wenkong/main/update.json"\n" >/data/adb/modules/module.prop
	#echo -e "chattr -R -i -a /data/adb/modules/SetoSkins/\nrm -rf /data/adb/modules/SetoSkins/" >/data/adb/modules/异常情况解决方案2.sh
	#ui_print "    你选择安装的模块列表在/data/adb/modules/SetoSkins/module.prop里"
	ui_print "    请仔细查看模块简介！"
	#ui_print "    如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明"
	ui_print "    作者酷安@SetoSkins"
	sleep 4
	rm -rf /data/system/package_cache/*
	ui_print "    缓存清理完毕"
}
