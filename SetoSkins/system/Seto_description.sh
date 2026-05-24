#!/system/bin/sh
# Seto_description.sh - Dynamic module description updater
# Launched by service.sh via system/*.sh glob, or by WebUI hot-reload

SCRIPT_DIR=${0%/*}
MODDIR=${SCRIPT_DIR%/*}

PERSISTENT_DIR="/data/adb/SetoSkins"

show_value() {
    local file="$MODDIR/配置.prop"
    [ -f "$PERSISTENT_DIR/配置.prop" ] && file="$PERSISTENT_DIR/配置.prop"
    grep "^$1=" "$file" 2>/dev/null | head -n1 | cut -d'=' -f2
}

# Wait for boot
while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 2; done

# Check if feature is enabled
if [ "$(show_value '模块简介显示充电信息')" != "true" ]; then
    exit 0
fi

minus="-1"
[ -f "$MODDIR/system/minus" ] && minus=$(cat "$MODDIR/system/minus")

while true; do
    sleep 6

    status=$(cat /sys/class/power_supply/battery/status 2>/dev/null)
    capacity=$(cat /sys/class/power_supply/battery/capacity 2>/dev/null)
    raw_temp=$(cat /sys/class/power_supply/battery/temp 2>/dev/null)
    temp=$((raw_temp / 10))
    raw_current=$(cat /sys/class/power_supply/battery/current_now 2>/dev/null)
    current=$((raw_current * minus))
    ChargemA=$((raw_current / -1000))

    hint="DisCharging"
    if [ "$status" = "Charging" ]; then
        hint="NormallyCharging"
        [ "$current" -lt 2000000 ] 2>/dev/null && hint="LowCurrent"
        [ "$temp" -gt 48 ] 2>/dev/null && hint="HighTemperature"
    fi

    if [ "$capacity" = "100" ]; then
        sed -i "/^description=/c description=[ 😊已充满 温度${temp}℃ 电流${ChargemA}mA ]" "$MODDIR/module.prop"
    elif [ "$hint" = "DisCharging" ]; then
        sed -i "/^description=/c description=[ 🔋未充电 ] Seto Thermal | 使用WebUI配置" "$MODDIR/module.prop"
        setprop ctl.restart mi_thermald 2>/dev/null
        setprop ctl.restart thermal 2>/dev/null
        echo 1 >/sys/class/thermal/thermal_message/sconfig 2>/dev/null
    elif [ "$hint" = "NormallyCharging" ]; then
        sed -i "/^description=/c description=[ ✅正常充电中 温度${temp}℃ 电流${ChargemA}mA ] Seto Thermal" "$MODDIR/module.prop"
    elif [ "$hint" = "LowCurrent" ]; then
        sed -i "/^description=/c description=[ ⚠️充电缓慢 电量${capacity}% 温度${temp}℃ 电流${ChargemA}mA ] Seto Thermal" "$MODDIR/module.prop"
        echo '0' >/sys/class/power_supply/usb/input_current_limited 2>/dev/null
    elif [ "$hint" = "HighTemperature" ]; then
        sed -i "/^description=/c description=[ 🥵太烧了 温度${temp}℃ 电流${ChargemA}mA ] Seto Thermal" "$MODDIR/module.prop"
    fi

    # Re-check in case user toggled off via WebUI
    VAL=$(show_value '模块简介显示充电信息')
    if [ "$VAL" != "true" ]; then
        sed -i "/^description=/c description=Multi-function thermal control for MIUI/HyperOS | Supports Magisk, KernelSU, SukiSU" "$MODDIR/module.prop"
        exit 0
    fi
done
