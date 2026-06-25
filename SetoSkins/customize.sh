#!/system/bin/sh

##########################
# Language Detection
##########################
sys_lang=$(getprop persist.sys.locale 2>/dev/null || getprop ro.product.locale 2>/dev/null || echo "")
sys_lang=$(echo "$sys_lang" | tr '[:upper:]' '[:lower:]')

is_zh() {
    echo "$sys_lang" | grep -qE '^zh' && return 0 || return 1
}

lang_print() {
    if is_zh; then
        echo "$1"
    else
        echo "$2"
    fi
}

##########################
# Root Manager Detection
##########################
ROOT_MANAGER="magisk"
if [ -n "$KSU" ]; then
    if [ -n "$KSU_SUKISU" ] || [ -n "$SUKISU" ]; then
        ROOT_MANAGER="sukisu"
        lang_print "- 检测到: SukiSU Ultra" "- Detected: SukiSU Ultra"
    else
        ROOT_MANAGER="ksu"
        lang_print "- 检测到: KernelSU" "- Detected: KernelSU"
    fi
    lang_print "- KSU 版本: ${KSU_VER:-unknown} (${KSU_VER_CODE:-?})" "- KSU Version: ${KSU_VER:-unknown} (${KSU_VER_CODE:-?})"
elif [ -n "$SUKISU" ]; then
    ROOT_MANAGER="sukisu"
    lang_print "- 检测到: SukiSU Ultra" "- Detected: SukiSU Ultra"
    lang_print "- SukiSU 版本: ${SUKISU_VER:-unknown}" "- SukiSU Version: ${SUKISU_VER:-unknown}"
else
    lang_print "- 检测到: Magisk ${MAGISK_VER:-unknown} (${MAGISK_VER_CODE:-?})" "- Detected: Magisk ${MAGISK_VER:-unknown} (${MAGISK_VER_CODE:-?})"
fi

# Save root manager type for runtime scripts
echo "$ROOT_MANAGER" > "$MODPATH/root_manager"

##########################
# Helper Functions
##########################
identify() {
    a=$(getprop ro.product.vendor.brand)
    if [[ ! $a == "Xiaomi" ]] && [[ ! $a == "Redmi" ]]; then
        lang_print "- 非小米/红米设备，不支持" "- Not a Xiaomi/Redmi device, not supported"
        abort "$(lang_print '非小米/红米设备，不支持' 'Not a Xiaomi/Redmi device, not supported')"
    fi
}

##########################
# Pre-installation Cleanup
##########################
status=$(cat /sys/class/power_supply/battery/status 2>/dev/null) || status=""
current=$(cat /sys/class/power_supply/battery/current_now 2>/dev/null) || current=""
if [ -f "/data/adb/service.d/seto2.sh" ]; then
    lang_print "- 正在清理残留文件..." "- Cleaning up residual files..."
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
lang_print "- Seto 温控 __VERSION__" "- Seto Thermal __VERSION__"
lang_print "- 新增: WebUI 配置界面" "- New: WebUI configuration interface"
lang_print "- 新增: 热重载 (无需重启)" "- New: Hot-reload (no reboot needed)"
lang_print "- 新增: 多语言支持" "- New: Multi-language support"
ui_print "—————————————————————————"
sleep 0.5

if [ -d "/data/media/0/Android/备份温控（请勿删除）" ]; then
    sleep 4
fi

##########################
# Config Restore (automatic)
##########################
PERSISTENT_DIR="/data/adb/SetoSkins"
mkdir -p "$PERSISTENT_DIR" 2>/dev/null || true

# 检测旧模块目录是否有配置文件
OLD_MODULE="/data/adb/modules/SetoSkins"
if [ -f "$OLD_MODULE/配置.prop" ] || [ -f "$OLD_MODULE/黑名单.prop" ] || [ -f "$OLD_MODULE/无温控应用.prop" ]; then
    lang_print "- 检测到旧配置文件，正在备份..." "- Detected old config files, backing up..."
    [ -f "$OLD_MODULE/配置.prop" ] && cp -f "$OLD_MODULE/配置.prop" "$PERSISTENT_DIR/配置.prop" 2>/dev/null || true
    [ -f "$OLD_MODULE/黑名单.prop" ] && cp -f "$OLD_MODULE/黑名单.prop" "$PERSISTENT_DIR/黑名单.prop" 2>/dev/null || true
    [ -f "$OLD_MODULE/无温控应用.prop" ] && cp -f "$OLD_MODULE/无温控应用.prop" "$PERSISTENT_DIR/无温控应用.prop" 2>/dev/null || true
    lang_print "- 旧配置已备份到 /data/adb/SetoSkins/" "- Old config backed up to /data/adb/SetoSkins/"
fi

# 从持久化目录恢复配置
if [ -f "$PERSISTENT_DIR/配置.prop" ]; then
    lang_print "- 找到已保存配置，自动恢复中" "- Found saved config, restoring automatically"
    cp -f "$PERSISTENT_DIR/配置.prop" "$MODPATH/配置.prop" 2>/dev/null || true
    [ -f "$PERSISTENT_DIR/黑名单.prop" ] && cp -f "$PERSISTENT_DIR/黑名单.prop" "$MODPATH/黑名单.prop" || true
    [ -f "$PERSISTENT_DIR/无温控应用.prop" ] && cp -f "$PERSISTENT_DIR/无温控应用.prop" "$MODPATH/无温控应用.prop" || true
    lang_print "- 配置已从 /data/adb/SetoSkins/ 恢复" "- Config restored from /data/adb/SetoSkins/"
else
    lang_print "- 首次安装，使用默认配置" "- First install, using default config"
    identify
fi

# 开机后3秒强制覆盖配置
if [ -f "$PERSISTENT_DIR/配置.prop" ]; then
    cat > /data/adb/service.d/seto_restore_config.sh << 'RESTOREEOF'
#!/system/bin/sh
sleep 3
PERSISTENT_DIR="/data/adb/SetoSkins"
MODULE_DIR="/data/adb/modules/SetoSkins"
if [ -d "$MODULE_DIR" ] && [ -f "$PERSISTENT_DIR/配置.prop" ]; then
    cp -f "$PERSISTENT_DIR/配置.prop" "$MODULE_DIR/配置.prop" 2>/dev/null
    [ -f "$PERSISTENT_DIR/黑名单.prop" ] && cp -f "$PERSISTENT_DIR/黑名单.prop" "$MODULE_DIR/黑名单.prop" 2>/dev/null
    [ -f "$PERSISTENT_DIR/无温控应用.prop" ] && cp -f "$PERSISTENT_DIR/无温控应用.prop" "$MODULE_DIR/无温控应用.prop" 2>/dev/null
fi
rm -f /data/adb/service.d/seto_restore_config.sh
RESTOREEOF
    chmod 755 /data/adb/service.d/seto_restore_config.sh 2>/dev/null || true
fi
ui_print "—————————————————————————"
lang_print "- 如温控无效，请确保系统已更新。" "- If thermal control is ineffective, make sure your system is up to date."
lang_print "- 如降亮度或充电变慢，请在配置中开启温控空文件挂载。" "- Enable empty thermal file mount in config if brightness drops or charging slows."
ui_print "—————————————————————————"

##########################
# Thermal Setup
##########################
chattr -i /data/vendor/thermal/ 2>/dev/null || true
[[ -d /data/vendor/thermal ]] && chattr -i /data/vendor/thermal/ 2>/dev/null || true
rm -rf /data/vendor/thermal/config/* 2>/dev/null || true

##########################
# Remove Conflicting Modules
##########################
remove_all_modules() {
    local module_id
    for i in $(find /data/adb/modules* -name module.prop 2>/dev/null); do
        module_id=$(awk -F= '/id=/ {print $2}' "$i")
        case "$module_id" in
        "MIUI_Optimization" | "chargeauto" | "fuck_miui_thermal" | "He_zheng" | "JE" | "turbo-charge")
            sh "$(dirname $i)/uninstall.sh" 2>/dev/null || true
            chattr -i "$(dirname $i)"* 2>/dev/null || true
            chmod 666 "$(dirname $i)"* 2>/dev/null || true
            rm -rf "$(dirname $i)"* 2>/dev/null || true
            touch "$(dirname $i)"* 2>/dev/null || true
            chattr -i "$(dirname $i)" 2>/dev/null || true
            ;;
        esac
    done
}
remove_all_modules

##########################
# Thermal Folder Init
##########################
mk_thermal_folder() {
    resetprop -n sys.thermal.data.path /data/vendor/thermal/ 2>/dev/null || true
    resetprop -n vendor.sys.thermal.data.path /data/vendor/thermal/ 2>/dev/null || true
    chattr -R -i -a '/data/vendor/thermal' 2>/dev/null || true
    rm -rf '/data/vendor/thermal' 2>/dev/null || true
    mkdir -p '/data/vendor/thermal/config' 2>/dev/null || true
    chmod -R 0771 '/data/vendor/thermal' 2>/dev/null || true
    chown -R root:system '/data/vendor/thermal' 2>/dev/null || true
    chcon -R 'u:object_r:vendor_data_file:s0' '/data/vendor/thermal' 2>/dev/null || true
}

restart_mi_thermald() {
    pkill -9 -f mi_thermald 2>/dev/null || true
    pkill -9 -f thermal-engine 2>/dev/null || true
    for i in $(which -a thermal-engine 2>/dev/null); do
        nohup "$i" >/dev/null 2>&1 &
    done
    for i in $(which -a mi_thermald 2>/dev/null); do
        nohup "$i" >/dev/null 2>&1 &
    done
    killall -15 mi_thermald 2>/dev/null || true
    for i in $(which -a mi_thermald 2>/dev/null); do
        nohup "$i" >/dev/null 2>&1 &
    done
    setprop ctl.restart thermal-engine 2>/dev/null || true
    setprop ctl.restart mi_thermald 2>/dev/null || true
    setprop ctl.restart thermal_manager 2>/dev/null || true
    setprop ctl.restart thermal 2>/dev/null || true
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
lang_print "- 配置位置: 模块根目录" "- Config location: Module root directory"
lang_print "- 使用 WebUI 进行实时配置 (无需重启)" "- Use WebUI for live configuration (no reboot needed)"
lang_print "- 自动移除冲突模块" "- Auto-removing conflicting modules"
lang_print "- 作者: SetoSkins | 感谢: SummerSK, shadow3, nakixii" "- Author: SetoSkins | Thanks: SummerSK, shadow3, nakixii"

# Thanox integration
thanos=$(find /data/system/ -type d -name 'thanos*' 2>/dev/null) || thanox=""
if [ -d "$thanos" ]; then
    lang_print "- 检测到 Thanox" "- Thanox detected"
    chmod 777 /data/system/*thanos* 2>/dev/null || true
    if [ ! -d "$thanos/profile_user_io" ]; then
        lang_print "- 正在创建 profile_user_io" "- Creating profile_user_io"
        mkdir -v "$thanos/profile_user_io" 2>/dev/null || true
    fi
fi

# Cleanup
rm -rf /data/system/package_cache/* 2>/dev/null || true
rm -rf /data/adb/1 2>/dev/null || true
lang_print "- 缓存已清理" "- Cache cleaned"
rm -rf /data/media/0/Seto.zip 2>/dev/null || true
rm -rf /data/Seto.zip 2>/dev/null || true

# Backup original thermal configs
if [ ! -f /data/media/0/Android/备份温控（请勿删除）/thermal-normal.conf ]; then
    sleep 8
    mkdir -p /data/media/0/Android/备份温控（请勿删除） 2>/dev/null || true
    cp $(find /system/vendor/etc/ -type f -iname "thermal*.conf*" 2>/dev/null | grep -v /system/vendor/etc/thermal/) /data/media/0/Android/备份温控（请勿删除）/ 2>/dev/null || true
    if [ ! -f /data/media/0/Android/备份温控（请勿删除）/thermal-normal.conf ]; then
        rm -rf /data/media/0/Android/备份温控（请勿删除）/* 2>/dev/null || true
        cp /odm/etc/thermal* /sdcard/Android/备份温控（请勿删除）/ 2>/dev/null || true
    fi
fi

lang_print "- 安装完成！" "- Installation complete!"
