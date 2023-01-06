#!/system/bin/sh
#only for test

MODDIR=${0%/*}
alias sh='/system/bin/sh'
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
      echo "触发一限温度阈值 temp:$a current:$b"|tee -a $log
    elif
      [[ $temp -lt $a ]]; then
      echo "50000000" > /sys/class/power_supply/battery/constant_charge_current
      echo "触发无限制阈值 temp:$a"|tee -a $log
    elif [[ $temp -gt $a1 ]]; then
      echo "$b1" > /sys/class/power_supply/battery/constant_charge_current
      echo "触发二限温度阈值 temp:$a1 current:$b1"|tee -a $log
    fi
    [ $logc -ge 50 ] && echo -n "" > $log && logc=0
  done
fi
