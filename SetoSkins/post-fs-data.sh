a=$(getprop ro.product.system.brand)
if [[ $a == "Xiaomi" ]]; then
echo "不支持你的机型"
else
mount --bind ${0%/*}/coloros/sys_high_temp_protect_OPPO_22811.xml /odm/etc/temperature_profile/sys_high_temp_protect_OPPO_22811.xml
mount --bind ${0%/*}/coloros/sys_thermal_control_config.xml /odm/etc/temperature_profile/sys_thermal_control_config.xml
mount --bind ${0%/*}/coloros/sys_thermal_config.xml /odm/etc/ThermalServiceConfig/sys_thermal_config.xml
fi