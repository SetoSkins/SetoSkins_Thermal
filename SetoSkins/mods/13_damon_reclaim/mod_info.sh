# 安装时显示的模块名称
mod_name="开启damon_reclaim（内核5.16以上版本适用）"
# 功能来源
# 模块介绍
mod_install_desc="用于轻度内存压力下的主动和轻量级的回收。有选择地用于不同程度的内存压力和要求"
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
echo N > /sys/modules/damin_reclaim/enabled

		return 0
}

# 按下[音量-]时执行的函数
# 如果不需要，请保留函数结构和return 0
mod_install_no()
{
		return 0
}
