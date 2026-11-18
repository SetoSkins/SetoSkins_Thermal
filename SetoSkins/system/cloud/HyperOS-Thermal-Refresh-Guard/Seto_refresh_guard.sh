#!/system/bin/sh
# HyperOS Thermal Refresh Guard 集成入口
# 由 SetoSkins 的 post-fs-data.sh 与 service.sh 调用
# 用法: Seto_refresh_guard.sh early|late
GUARD_DIR=${0%/*}
CFG=/data/adb/modules/SetoSkins/配置.prop
STAGE=$1

show_value() {
	grep -E "^$1=" "$CFG" 2>/dev/null | head -n 1 | sed 's/.*=//g'
}

# 配置.prop 未开启“默认温控强制高刷”时不执行
[ "$(show_value '默认温控强制高刷')" = "true" ] || exit 0

# customize.sh 依赖安装环境中的函数，这里补上
ui_print() { :; }
set_perm() { chown "$2:$3" "$1" 2>/dev/null; chmod "$4" "$1" 2>/dev/null; }
set_perm_recursive() {
	chown -R "$2:$3" "$1" 2>/dev/null
	find "$1" -type d -exec chmod "$4" {} + 2>/dev/null
	find "$1" -type f -exec chmod "$5" {} + 2>/dev/null
}

export MODPATH="$GUARD_DIR"

case "$STAGE" in
	early)
		# 开机早期生成接口元数据并挂载热控刷新率映射
		sh "$GUARD_DIR/customize.sh" >/dev/null 2>&1
		sh "$GUARD_DIR/post-fs-data.sh"
		;;
	late)
		# 开机后期重新探测面板峰值并清除 Framework 热限帧
		sh "$GUARD_DIR/customize.sh" >/dev/null 2>&1
		sh "$GUARD_DIR/service.sh"
		;;
esac
