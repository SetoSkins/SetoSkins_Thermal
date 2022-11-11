#!/system/bin/sh
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
echo 22000000 > /sys/class/power_supply/battery/constant_charge_current_max