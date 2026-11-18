#!/system/bin/sh
MODDIR=${0%/*}
echo '=== HyperOS Thermal Refresh Guard ==='
echo "Device: $(getprop ro.product.device) / $(getprop ro.product.model)"
echo "ROM: $(getprop ro.build.version.incremental)"
echo '--- Installed capability ---'
cat "$MODDIR/compatibility.txt" 2>/dev/null || true
echo '--- Early boot ---'
cat "$MODDIR/boot-status.txt" 2>/dev/null || true
echo '--- Framework ---'
cat "$MODDIR/framework-status.txt" 2>/dev/null || true
echo '--- Runtime readback ---'
echo "property=$(getprop ro.vendor.fps.switch.thermal)"
echo "framework_setting=$(settings get system thermal_limit_refresh_rate 2>/dev/null)"
echo 'All checks above are read-only.'
