#!/system/bin/sh
MODDIR=${0%/*}
true >"$MODDIR"/log.log
[[ -e /sys/class/power_supply/battery/cycle_count ]] && CYCLE_COUNT="$(cat /sys/class/power_supply/battery/cycle_count) 次" || CYCLE_COUNT="（？）"
[[ -e /sys/class/power_supply/bms/charge_full ]] && Battery_capacity="$(($(cat /sys/class/power_supply/bms/charge_full) / 1000))mAh" || Battery_capacity="（？）"
echo $(date) ""模块启动"\n"电池循环次数: $CYCLE_COUNT"\n"电池容量: $Battery_capacity"\n" >> "$MODDIR"/log.log
chmod 777 /sys/class/power_supply/*/*
lasthint="DisCharging"
while true; do

  #读取配置文件和系统数据到变量

  status=$(cat /sys/class/power_supply/battery/status)
  capacity=$(cat /sys/class/power_supply/battery/capacity)
  capacity_limit=$(cat "$MODDIR"/system/capacity_limit)
  temp=`expr $(cat /sys/class/power_supply/battery/temp) / 10`
  temp_limit=$(cat "$MODDIR"/system/temp_limit)
  current_target=`expr $(cat "$MODDIR"/system/current_target) \* 1000`
  current_limit=`expr $(cat "$MODDIR"/system/current_limit) \* 1000`
  minus=$(cat "$MODDIR"/system/minus)
  current=`expr $(cat /sys/class/power_supply/battery/current_now) \* $minus`
  show_current=`expr $current / 1000`
  ChargemA=`expr $(cat /sys/class/power_supply/battery/current_now) / -1000`
current_target=`expr $(cat "$MODDIR"/system/current_target) \* 1000`
echo 0 > /sys/class/power_supply/battery/input_suspend
echo 1 > /sys/class/power_supply/battery/battery_charging_enabled
setprop ctl.restart thermal-engine
setprop ctl.restart mi_thermald
setprop ctl.restart thermal_manager
echo Good > /sys/class/power_supply/battery/health
chmod 777 /sys/class/power_supply/battery/constant_charge_current_max
chmod 777 /sys/class/power_supply/battery/step_charging_enabled
chmod 777 /sys/class/power_supply/battery/input_suspend
chmod 777 /sys/class/power_supply/battery/battery_charging_enabled
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

  if [[ $status == "Charging" ]]
  then
  sleep 90
 echo $(date) " 电量$capacity% 温度$temp° 电流$ChargemA"mA"" >> "$MODDIR"/log.log 
  fi
  lasthint=$hint
  if [[ $capacity == "100" ]]
  then 
   echo $(date)"充满了捏😋" >> "$MODDIR"/log.log
  fi
  capacity = 100
done
exit