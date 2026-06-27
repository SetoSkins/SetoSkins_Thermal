#!/system/bin/sh
# Seto_description.sh - Dynamic module description updater
# Launched by service.sh via system/*.sh glob, or by WebUI hot-reload

SCRIPT_DIR=${0%/*}
MODDIR=${SCRIPT_DIR%/*}

# KSU/Magisk 兼容：自动检测模块目录
for candidate in "$MODDIR" "/data/adb/modules/SetoSkins"; do
    if [ -f "$candidate/module.prop" ]; then
        MODDIR="$candidate"
        break
    fi
done

PERSISTENT_DIR="/data/adb/modules/SetoSkins"

show_value() {
    local file="/data/adb/modules/SetoSkins/配置.prop"
    [ -f "$PERSISTENT_DIR/配置.prop" ] && file="$PERSISTENT_DIR/配置.prop"
    grep "^$1=" "$file" 2>/dev/null | head -n1 | cut -d'=' -f2
}

update_desc() {
    local new_desc="$1"
    local prop="$MODDIR/module.prop"
    [ ! -f "$prop" ] && return

    local escaped_desc
    escaped_desc=$(printf '%s' "$new_desc" | sed 's/[|&]/\\&/g')

    local tmp="${prop}.tmp"
    sed "s|^description=.*|description=${escaped_desc}|" "$prop" > "$tmp" && mv "$tmp" "$prop"

    chmod 644 "$prop" 2>/dev/null
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
        update_desc "[ 😊已充满 温度${temp}℃ 电流${ChargemA}mA ]"
    elif [ "$hint" = "DisCharging" ]; then
        update_desc "[ 🔋未充电 ] Seto Thermal | 使用WebUI配置"
        setprop ctl.restart mi_thermald 2>/dev/null
        setprop ctl.restart thermal 2>/dev/null
        echo 1 >/sys/class/thermal/thermal_message/sconfig 2>/dev/null
    elif [ "$hint" = "NormallyCharging" ]; then
        update_desc "[ ✅正常充电中 温度${temp}℃ 电流${ChargemA}mA ] Seto Thermal"
    elif [ "$hint" = "LowCurrent" ]; then
        update_desc "[ ⚠️充电缓慢 电量${capacity}% 温度${temp}℃ 电流${ChargemA}mA ] Seto Thermal"
        echo '0' >/sys/class/power_supply/usb/input_current_limited 2>/dev/null
    elif [ "$hint" = "HighTemperature" ]; then
        update_desc "[ 🥵太烧了 温度${temp}℃ 电流${ChargemA}mA ] Seto Thermal"
    fi

    # Re-check in case user toggled off via WebUI
    VAL=$(show_value '模块简介显示充电信息')
    if [ "$VAL" != "true" ]; then
        update_desc "Multi-function thermal control for MIUI/HyperOS | Supports Magisk, KernelSU, SukiSU"
        exit 0
    fi
done
