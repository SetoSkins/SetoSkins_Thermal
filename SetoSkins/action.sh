#!/system/bin/sh
MODDIR=${0%/*}
MODULE_ID="SetoSkins"

# KernelSU / SukiSU / APatch: WebUI is handled natively by the manager
# This action.sh is primarily for Magisk environments

# If running under Magisk, try to launch WebUI standalone apps
if [ -n "$MAGISKTMP" ] || [ -z "$KSU" ]; then
    # Try KSU WebUI Standalone
    pm path io.github.a13e300.ksuwebui > /dev/null 2>&1 && {
        echo "- Launching WebUI in KSU WebUI Standalone..."
        am start -n "io.github.a13e300.ksuwebui/.WebUIActivity" \
            -e id "$MODULE_ID" \
            -e name "Seto Thermal" > /dev/null 2>&1
        exit 0
    }

    # Try WebUI X (MMRL)
    pm path com.dergoogler.mmrl.wx > /dev/null 2>&1 && {
        echo "- Launching WebUI in WebUI X..."
        am start -n "com.dergoogler.mmrl.wx/.ui.activity.webui.WebUIActivity" \
            -e MOD_ID "$MODULE_ID" > /dev/null 2>&1
        exit 0
    }

    # Try WebUI X Portable
    pm path com.dergoogler.mmrl.webuix > /dev/null 2>&1 && {
        echo "- Launching WebUI in WebUI X Portable..."
        am start -n "com.dergoogler.mmrl.webuix/.ui.activity.webui.WebUIActivity" \
            -e MOD_ID "$MODULE_ID" > /dev/null 2>&1
        exit 0
    }

    # No WebUI app found - show text-based status
    echo "================================================"
    echo "  Seto Thermal - Module Status"
    echo "================================================"
    echo ""
    echo "  No WebUI app found."
    echo "  Install one of the following to use WebUI:"
    echo "  - KSU WebUI Standalone"
    echo "  - WebUI X (MMRL)"
    echo ""
    echo "  Current battery status:"
    temp=$(cat /sys/class/power_supply/battery/temp 2>/dev/null)
    current=$(cat /sys/class/power_supply/battery/current_now 2>/dev/null)
    capacity=$(cat /sys/class/power_supply/battery/capacity 2>/dev/null)
    status=$(cat /sys/class/power_supply/battery/status 2>/dev/null)
    [ -n "$temp" ] && echo "  Temperature: $(expr $temp / 10)°C"
    [ -n "$current" ] && echo "  Current: $(expr $current / -1000) mA"
    [ -n "$capacity" ] && echo "  Battery: ${capacity}%"
    [ -n "$status" ] && echo "  Status: $status"
    echo ""
    echo "  Config: $MODDIR/配置.prop"
    echo "================================================"
else
    # KSU/APatch environment but action.sh was called
    # (shouldn't normally happen - WebUI button is separate)
    echo "- Use the WebUI button in your manager app."
fi
