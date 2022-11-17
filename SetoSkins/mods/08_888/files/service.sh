#!/system/bin/sh
MODDIR=${0%/*}
true >"$MODDIR"/log.log
[[ -e /sys/class/power_supply/battery/cycle_count ]] && CYCLE_COUNT="$(cat /sys/class/power_supply/battery/cycle_count) 次" || CYCLE_COUNT="（？）"
[[ -e /sys/class/power_supply/battery/charge_full ]] && Battery_capacity="$(($(cat /sys/class/power_supply/battery/charge_full) / 1000))mAh" || Battery_capacity="（？）"
echo $(date) ""模块启动"\n"电池循环次数: $CYCLE_COUNT"\n"电池容量: $Battery_capacity"\n" >>"$MODDIR"/log.log
chmod 777 /sys/class/power_supply/*/*
lasthint="DisCharging"
while true; do
  #读取配置文件和系统数据到变量
  status=$(cat /sys/class/power_supply/battery/status)
  capacity=$(cat /sys/class/power_supply/battery/capacity)
  capacity_limit=$(cat "$MODDIR"/system/capacity_limit)
  temp=$(expr $(cat /sys/class/power_supply/battery/temp) / 10)
  temp_limit=$(cat "$MODDIR"/system/temp_limit)
  current_target=$(expr $(cat "$MODDIR"/system/current_target) \* 1000)
  minus=$(cat "$MODDIR"/system/minus)
  current=$(expr $(cat /sys/class/power_supply/battery/current_now) \* $minus)
  show_current=$(expr $current / 1000)
  ChargemA=$(expr $(cat /sys/class/power_supply/battery/current_now) / -1000)
  #判断目前状态
  hint="DisCharging"
  if [[ $status == "Charging" ]]; then
    hint="NormallyCharging"
    if [[ $show_current -gt $(expr $current_target + 500) ]]; then
      hint="HighCurrent"
    fi
    if [[ $current -lt 3000000 ]]; then
      hint="LowCurrent"
    fi
    if [[ $capacity -gt $(expr $capacity_limit - 5) ]]; then
      hint="DoNothing"
    fi
    if [[ $capacity -gt $capacity_limit ]]; then
      hint="AlreadyFinish"
    fi
    if [[ $temp -gt $temp_limit ]]; then
      hint="HighTemperature"
    fi
  fi
  #进行相应操作
  if [[ $hint == "DisCharging" ]]; then
    sed -i "/^description=/c description=[ 🔋未充电 ]魔改阶梯充电，充电速度提升，性能模式无温控。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target 默认为22A｜temp_limit是高温降流阀值 current_limit是指定高温降流电流，如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明" "$MODDIR/module.prop"
    setprop ctl.restart mi_thermald
    setprop ctl.restart thermal
    echo 1 >/sys/class/thermal/thermal_message/sconfig
  elif [[ $hint == "NormallyCharging" ]]; then
    sed -i "/^description=/c description=[ ✅正常充电中 温度$temp℃ 电流$ChargemA"mA" ]性能模式无温控。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target 默认为22A｜temp_limit是高温降流阀值 current_limit是指定高温降流电流，如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明" "$MODDIR/module.prop"
    setprop ctl.stop mi_thermald
    setprop ctl.stop thermal
  elif [[ $hint == "HighCurrent" ]]; then
    sed -i "/^description=/c description=[✅正常充电中 温度$temp℃ 电流$ChargemA"mA" ]性能模式无温控。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target 默认为22A｜temp_limit是高温降流阀值 current_limit是指定高温降流电流，如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明" "$MODDIR/module.prop"
    echo '0' >/sys/class/power_supply/battery/input_current_limited
    echo '1' >/sys/class/power_supply/usb/boost_current
    echo ${current_target} >/sys/class/power_supply/usb/current_max
    echo ${current_target} >/sys/class/power_supply/usb/constant_charge_current
    echo ${current_target} >/sys/class/power_supply/battery/constant_charge_current
    echo ${current_target} >/sys/class/power_supply/battery/current_max
  elif [[ $hint == "LowCurrent" ]]; then
    sed -i "/^description=/c description=[ 充电缓慢⚠️ ️电量$capacity% 温度$temp℃ 电流$ChargemA"mA" ]可能是碰到内核墙，如果不是，请排查问题改最大电流目录在/data/adb/modules/SetoSkins/system/current_target 默认为22A｜temp_limit是高温降流阀值 current_limit是指定高温降流电流。" "$MODDIR/module.prop"
    echo '0' >/sys/class/power_supply/battery/input_current_limited
    echo '1' >/sys/class/power_supply/usb/boost_current
    echo ${current_target} >/sys/class/power_supply/usb/current_max
    echo ${current_target} >/sys/class/power_supply/usb/constant_charge_current
    echo ${current_target} >/sys/class/power_supply/battery/constant_charge_current
    echo ${current_target} >/sys/class/power_supply/battery/current_max
  elif [[ $hint == "HighTemperature" ]]; then
    sed -i "/^description=/c description=[ 太烧了🥵 温度$temp℃ 电流$ChargemA"mA" ]性能模式无温控。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target 默认为22A｜temp_limit是高温降流阀值 current_limit是指定高温降流电流，如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明" "$MODDIR/module.prop"
    echo ${current_target} >/sys/class/power_supply/usb/current_max
    echo ${current_target} >/sys/class/power_supply/usb/constant_charge_current
    echo ${current_target} >/sys/class/power_supply/battery/constant_charge_current
    echo ${current_target} >/sys/class/power_supply/battery/current_max
  elif [[ $hint == "AlreadyFinish" ]]; then
    sed -i "/^description=/c description=[ ⚡达到阈值 尝试加快速度充电 温度$temp℃ 电流$ChargemA"mA" ]性能模式无温控。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target 默认为22A｜temp_limit是高温降流阀值 current_limit是指定高温降流电流，如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明" "$MODDIR/module.prop"
    echo 10 >/sys/class/thermal/thermal_message/sconfig
    echo ${current_target} >/sys/class/power_supply/usb/current_max
    echo ${current_target} >/sys/class/power_supply/usb/constant_charge_current
    echo ${current_target} >/sys/class/power_supply/battery/constant_charge_current
    echo ${current_target} >/sys/class/power_supply/battery/current_max
  elif [[ $hint == "DoNothing" ]]; then
    sed -i "/^description=/c description=[ ✅正常充电中 温度$temp℃ 电流$ChargemA"mA" ]性能模式无温控。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target 默认为22A｜temp_limit是高温降流阀值 current_limit是指定高温降流电流，如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明" "$MODDIR/module.prop"
  fi
done
exit
