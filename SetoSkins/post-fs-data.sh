#!/system/bin/sh
MODDIR=${0%/*}
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
