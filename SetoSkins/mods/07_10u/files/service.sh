#!/system/bin/sh
MODDIR=${0%/*}
echo $(date) "模块启动" > "$MODDIR"/log.log
chmod 777 /sys/class/power_supply/*/*
lasthint="DisCharging"
cp -f "$MODDIR/backup.prop" "$MODDIR/module.prop"
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
  #判断目前状态

  hint="DisCharging"

  if [[ $status == "Charging" ]]
  then
    hint="NormallyCharging"

    if [[ $show_current -gt `expr $current_target + 500` ]]
    then
      hint="HighCurrent"
    fi

    if [[ $current -lt 3000000 ]]
    then
      hint="LowCurrent"
    fi

    if [[ $capacity -gt `expr $capacity_limit - 5` ]]
    then
      hint="DoNothing"
    fi

    if [[ $capacity -gt $capacity_limit ]]
    then
      hint="AlreadyFinish"
    fi
    
    if [[ $temp -gt $temp_limit ]]
    then
      hint="HighTemperature"
    fi
  fi

  #进行相应操作

  if [[ $hint == "DisCharging" ]]
  then
    sed -i "/^description=/c description=[ 🔋未充电 ]魔改阶梯充电，充电速度提升，性能模式无温控。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target｜current_limit可不更改 默认数值为22A，如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明
" "$MODDIR/module.prop"
   setprop ctl.restart thermal-engine
   setprop ctl.restart mi_thermald
   setprop ctl.restart thermal_manager
   setprop ctl.restart thermal
  elif [[ $hint == "NormallyCharging" ]]
  then
    sed -i "/^description=/c description=[ ✅正常充电中 温度$temp℃ 电流$ChargemA"mA" ]魔改阶梯充电，充电速度提升，性能模式无温控。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target｜current_limit可不更改 默认数值为22A，如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明
" "$MODDIR/module.prop"
  elif [[ $hint == "HighCurrent" ]]
  then
    sed -i "/^description=/c description=[✅正常充电中 温度$temp℃ 电流$ChargemA"mA" ]魔改阶梯充电，充电速度提升，性能模式无温控。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target｜current_limit可不更改 默认数值为22A，如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明
" "$MODDIR/module.prop"
    echo '0' > /sys/class/power_supply/battery/input_current_limited
    echo '1' > /sys/class/power_supply/usb/boost_current
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
  elif [[ $hint == "LowCurrent" ]]
  then
    sed -i "/^description=/c description=[ 充电缓慢⚠️ ️电量$capacity% 温度$temp℃ 电流$ChargemA"mA" ]可能碰到内核墙、涓流情况，如果不是前两种情况，请排查问题。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target｜current_limit可不更改 默认数值为22A。
" "$MODDIR/module.prop"
    echo '0' > /sys/class/power_supply/battery/input_current_limited
    echo '1' > /sys/class/power_supply/usb/boost_current
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
  elif [[ $hint == "HighTemperature" ]]
  then
  sed -i "/^description=/c description=[✅正常充电中 温度$temp℃ 电流$ChargemA"mA" ]魔改阶梯充电，充电速度提升，性能模式无温控。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target｜current_limit可不更改 默认数值为22A，如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明
" "$MODDIR/module.prop"
    echo ${current_limit} > /sys/class/power_supply/usb/ctm_current_max
    echo ${current_limit} > /sys/class/power_supply/usb/current_max
    echo ${current_limit} > /sys/class/power_supply/usb/sdp_current_max
    echo ${current_limit} > /sys/class/power_supply/usb/hw_current_max
    echo ${current_limit} > /sys/class/power_supply/usb/constant_charge_current
    echo ${current_limit} > /sys/class/power_supply/usb/constant_charge_current_max
    echo ${current_limit} > /sys/class/power_supply/main/current_max
    echo ${current_limit} > /sys/class/power_supply/main/constant_charge_current_max
    echo ${current_limit} > /sys/class/power_supply/dc/current_max
    echo ${current_limit} > /sys/class/power_supply/dc/constant_charge_current_max
    echo ${current_limit} > /sys/class/power_supply/battery/constant_charge_current_max
    echo ${current_limit} > /sys/class/power_supply/battery/constant_charge_current
    echo ${current_limit} > /sys/class/power_supply/battery/current_max
    echo ${current_limit} > /sys/class/power_supply/pc_port/current_max
    echo ${current_limit} > /sys/class/power_supply/qpnp-dc/current_max
  elif [[ $hint == "AlreadyFinish" ]]
  then
  sed -i "/^description=/c description=[ ⚡达到阈值 尝试加快速度充电 温度$temp℃ 电流$ChargemA"mA" ]魔改阶梯充电，充电速度提升，性能模式无温控。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target｜current_limit可不更改 默认数值为22A，如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明
" "$MODDIR/module.prop"
    resetprop ctl.stop thermal-engine
    resetprop ctl.stop mi_thermald
    resetprop ctl.stop thermal_manager
    resetprop ctl.stop thermal
    echo ${current_limit} > /sys/class/power_supply/usb/ctm_current_max
    echo ${current_limit} > /sys/class/power_supply/usb/current_max
    echo ${current_limit} > /sys/class/power_supply/usb/sdp_current_max
    echo ${current_limit} > /sys/class/power_supply/usb/hw_current_max
    echo ${current_limit} > /sys/class/power_supply/usb/constant_charge_current
    echo ${current_limit} > /sys/class/power_supply/usb/constant_charge_current_max
    echo ${current_limit} > /sys/class/power_supply/main/current_max
    echo ${current_limit} > /sys/class/power_supply/main/constant_charge_current_max
    echo ${current_limit} > /sys/class/power_supply/dc/current_max
    echo ${current_limit} > /sys/class/power_supply/dc/constant_charge_current_max
    echo ${current_limit} > /sys/class/power_supply/battery/constant_charge_current_max
    echo ${current_limit} > /sys/class/power_supply/battery/constant_charge_current
    echo ${current_limit} > /sys/class/power_supply/battery/current_max
    echo ${current_limit} > /sys/class/power_supply/pc_port/current_max
    echo ${current_limit} > /sys/class/power_supply/qpnp-dc/current_max
  elif [[ $hint == "DoNothing" ]]
  then
    sed -i "/^description=/c description=[ ✅正常充电中 温度$temp℃ 电流$ChargemA"mA" ]魔改阶梯充电，充电速度提升，性能模式无温控。改最大电流目录在/data/adb/modules/SetoSkins/system/current_target｜current_limit可不更改 默认数值为22A，如果遇到模块异常情况，请打开/data/adb/modules/常见模块问题说明
" "$MODDIR/module.prop"
  fi 

  #写入日志

  if [[ $lasthint != $hint ]]
  then 
    echo $(date) $hint"事件" >> "$MODDIR"/log.log 
  fi
  lasthint=$hint
  sleep 2
done
exit