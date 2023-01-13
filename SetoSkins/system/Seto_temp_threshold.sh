#!/system/bin/sh
#only for test

MODDIR=${0%/*}
alias sh='/system/bin/sh'
 pid=$(ps -ef|grep $1|grep -v grep|cut -d "Seto_charge.sh" -f 2)
  file1=/data/adb/modules/SetoSkins/配置.prop
show_value() {
  local value=$1
  local file=/data/adb/modules/SetoSkins/配置.prop
  grep "$value" "$file"|cut -d "=" -f2
}
if [ -f "/sys/class/power_supply/battery/constant_charge_current" ];then
echo "文件存在"
 elif
  [ -f /sys/devices/platform/battery/power_supply/battery/fast_charge_current ]; then
  echo "文件存在"
   elif
   [ -f /sys/devices/platform/mt_charger/power_supply/usb/current_max ]; then
  echo "文件存在"
   elif
   [ -f /sys/devices/platform/battery/power_supply/battery/thermal_input_current ]; then
  echo "文件存在"
   elif
  [ -f /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max ]; then
  echo "文件存在"
   elif
   [ -f /sys/class/power_supply/usb/current_max ]; then
  echo "文件存在"
  else
echo -e "你的机型不支持调速 请反馈给Seto">>/data/adb/modules/SetoSkins/log.log
exit 0
  fi
log=/data/adb/modules/SetoSkins/limit.log;logc=0
getp(){
temp=$(( $(cat /sys/class/power_supply/battery/temp) / 10 ))
a=$(grep "一限温度阈值" "$file1" | cut -d "=" -f2)
b=$(grep "一限限制电流" "$file1" | cut -d "=" -f2)
a1=$(grep "二限温度阈值" "$file1" | cut -d "=" -f2)
b1=$(grep "二限限制电流" "$file1" | cut -d "=" -f2)
c=$(grep "延迟温度阈值=" "$file1" | cut -d "=" -f2)
}
getp
echo -n "Values:"
echo $a ;echo $b ;echo $a1 ;echo $b1; echo "$c End values"
if test $(show_value '开启充电调速') == true; then
  echo "开启充电调速"
  while true; do
    getp
    let logc++
    sleep $c
    if [[ $temp -gt $a && $temp -lt $a1 ]]; then
      echo "$b" > /sys/class/power_supply/battery/constant_charge_current
      echo "$b" /sys/devices/platform/battery/power_supply/battery/fast_charge_current
	  echo "$b" /sys/devices/platform/battery/power_supply/battery/thermal_input_current
	  echo "$b" /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	  echo "$b" /sys/devices/platform/mt_charger/power_supply/usb/current_max
	  echo "$b" /sys/firmware/devicetree/base/charger/current_max
      echo "触发一限温度阈值 temp:$a current:$b"|tee -a $log
        kill -19 $pid
    elif
      [[ $temp -lt $a ]]; then
      echo "50000000" > /sys/class/power_supply/battery/constant_charge_current
      echo "50000000" /sys/devices/platform/battery/power_supply/battery/fast_charge_current
	  echo "50000000" /sys/devices/platform/battery/power_supply/battery/thermal_input_current
	  echo "50000000" /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	  echo "50000000" /sys/devices/platform/mt_charger/power_supply/usb/current_max
	  echo "50000000" /sys/firmware/devicetree/base/charger/current_max
	  kill -18 $pid
      echo "触发无限制阈值 temp:$a"|tee -a $log
    elif [[ $temp -gt $a1 ]]; then
      echo "$b1" > /sys/class/power_supply/battery/constant_charge_current
      echo "$b1" /sys/devices/platform/battery/power_supply/battery/fast_charge_current
	  echo "$b1" /sys/devices/platform/battery/power_supply/battery/thermal_input_current
	  echo "$b1" /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	  echo "$b1" /sys/devices/platform/mt_charger/power_supply/usb/current_max
	  echo "$b1" /sys/firmware/devicetree/base/charger/current_max
	   kill -19 $pid
      echo "触发二限温度阈值 temp:$a1 current:$b1"|tee -a $log
    fi
    [ $logc -ge 50 ] && echo -n "" > $log && logc=0
  done
fi
