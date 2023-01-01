#!/system/bin/sh
MODDIR=${0%/*}
alias sh='/system/bin/sh'
show_value() {
  value=$1
  file=/data/adb/modules/SetoSkins/配置.prop
  cat "${file}" | grep -E "(^$value=)" | sed '/^#/d;/^[[:space:]]*$/d;s/.*=//g' | sed 's/，/,/g;s/——/-/g;s/：/:/g' | head -n 1
}
  file1=/data/adb/modules/SetoSkins/配置.prop
  while true; do
  sleep 5
  #读取配置文件和系统数据到变量
  status=$(cat /sys/class/power_supply/battery/status)
  capacity=$(cat /sys/class/power_supply/battery/capacity)
  temp=$(expr $(cat /sys/class/power_supply/battery/temp) / 10)
  current=$(expr $(cat /sys/class/power_supply/battery/current_now) \* $minus)
  ChargemA1=$(expr $(cat /sys/class/power_supply/battery/current_now) / -1000)
if test $(show_value '当电流低于阈值执行停充') == true; then
    c=$(grep "电流阈值" "$file1" | cut -c6-)
    d=$(grep "降低到多少电量恢复充电" "$file1" | cut -c13-)
  if [[ $ChargemA1 -lt $c ]] && [[ $capacity -gt 90 ]] && [[ $status == "Charging" ]]; then
   echo 1 > /sys/class/power_supply/battery/input_suspend
   echo $(date) $hint" 触发停充"" >>"/data/adb/modules/SetoSkins/log.log
    elif [[ $capacity -lt $d ]] && [[ $status == "Discharging" ]]; then
   echo 0 > /sys/class/power_supply/battery/input_suspend
  elif test $(show_value '当电流低于电流阈值执行停充') == false; then
   echo 0 > /sys/class/power_supply/battery/input_suspend
   fi
   fi
   done