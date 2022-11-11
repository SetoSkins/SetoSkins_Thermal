#!/system/bin/sh
current_target=`expr $(cat "$MODDIR"/system/current_target) \* 1000`
/system/bin/echo 0 >/sys/kernel/fpsgo/common/force_onoff
echo 0 > /sys/class/power_supply/battery/input_suspend
echo 1 > /sys/class/power_supply/battery/battery_charging_enabled
setprop ctl.restart thermal-engine
setprop ctl.restart mi_thermald
setprop ctl.restart thermal_manager
echo '0' > /sys/class/power_supply/battery/input_suspend
echo Good > /sys/class/power_supply/battery/health
chmod 777 /sys/class/power_supply/battery/constant_charge_current_max
chmod 777 /sys/class/power_supply/battery/step_charging_enabled
chmod 777 /sys/class/power_supply/battery/input_suspend
chmod 777 /sys/class/power_supply/battery/battery_charging_enabled
echo 0 > /sys/class/power_supply/battery/input_suspend
echo ${current_target} > /sys/class/power_supply/usb/ctm_current_max
echo ${current_target} > /sys/class/power_supply/usb/current_max
echo ${current_target} > /sys/class/power_supply/usb/sdp_current_max
echo ${current_target} > /sys/class/power_supply/usb/hw_current_max
echo ${current_target} > /sys/class/power_supply/usb/constant_charge_current
echo ${current_target} > /sys/class/power_supply/usb/constant_charge_current_max
echo ${current_target} > /sys/class/power_supply/main/current_max
echo ${current_target} > /sys/class/power_supply/main/constant_charge_current_max
echo ${current_target} > /sys/class/power_supply/dc/current_max
echo ${current_target} > /sys/class/power_supply/dc/constant_charge_current_max
echo ${current_target} > /sys/class/power_supply/battery/constant_charge_current_max
echo ${current_target} > /sys/class/power_supply/battery/constant_charge_current
echo ${current_target} > /sys/class/power_supply/battery/current_max
echo ${current_target} > /sys/class/power_supply/pc_port/current_max
echo ${current_target} > /sys/class/power_supply/qpnp-dc/current_max