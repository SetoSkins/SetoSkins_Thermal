#!/system/bin/sh

##########################
# Root Manager Detection
##########################
if [ -n "$KSU" ]; then
    if [ -n "$KSU_SUKISU" ]; then
        ROOT_MANAGER="sukisu"
        ui_print "- Detected: SukiSU Ultra"
    else
        ROOT_MANAGER="ksu"
        ui_print "- Detected: KernelSU"
    fi
    ui_print "- KSU Version: $KSU_VER ($KSU_VER_CODE)"
else
    ROOT_MANAGER="magisk"
    ui_print "- Detected: Magisk $MAGISK_VER ($MAGISK_VER_CODE)"
fi

# Save root manager type for runtime scripts
echo "$ROOT_MANAGER" > "$MODPATH/root_manager"

##########################
# Helper Functions
##########################
key_check() {
  while true; do
    key_check=$(/system/bin/getevent -qlc 1)
    key_event=$(echo "$key_check" | awk '{ print $3 }' | grep 'KEY_')
    key_status=$(echo "$key_check" | awk '{ print $4 }')
    if [[ "$key_event" == *"KEY_"* && "$key_status" == "DOWN" ]]; then
      keycheck="$key_event"
      break
    fi
  done
  while true; do
    key_check=$(/system/bin/getevent -qlc 1)
    key_event=$(echo "$key_check" | awk '{ print $3 }' | grep 'KEY_')
    key_status=$(echo "$key_check" | awk '{ print $4 }')
    if [[ "$key_event" == *"KEY_"* && "$key_status" == "UP" ]]; then
      break
    fi
  done
}

identify() {
    a=$(getprop ro.product.vendor.brand)
    if [[ ! $a == "Xiaomi" ]] && [[ ! $a == "Redmi" ]]; then
        ui_print "- Unknown device brand. If using HyperOS/MIUI, press Volume Up to install."
        ui_print "- Volume Up = Install"
        ui_print "- Volume Down = Cancel"
        key_check
        case "$keycheck" in
        "KEY_VOLUMEUP")
            ui_print "- Continuing installation"
            ui_print "—————————————————————————"
            ;;
        *)
            abort "- Installation cancelled"
            ;;
        esac
    fi
}

##########################
# Pre-installation Cleanup
##########################
status=$(cat /sys/class/power_supply/battery/status)
current=$(cat /sys/class/power_supply/battery/current_now)
if [ -f "/data/adb/service.d/seto2.sh" ]; then
    ui_print "- Cleaning up residual files..."
    for i in $(seq 60); do
        if [ -f "/data/adb/service.d/seto.sh" ]; then
            sleep 1
        else
            break
        fi
    done
fi

##########################
# Changelog
##########################
ui_print "—————————————————————————"
ui_print "- Seto Thermal __VERSION__"
ui_print "- Now supports: Magisk / KernelSU / SukiSU"
ui_print "- New: WebUI configuration interface"
ui_print "- New: Hot-reload (no reboot needed)"
ui_print "- New: Multi-language support"
ui_print "—————————————————————————"
sleep 0.5

if [ -d "/data/media/0/Android/备份温控（请勿删除）" ]; then
    sleep 4
fi

##########################
# Config Restore (automatic)
##########################
PERSISTENT_DIR="/data/adb/SetoSkins"

if [ -f "$PERSISTENT_DIR/配置.prop" ]; then
    ui_print "- Found saved config, restoring automatically"
    cp -f "$PERSISTENT_DIR/配置.prop" "$MODPATH/配置.prop"
    [ -f "$PERSISTENT_DIR/黑名单.prop" ] && cp -f "$PERSISTENT_DIR/黑名单.prop" "$MODPATH/黑名单.prop"
    ui_print "- Config restored from /data/adb/SetoSkins/"
else
    ui_print "- First install, using default config"
    identify
    # Create persistent dir for future updates
    mkdir -p "$PERSISTENT_DIR"
fi

ui_print "—————————————————————————"
ui_print "- If thermal control is ineffective, make sure your system is up to date."
ui_print "- Enable empty thermal file mount in config if brightness drops or charging slows."
ui_print "—————————————————————————"

##########################
# Thermal Setup
##########################
chattr -i /data/vendor/thermal/ 2>/dev/null
[[ -d /data/vendor/thermal ]] && chattr -i /data/vendor/thermal/ 2>/dev/null
rm -rf /data/vendor/thermal/config/*

##########################
# Remove Conflicting Modules
##########################
remove_all_modules() {
    local module_id
    for i in $(find /data/adb/modules* -name module.prop 2>/dev/null); do
        module_id=$(awk -F= '/id=/ {print $2}' "$i")
        case "$module_id" in
        "MIUI_Optimization" | "chargeauto" | "fuck_miui_thermal" | "He_zheng" | "JE" | "turbo-charge")
            sh "$(dirname $i)/uninstall.sh" 2>/dev/null
            chattr -i "$(dirname $i)"* 2>/dev/null
            chmod 666 "$(dirname $i)"* 2>/dev/null
            rm -rf "$(dirname $i)"* 2>/dev/null
            touch "$(dirname $i)"* 2>/dev/null
            chattr -i "$(dirname $i)" 2>/dev/null
            ;;
        esac
    done
}
remove_all_modules

##########################
# Thermal Folder Init
##########################
mk_thermal_folder() {
    resetprop -n sys.thermal.data.path /data/vendor/thermal/
    resetprop -n vendor.sys.thermal.data.path /data/vendor/thermal/
    chattr -R -i -a '/data/vendor/thermal' 2>/dev/null
    rm -rf '/data/vendor/thermal'
    mkdir -p '/data/vendor/thermal/config'
    chmod -R 0771 '/data/vendor/thermal'
    chown -R root:system '/data/vendor/thermal'
    chcon -R 'u:object_r:vendor_data_file:s0' '/data/vendor/thermal'
}

restart_mi_thermald() {
    pkill -9 -f mi_thermald 2>/dev/null
    pkill -9 -f thermal-engine 2>/dev/null
    for i in $(which -a thermal-engine 2>/dev/null); do
        nohup "$i" >/dev/null 2>&1 &
    done
    for i in $(which -a mi_thermald 2>/dev/null); do
        nohup "$i" >/dev/null 2>&1 &
    done
    killall -15 mi_thermald 2>/dev/null
    for i in $(which -a mi_thermald 2>/dev/null); do
        nohup "$i" >/dev/null 2>&1 &
    done
    setprop ctl.restart thermal-engine 2>/dev/null
    setprop ctl.restart mi_thermald 2>/dev/null
    setprop ctl.restart thermal_manager 2>/dev/null
    setprop ctl.restart thermal 2>/dev/null
}

if [ ! -f /data/vendor/thermal/decrypt.txt ]; then
    mk_thermal_folder
    restart_mi_thermald
fi

##########################
# KSU-specific Setup
##########################
if [ "$ROOT_MANAGER" = "ksu" ] || [ "$ROOT_MANAGER" = "sukisu" ]; then
    # Set proper permissions for webroot
    if [ -d "$MODPATH/webroot" ]; then
        set_perm_recursive "$MODPATH/webroot" 0 0 0755 0644
    fi
    # Set permissions for action.sh
    if [ -f "$MODPATH/action.sh" ]; then
        set_perm "$MODPATH/action.sh" 0 0 0755
    fi
fi

##########################
# Finish
##########################
ui_print "- Config location: Module root directory"
ui_print "- Use WebUI for live configuration (no reboot needed)"
ui_print "- Auto-removing conflicting modules"
ui_print "- Author: SetoSkins | Thanks: SummerSK, shadow3, nakixii"

# Thanox integration
thanox=$(find /data/system/ -type d -name 'thanos*' 2>/dev/null)
if [ -d "$thanox" ]; then
    ui_print "- Thanox detected"
    chmod 777 /data/system/*thanos* 2>/dev/null
    if [ ! -d "$thanox/profile_user_io" ]; then
        ui_print "- Creating profile_user_io"
        mkdir -v "$thanox/profile_user_io"
    fi
fi

# Cleanup
rm -rf /data/system/package_cache/*
rm -rf /data/adb/1
ui_print "- Cache cleaned"
rm -rf /data/media/0/Seto.zip
rm -rf /data/Seto.zip

# Backup original thermal configs
if [ ! -f /data/media/0/Android/备份温控（请勿删除）/thermal-normal.conf ]; then
    sleep 8
    mkdir -p /data/media/0/Android/备份温控（请勿删除）
    cp $(find /system/vendor/etc/ -type f -iname "thermal*.conf*" 2>/dev/null | grep -v /system/vendor/etc/thermal/) /data/media/0/Android/备份温控（请勿删除）/ 2>/dev/null
    if [ ! -f /data/media/0/Android/备份温控（请勿删除）/thermal-normal.conf ]; then
        rm -rf /data/media/0/Android/备份温控（请勿删除）/*
        cp /odm/etc/thermal* /sdcard/Android/备份温控（请勿删除）/ 2>/dev/null
    fi
fi

ui_print "- Installation complete!"
