#!/system/bin/sh
MODDIR=${0%/*}
alias sh='/system/bin/sh'
 pid=$(ps -ef|grep $1|grep -v grep|cut -d "Seto_charge.sh" -f 2)
  file1=/data/adb/modules/SetoSkins/配置.prop
show_value() {
  local value=$1
  local file=/data/adb/modules/SetoSkins/配置.prop
  grep "$value" "$file"|cut -d "=" -f2
}
log=/data/adb/modules/SetoSkins/limit.log;logc=0
getp(){
temp=$(( $(cat /sys/class/power_supply/battery/temp) / 10 ))
a=$(grep "一限温度阈值" "$file1" | cut -d "=" -f2)
b=$(grep "一限限制电流" "$file1" | cut -d "=" -f2)
a1=$(grep "二限温度阈值" "$file1" | cut -d "=" -f2)
b1=$(grep "二限限制电流" "$file1" | cut -d "=" -f2)
c=$(grep "延迟温度阈值=" "$file1" | cut -d "=" -f2)
d=$(grep "一限电量阈值" "$file1" | cut -d "=" -f2)
d1=$(grep "一限电量限制电流" "$file1" | cut -d "=" -f2)
e=$(grep "二限电量阈值" "$file1" | cut -d "=" -f2)
e1=$(grep "二限电量限制电流" "$file1" | cut -d "=" -f2)
f=$(grep "三限电量阈值" "$file1" | cut -d "=" -f2)
f1=$(grep "三限电量限制电流" "$file1" | cut -d "=" -f2)
int=$(cat /data/adb/modules/SetoSkins/节点.prop |sed -n '1p')
int2=$(cat /data/adb/modules/SetoSkins/节点.prop |sed -n '2p')
}
getp
echo -n "Values:"
echo $a ;echo $b ;echo $a1 ;echo $b1; echo "$c End values"
if test $(show_value '开启充电调速') == true; then
  echo "开启充电调速"
  while true; do
  sleep 5
    getp
    let logc++
    sleep $c
    if [[ $temp -gt $a && $temp -lt $a1 ]]; then
      echo "$b" > /sys/class/power_supply/battery/constant_charge_current
      echo "$b" > /sys/devices/platform/battery/power_supply/battery/fast_charge_current
	  echo "$b" > /sys/devices/platform/battery/power_supply/battery/thermal_input_current
	  echo "$b" > /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	  echo "$b" > /sys/devices/platform/mt_charger/power_supply/usb/current_max
	  	    echo "$b" > /sys/class/power_supply/battery/constant_charge_current_max
	  echo "$b" > /sys/firmware/devicetree/base/charger/current_max
	    echo "$b" > "$int"
	    echo "$b" > "$int2"
      echo "触发一限温度阈值 temp:$a current:$b"|tee -a $log
        kill -19 $pid
    elif
      [[ $temp -lt $a ]]; then
      echo "50000000" > /sys/class/power_supply/battery/constant_charge_current
      echo "50000000" > /sys/devices/platform/battery/power_supply/battery/fast_charge_current
	  echo "50000000" > /sys/devices/platform/battery/power_supply/battery/thermal_input_current
	  echo "50000000" > /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	  echo "50000000" > /sys/devices/platform/mt_charger/power_supply/usb/current_max
	  echo "50000000" > /sys/firmware/devicetree/base/charger/current_max
	  	    echo "50000000" > /sys/class/power_supply/battery/constant_charge_current_max
	    echo "50000000" > "$int"
	      echo "50000000" > "$int2"
	  kill -18 $pid
      echo "触发无限制阈值 temp:$a"|tee -a $log
    elif [[ $temp -gt $a1 ]]; then
      echo "$b1" > /sys/class/power_supply/battery/constant_charge_current
      echo "$b1" > /sys/devices/platform/battery/power_supply/battery/fast_charge_current
	  echo "$b1" > /sys/devices/platform/battery/power_supply/battery/thermal_input_current
	  echo "$b1" > /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	  echo "$b1" > /sys/devices/platform/mt_charger/power_supply/usb/current_max
	  	    echo "$b1" > /sys/class/power_supply/battery/constant_charge_current_max
	  echo "$b1" > /sys/firmware/devicetree/base/charger/current_max
	    echo "$b1" > "$int"
	      echo "$b1" > "$int2"
	   kill -19 $pid
      echo "触发二限温度阈值 temp:$a1 current:$b1"|tee -a $log
    fi
    [ $logc -ge 50 ] && echo -n "" > $log && logc=0
  done
fi
if test $(show_value '自定义阶梯模式') == true; then
  echo "开启自定义阶梯"
  while true; do
  sleep 10
capacity=$(cat /sys/class/power_supply/battery/capacity)
status=$(cat /sys/class/power_supply/battery/status)
      if [[ $status == "Discharging" ]] || [[ $status == "Full"  ]]; then
       echo "50000000" > /sys/class/power_supply/battery/constant_charge_current
      echo "50000000" > /sys/devices/platform/battery/power_supply/battery/fast_charge_current
	  echo "50000000" > /sys/devices/platform/battery/power_supply/battery/thermal_input_current
	  echo "50000000" > /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	  echo "50000000" > /sys/devices/platform/mt_charger/power_supply/usb/current_max
	  	    echo "50000000" > /sys/class/power_supply/battery/constant_charge_current_max
	  echo "50000000" > /sys/firmware/devicetree/base/charger/current_max
	      echo "50000000" > "$int"
	      echo "50000000" > "$int2"
	  sleep 10
	        elif [[ $capacity -ge "$f" ]]; then
      echo "$f1" > /sys/class/power_supply/battery/constant_charge_current
      echo "$f1" > /sys/devices/platform/battery/power_supply/battery/fast_charge_current
	  echo "$f1" > /sys/devices/platform/battery/power_supply/battery/thermal_input_current
	  echo "$f1" > /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	  echo "$f1" > /sys/devices/platform/mt_charger/power_supply/usb/current_max
	  	    echo "$f1" > /sys/class/power_supply/battery/constant_charge_current_max
	  echo "$f1" > /sys/firmware/devicetree/base/charger/current_max
	      echo "$f1" > "$int"
	      echo "$f1" > "$int2"
      echo "触发三限电量阈值 current:$f"|tee -a $log
          elif [[ $capacity -ge "$e" ]]; then
      echo "$e1" > /sys/class/power_supply/battery/constant_charge_current
      echo "$e1" > /sys/devices/platform/battery/power_supply/battery/fast_charge_current
	  echo "$e1" > /sys/devices/platform/battery/power_supply/battery/thermal_input_current
	  echo "$e1" > /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	  echo "$e1" > /sys/devices/platform/mt_charger/power_supply/usb/current_max
	  	    echo "$e1" > /sys/class/power_supply/battery/constant_charge_current_max
	  echo "$e1" > /sys/firmware/devicetree/base/charger/current_max
	      echo "$e1" > "$int"
	      echo "$e1" > "$int2"
      echo "触发二限电量阈值 current:$e"|tee -a $log
elif [[ $capacity -ge "$d" ]]; then
      echo "$d1" > /sys/class/power_supply/battery/constant_charge_current
      echo "$d1" > /sys/devices/platform/battery/power_supply/battery/fast_charge_current
	  echo "$d1" > /sys/devices/platform/battery/power_supply/battery/thermal_input_current
	  echo "$d1" > /sys/devices/platform/11cb1000.i2c9/i2c-9/9-0055/power_supply/bms/current_max
	  echo "$d1" > /sys/devices/platform/mt_charger/power_supply/usb/current_max
	  	    echo "$d1" > /sys/class/power_supply/battery/constant_charge_current_max
	  echo "$d1" > /sys/firmware/devicetree/base/charger/current_max
	      echo "$d1" > "$int"
	      echo "$d1" > "$int2"
      echo "触发一限电量阈值 current:$d"|tee -a $log
	  fi
	  done
	  fi