# 安装时显示的模块名称
mod_name="魔改joyose1（建议优先使用 安卓13慎用）"
# 模块介绍
mod_install_desc="去游戏锁帧，安装这个不会提高你手机性能！感谢@向晚今天吃了咩"
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

mod_install_yes()
{
mkdir -p $MODPATH/system/
		cp -rf $MOD_FILES_DIR/* $MODPATH/system/
		set_perm_recursive  $MODPATH  0  0  0755  0644
	    pm enable com.xiaomi.joyose
  rm -rf /data/system/package_cache/*
}

mod_install_no()
{
		return 0
}