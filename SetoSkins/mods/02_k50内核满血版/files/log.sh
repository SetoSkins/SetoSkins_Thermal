#!/system/bin/sh
MODDIR=/data/adb/modules/SetoSkins/
while true; do
    status=$(cat /sys/class/power_supply/battery/status)
    capacity=$(cat /sys/class/power_supply/battery/capacity)
    temp=$(expr $(cat /sys/class/power_supply/battery/temp) / 10)
    ChargemA=$(expr $(cat /sys/class/power_supply/battery/current_now) / -1000)
    #写入日志
    if [[ $status == "Charging" ]] && [[ $ChargemA -gt 300 ]]; then
        echo $(date) $hint" 电量$capacity% 温度$temp℃ 电流$ChargemA"mA"" >>"$MODDIR"/log.log
    fi
    if [[ $capacity == "100" ]]; then
        echo $(date)" 已充满" >>"$MODDIR"/log.log
        sed -i "/^description=/c description=已充满" "$MODDIR/module.prop"
    fi
        if [[ $capacity == "99" ]]; then
        echo $(date)" 已充满" >>"$MODDIR"/log.log
        sed -i "/^description=/c description=性能模式无温控，改最大电流目录在模块根目录current_target 默认为22A｜temp_limit是高温降流阀值 current_limit是指定高温降流电流｜充电log位置也在模块根目录" "$MODDIR/module.prop"
    fi
    sleep 60
done
