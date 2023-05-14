#!/system/bin/sh
MODDIR=${0%/*}

# 此函数可执行一个代码/函数
# 超时后自动杀死本脚本，如果只用一次还是很优雅的
# 用法: {
#    脚本的其它部分包装为代码块
#    } & timeout_once 秒数
function timeout() {
	trap -- "" SIGTERM
	child=$!
	timeout=$1
	(
		sleep $timeout
		kill $child
	) &
	wait $child
}

{
	a=$(getprop ro.product.system.brand)
	if [[ $a == "Xiaomi" ]] || [[ $a == "qti" ]]; then
		echo "不支持你的机型"
		rm -rf $MODDIR/post-fs-data.sh
		rm -rf $MODDIR/coloros
	else
		mount --bind ${0%/*}/coloros/sys_high_temp_protect_OPPO_22811.xml /odm/etc/temperature_profile/sys_high_temp_protect_OPPO_22811.xml
		mount --bind ${0%/*}/coloros/sys_thermal_control_config.xml /odm/etc/temperature_profile/sys_thermal_control_config.xml
		mount --bind ${0%/*}/coloros/sys_thermal_config.xml /odm/etc/ThermalServiceConfig/sys_thermal_config.xml
	fi
} & timeout 10