#!/system/bin/sh
MODDIR=${0%/*}
for scripts in $MODDIR/system/*.sh
do
	$scripts 2>/dev/null &
done
show_value() {
  value=$1
  file=$MODDIR/配置.prop
  cat "${file}" | grep -E "(^$value=)" | sed '/^#/d;/^[[:space:]]*$/d;s/.*=//g' | sed 's/，/,/g;s/——/-/g;s/：/:/g' | head -n 1
}
[[ -e /sys/class/power_supply/battery/cycle_count ]] && CYCLE_COUNT="$(cat /sys/class/power_supply/battery/cycle_count) 次" || CYCLE_COUNT="（？）"
[[ -e /sys/class/power_supply/bms/charge_full ]] && Battery_capacity="$(($(cat /sys/class/power_supply/bms/charge_full) / 1000))mAh" || Battery_capacity="（？）"
echo -e $(date) ""模块启动"\n"电池循环次数: $CYCLE_COUNT"\n"电池容量: $Battery_capacity"\n" >"$MODDIR"/log.log
chmod 777 /sys/class/power_supply/*/*
lasthint="DisCharging"
wk="/sys/class/thermal/thermal_message/enable"
mode="/data/vendor/thermal/thermal-global-mode"
echo 0 >$mode
echo 1 >$wk
if test $(show_value '检测mi_thermald丢失自动保活') ==ture; then
  pid=$(ps -ef | grep "mi_thermald" | grep -v grep | awk '{print $2}')
  a=$(kill -9 "$pid")
  while true; do
    if [ -n "$a" ]; then
      restart_mi_thermald() {
        killall -15 mi_thermald
        for i in $(which -a mi_thermald); do
          nohup "$i" >/dev/null 2>&1 &
        done
      }
    fi
  done
fi
while true; do
  sleep 5
  #读取配置文件和系统数据到变量
  status=$(cat /sys/class/power_supply/battery/status)
  capacity=$(cat /sys/class/power_supply/battery/capacity)
  temp=$(expr $(cat /sys/class/power_supply/battery/temp) / 10)
  current=$(expr $(cat /sys/class/power_supply/battery/current_now) \* $minus)
  ChargemA=$(expr $(cat /sys/class/power_supply/battery/current_now) / -1000)
  minus=$(cat "$MODDIR"/system/minus)
  #判断目前状态
  hint="DisCharging"
  if [[ $status == "Charging" ]]; then
    hint="NormallyCharging"
    if [[ $current -lt 3000000 ]]; then
      hint="LowCurrent"
    fi
    if [[ $capacity -gt 55 ]]; then
      hint="AlreadyFinish"
    fi
    if [[ $temp -gt 48 ]]; then
      hint="HighTemperature"
    fi
  fi
  if test $(show_value '开启游戏温控') == true; then
    cp "$MODDIR/cloud/thermal/thermal-mgame.conf" "/data/vendor/thermal/config/thermal-tgame.conf"
    cp "$MODDIR/cloud/thermal/thermal-mgame.conf" "/data/vendor/thermal/config/thermal-mgame.conf"
    cp "$MODDIR/cloud/thermal/thermal-mgame.conf" "$MODDIR/system/vendor/etc/thermal-tgame.conf"
    cp "$MODDIR/cloud/thermal/thermal-mgame.conf" "$MODDIR/system/vendor/etc/thermal-mgame.conf"
  fi
  #进行相应操作
  if [[ $capacity == "100" ]]; then
    echo $(date)" 已充满" >>"$MODDIR"/log.log
    sed -i "/^description=/c description=[ 😊已充满 温度$temp℃ 电流$ChargemA"mA" ]" "$MODDIR/module.prop"
  elif [[ $hint == "DisCharging" ]]; then
    sed -i "/^description=/c description=[ 🔋未充电 ]动态温控 配置在模块根目录的system里面｜充电log位置也在模块根目录" "$MODDIR/module.prop"
    setprop ctl.restart mi_thermald
    setprop ctl.restart thermal
    echo 1 >/sys/class/thermal/thermal_message/sconfig
  elif [[ $hint == "NormallyCharging" ]]; then
    sed -i "/^description=/c description=[ ✅正常充电中 温度$temp℃ 电流$ChargemA"mA" ]动态温控 配置在模块根目录的system里面｜充电log位置也在模块根目录" "$MODDIR/module.prop"
  elif [[ $hint == "LowCurrent" ]]; then
    sed -i "/^description=/c description=[ 充电缓慢⚠️ ️电量$capacity% 温度$temp℃ 电流$ChargemA"mA" ]动态温控 配置在模块根目录的system里面｜充电log位置也在模块根目录" "$MODDIR/module.prop"
    echo '0' >/sys/class/power_supply/usb/input_current_limited
  elif [[ $hint == "HighTemperature" ]]; then
    sed -i "/^description=/c description=[ 太烧了🥵 温度$temp℃ 电流$ChargemA"mA" ]动态温控 配置在模块根目录的system里面｜充电log位置也在模块根目录" "$MODDIR/module.prop"
  elif [[ $hint == "AlreadyFinish" ]]; then
    sed -i "/^description=/c description=[ ⚡达到阈值 尝试加快速度充电 温度$temp℃ 电流$ChargemA"mA" ]动态温控 配置在模块根目录的system里面｜充电log位置也在模块根目录" "$MODDIR/module.prop"
    setprop ctl.stop mi_thermald
    setprop ctl.stop thermal
    echo 10 >/sys/class/thermal/thermal_message/sconfig
  elif [[ $capacity == "100" ]]; then
    echo $(date)" 已充满" >>"$MODDIR"/log.log
    sed -i "/^description=/c description=已充满" "$MODDIR/module.prop"
  fi
done
echo 0 >/sys/class/power_supply/battery/input_suspend
echo 1 >/sys/class/power_supply/battery/battery_charging_enabled
echo Good >/sys/class/power_supply/battery/health
chmod 777 /sys/class/power_supply/battery/constant_charge_current_max
chmod 777 /sys/class/power_supply/battery/step_charging_enabled
chmod 777 /sys/class/power_supply/battery/input_suspend
chmod 777 /sys/class/power_supply/battery/battery_charging_enabled
