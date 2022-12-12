#!/system/bin/sh
MODDIR=${0%/*}
show_value() {
  value=$1
  file=/data/adb/modules/SetoSkins/配置.prop
  cat "${file}" | grep -E "(^$value=)" | sed '/^#/d;/^[[:space:]]*$/d;s/.*=//g' | sed 's/，/,/g;s/——/-/g;s/：/:/g' | head -n 1
}
temp=$(expr $(cat /sys/class/power_supply/battery/temp) / 10)
a=$(grep "一限温度阈值" "$file" | cut -c8-)
b=$(grep "一限限制电流" "$file" | cut -c8-)
a1=$(grep "二限温度阈值" "$file" | cut -c8-)
b1=$(grep "二限限制电流" "$file" | cut -c8-)
c=$(grep "延迟温度阈值" "$file" | cut -c8-)

if test $(show_value '开启充电调速') == true; then
  while true; do
    sleep "$c"
    if [[ $temp -gt $a ]]; then
      echo "$b" >/sys/class/power_supply/usb/current_max
      echo "$b" >/sys/class/power_supply/battery/constant_charge_current
    fi
    if [[ $temp -gt $a1 ]]; then
      echo "$b1" >/sys/class/power_supply/usb/current_max
      echo "$b1" >/sys/class/power_supply/battery/constant_charge_current
    fi
  done
fi
