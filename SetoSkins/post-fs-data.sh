#!/system/bin/sh
MODDIR=${0%/*}
GUARD="$MODDIR/system/cloud/HyperOS-Thermal-Refresh-Guard/Seto_refresh_guard.sh"
[ -f "$GUARD" ] && sh "$GUARD" early
