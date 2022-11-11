# 安装时显示的模块名称
mod_name="关闭logs"
# 功能来源
# 模块介绍
mod_install_desc="关闭lsp和magisk的log等等，禁用后手动在lsp里面立即清空日志无效，但是不生成额外日志"
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
mod_require_device=".{0,}" #全部
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
		
	
		# 添加post-fs-data.sh
	add_service_sh $MOD_FILES_DIR/service.sh
	add_postfsdata_sh $MOD_FILES_DIR/post-fs-data.sh

#		ui_print "    设置权限"
rm -rf /cache/magisk.log
touch   /cache/magisk.log
chmod 000  /cache/magisk.log
/sbin/.magisk/busybox/chattr +i  /cache/magisk.log
rm -rf /data/adb/lspd/log/
am kill logd
killall -9 logd

am kill logd.rc
killall -9 logd.rc

am kill mobile_log_d
killall -9 mobile_log_d
am kill mobile_log_d.rc
killall -9 mobile_log_d.rc
		return 0
}

# 按下[音量-]时执行的函数
# 如果不需要，请保留函数结构和return 0
mod_install_no()
{
		return 0
}
